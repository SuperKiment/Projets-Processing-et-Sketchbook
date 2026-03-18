// ============================================
// Munition.pde - Classe Munition + ZoneFeu
// ============================================

ArrayList<Munition> AllMunitions = new ArrayList<Munition>();
ArrayList<ZoneFeu> AllZonesFeu = new ArrayList<ZoneFeu>();

// --- Zone de feu (incendiaire) ---

class ZoneFeu {
  float x, y, rayon;
  float timer, duree;
  float degatsParTick;
  float dernierDegat;

  ZoneFeu(float nx, float ny, float nr, float nd, float dd) {
    x = nx; y = ny; rayon = nr; duree = nd;
    degatsParTick = dd;
    timer = millis();
    dernierDegat = millis();
  }

  void Fonctions() {
    float vie = 1.0 - (millis() - timer) / duree;
    // Dégâts périodiques
    if (millis() - dernierDegat >= 500) {
      for (Tank t : AllTanks) {
        if (!t.vivant) continue;
        if (dist(x, y, t.x, t.y) < rayon) {
          t.PrendreDegas(degatsParTick);
        }
      }
      dernierDegat = millis();
    }
    // Visuels
    if (random(1) > 0.5) FeuParticules(x + random(-rayon/2, rayon/2), y + random(-rayon/2, rayon/2), 1);
    push();
    noStroke();
    fill(#FF4400, vie * 25);
    ellipse(x, y, rayon * 2, rayon * 2);
    pop();
  }

  boolean Mort() { return millis() - timer >= duree; }
}

void Fonctions_ZonesFeu() {
  for (int i = AllZonesFeu.size() - 1; i >= 0; i--) {
    AllZonesFeu.get(i).Fonctions();
    if (AllZonesFeu.get(i).Mort()) AllZonesFeu.remove(i);
  }
}

// --- Munition ---

class Munition {
  float x, y, ori, speed;
  float timer;
  int rebonds = 0;
  TypeMunition type;
  int proprietaireId;
  boolean aSupprimer = false;
  float multDegats = 1.0;

  // Boomerang state
  boolean boomerangReverse = false;
  // Mine state
  boolean mineActive = false;

  Munition(float nx, float ny, float nori, TypeMunition t, int propId) {
    x = nx; y = ny; ori = nori;
    type = t; speed = t.vitesse;
    timer = millis(); proprietaireId = propId;
  }

  void Fonction() {
    String comp = type.comportement;

    // === MINE : comportement totalement custom ===
    if (comp.equals("mine")) {
      FonctionMine();
      return;
    }

    // === GUIDEE : ajuster l'orientation ===
    if (comp.equals("guidee")) {
      Tank owner = TrouverTank(proprietaireId);
      if (owner != null && owner.vivant) {
        float target = owner.dir;
        float diff = target - ori;
        while (diff > PI) diff -= TWO_PI;
        while (diff < -PI) diff += TWO_PI;
        ori += diff * 0.06;
      }
    }

    // === GRENADE : décélération ===
    if (comp.equals("grenade")) {
      speed *= 0.96;
    }

    // === BOOMERANG : demi-tour ===
    if (comp.equals("boomerang") && !boomerangReverse) {
      if (millis() - timer > type.dureeVie * 0.4) {
        ori += PI;
        boomerangReverse = true;
        EtincellesDir(x, y, 6, ori, PI/4, 3, type.couleur);
      }
    }

    // === COLLISION MURS ===
    float nextX = x + speed * cos(ori);
    float nextY = y + speed * sin(ori);

    for (int i = 0; i < AllMurs.size(); i++) {
      Mur mur = AllMurs.get(i);
      if (mur.DansMur(nextX, nextY)) {
        if (type.placeMur) {
          PlacerMur(x, y);
          aSupprimer = true;
          return;
        }
        if (mur.EstDestructible()) {
          mur.PrendreDegas(1);
          BoumParticulesCouleur(x, y, 10, 20, 5, mur.couleur);
          FumeeParticules(x, y, 4);
          aSupprimer = true;
          return;
        }
        String cote = CoteRect(x, y, mur.x, mur.y, mur.tailleX, mur.tailleY);
        ori = ReflexionAngle(ori, cote);
        rebonds++;
        // Ricochet : accélère au rebond
        if (comp.equals("ricochet")) {
          speed *= 1.15;
        } else {
          speed *= 0.85;
        }
        EtincellesDir(x, y, 8, ori + PI, PI/3, 4, type.couleur);
        FumeeParticules(x, y, 3);
        break;
      }
    }

    // === COLLISION TANKS ===
    for (int i = 0; i < AllTanks.size(); i++) {
      Tank tank = AllTanks.get(i);
      if (tank.joueurId == proprietaireId && millis() - timer < 200) continue;
      if (!tank.vivant) continue;
      if (tank.DansTank(x, y)) {
        if (comp.equals("emp")) {
          // Ralentissement au lieu de dégâts
          tank.boosts.add(new BoostActif("ralenti", 0.3, 3000));
          BoumParticulesCouleur(x, y, 15, 35, 6, type.couleur);
        } else {
          if (type.degats > 0) tank.PrendreDegas(type.degats * multDegats);
          BoumParticulesCouleur(x, y, 15, 30, 6, type.couleur);
        }
        FumeeParticules(x, y, 5);
        if (type.explose) Exploser();
        if (type.placeMur) PlacerMur(x, y);
        if (!type.perce) {
          aSupprimer = true;
          return;
        }
        // Laser perce : continue sans mourir
      }
    }

    // === DEPLACEMENT ===
    x += speed * cos(ori);
    y += speed * sin(ori);

    // === INCENDIAIRE : zones de feu ===
    if (comp.equals("incendiaire") && frameCount % 6 == 0) {
      AllZonesFeu.add(new ZoneFeu(x, y, 18, 2500, 0.5));
    }

    // === AFFICHAGE ===
    Afficher();
  }

  void Afficher() {
    push();
    noStroke();
    String comp = type.comportement;

    if (type.placeMur) {
      fill(type.couleur, 40);
      rectMode(CENTER);
      rect(x, y, type.taille * 2, type.taille * 2);
      fill(type.couleur);
      rect(x, y, type.taille, type.taille * 0.6);
    } else if (comp.equals("laser")) {
      // Trait laser
      stroke(type.couleur);
      strokeWeight(type.taille);
      float len = speed * 0.8;
      line(x - cos(ori) * len, y - sin(ori) * len, x, y);
      noStroke();
      fill(255, 200);
      ellipse(x, y, type.taille * 0.8, type.taille * 0.8);
    } else if (comp.equals("grenade")) {
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      ellipse(x, y, type.taille, type.taille);
      // Timer visuel
      float vie = (millis() - timer) / type.dureeVie;
      fill(#FF0000, vie * 200);
      ellipse(x, y, type.taille * 0.6, type.taille * 0.6);
    } else if (comp.equals("guidee")) {
      // Flamme arrière du missile
      fill(#FF4400, 150);
      float bx = x - cos(ori) * type.taille;
      float by = y - sin(ori) * type.taille;
      ellipse(bx, by, 8, 8);
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      // Forme pointue
      pushMatrix();
      translate(x, y);
      rotate(ori);
      triangle(-type.taille/2, -type.taille/3, -type.taille/2, type.taille/3, type.taille/2, 0);
      popMatrix();
    } else {
      // Standard
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      ellipse(x, y, type.taille, type.taille);
      fill(255, 200);
      ellipse(x, y, type.taille * 0.4, type.taille * 0.4);
      // Traînée
      float tx = x - cos(ori) * type.taille * 1.2;
      float ty = y - sin(ori) * type.taille * 1.2;
      fill(type.couleur, 60);
      ellipse(tx, ty, type.taille * 0.5, type.taille * 0.5);
    }
    pop();

    // Particules de traînée
    if (random(1) > 0.6 && !type.comportement.equals("mine")) {
      color trailC = type.couleur;
      if (type.comportement.equals("incendiaire")) trailC = lerpColor(#FF4400, #FFCC00, random(1));
      AllParticules.add(new Particule(
        x + random(-3, 3), y + random(-3, 3),
        random(2, 4), trailC, random(150, 350),
        -cos(ori) * 0.5, -sin(ori) * 0.5, 0.9, true
      ));
    }
  }

  // === MINE ===
  void FonctionMine() {
    float elapsed = millis() - timer;
    boolean active = elapsed >= 2000;

    if (active && !mineActive) {
      mineActive = true;
    }

    // Détection proximité
    if (mineActive) {
      for (Tank t : AllTanks) {
        if (t.joueurId == proprietaireId) continue;
        if (!t.vivant) continue;
        if (dist(x, y, t.x, t.y) < 40) {
          Exploser();
          aSupprimer = true;
          return;
        }
      }
    }

    // Affichage mine
    push();
    noStroke();
    float pulse = mineActive ? (sin(millis() * 0.01) * 0.3 + 0.7) : 0.3;
    fill(type.couleur, pulse * 120);
    ellipse(x, y, type.taille * 1.5, type.taille * 1.5);
    fill(type.couleur, pulse * 255);
    ellipse(x, y, type.taille * 0.6, type.taille * 0.6);
    if (mineActive) {
      noFill();
      stroke(type.couleur, pulse * 80);
      strokeWeight(1);
      ellipse(x, y, 40, 40); // rayon de détection
    }
    pop();
  }

  void PlacerMur(float mx, float my) {
    Mur m = new Mur(mx, my, type.murTailleX, type.murTailleY);
    m.RendreDestructible(type.murHp);
    m.couleur = lerpColor(type.couleur, COULEUR_MUR, 0.5);
    AllMurs.add(m);
    BoumParticulesCouleur(mx, my, 12, 25, 5, type.couleur);
  }

  void AffichageSeul() {
    push();
    noStroke();
    if (type.placeMur) {
      fill(type.couleur);
      rectMode(CENTER);
      rect(x, y, type.taille, type.taille * 0.6);
    } else {
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      ellipse(x, y, type.taille, type.taille);
    }
    pop();
  }

  void Exploser() {
    FeuParticules(x, y, 25);
    BoumParticulesCouleur(x, y, 15, (int)type.rayonExplosion, 8, #FF6600);
    FumeeParticules(x, y, 10);
    for (Tank t : AllTanks) {
      if (!t.vivant) continue;
      if (dist(x, y, t.x, t.y) < type.rayonExplosion) {
        t.PrendreDegas(type.degats * multDegats);
      }
    }
    for (Mur m : AllMurs) {
      if (m.EstDestructible() && dist(x, y, m.x, m.y) < type.rayonExplosion) {
        m.PrendreDegas(2);
      }
    }
  }

  boolean Mort() {
    if (aSupprimer) return true;
    if (millis() - timer >= type.dureeVie) return true;
    if (rebonds > type.rebondsMax) return true;
    if (x < -50 || x > LARGEUR + 50 || y < -50 || y > HAUTEUR + 50) return true;
    return false;
  }
}

Tank TrouverTank(int id) {
  for (Tank t : AllTanks) {
    if (t.joueurId == id) return t;
  }
  return null;
}

void Fonctions_Munitions() {
  for (int i = AllMunitions.size() - 1; i >= 0; i--) {
    Munition mun = AllMunitions.get(i);
    mun.Fonction();
    if (mun.Mort()) {
      // Cluster : sous-projectiles
      if (mun.type.comportement.equals("cluster") && !mun.aSupprimer) {
        TypeMunition subType = TypesMunitions.get("standard");
        for (int j = 0; j < 5; j++) {
          float angle = TWO_PI * j / 5 + random(-0.3, 0.3);
          Munition sub = new Munition(mun.x, mun.y, angle, subType, mun.proprietaireId);
          sub.speed = 8;
          AllMunitions.add(sub);
        }
        BoumParticulesCouleur(mun.x, mun.y, 15, 30, 5, mun.type.couleur);
      }
      // Grenade qui expire = explosion
      else if (mun.type.comportement.equals("grenade") && !mun.aSupprimer) {
        mun.Exploser();
      }
      // Mur qui expire naturellement
      else if (mun.type.placeMur && !mun.aSupprimer) {
        mun.PlacerMur(mun.x, mun.y);
      }
      // Disparition normale
      else if (!mun.aSupprimer) {
        BoumParticulesCouleur(mun.x, mun.y, 5, 15, 3, mun.type.couleur);
      }
      AllMunitions.remove(i);
    }
  }
}
