// ============================================
// Munition.pde - Classe Munition + ZoneFeu
// ============================================

ArrayList<Munition> AllMunitions = new ArrayList<Munition>();
ArrayList<ZoneFeu> AllZonesFeu = new ArrayList<ZoneFeu>();
ArrayList<ZoneFumee> AllZonesFumee = new ArrayList<ZoneFumee>();

// --- Zone de fumée (fumigène) ---

class ZoneFumee {
  float x, y, rayon;
  float timer, duree;

  ZoneFumee(float nx, float ny, float nr, float nd) {
    x = nx; y = ny; rayon = nr; duree = nd;
    timer = millis();
  }

  void Fonctions() {
    float vie = 1.0 - (millis() - timer) / duree;
    // Particules de fumée
    if (random(1) > 0.3) {
      AllParticules.add(new Particule(
        x + random(-rayon, rayon), y + random(-rayon, rayon),
        random(6, 14), lerpColor(#555555, #999999, random(1)), random(300, 800),
        random(-0.5, 0.5), random(-1, -0.3), 0.95, false
      ));
    }
    // Zone visuelle
    push();
    noStroke();
    fill(#888888, vie * 40);
    ellipse(x, y, rayon * 2, rayon * 2);
    fill(#AAAAAA, vie * 25);
    ellipse(x, y, rayon * 1.4, rayon * 1.4);
    pop();
  }

  boolean Mort() { return millis() - timer >= duree; }
}

void Fonctions_ZonesFumee() {
  for (int i = AllZonesFumee.size() - 1; i >= 0; i--) {
    AllZonesFumee.get(i).Fonctions();
    if (AllZonesFumee.get(i).Mort()) AllZonesFumee.remove(i);
  }
}

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
  // Tanks déjà touchés (pour munitions perçantes comme plasma/laser)
  ArrayList<Integer> tanksTouches = new ArrayList<Integer>();

  Munition(float nx, float ny, float nori, TypeMunition t, int propId) {
    x = nx; y = ny; ori = nori;
    type = t; speed = t.vitesse * echelleMap();
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

    // === ASPIRANTE : homing vers l'ennemi le plus proche ===
    if (comp.equals("aspirante")) {
      Tank cible = null;
      float minDist = 300; // rayon de détection
      for (Tank t : AllTanks) {
        if (t.joueurId == proprietaireId || !t.vivant) continue;
        float d = dist(x, y, t.x, t.y);
        if (d < minDist) { minDist = d; cible = t; }
      }
      if (cible != null) {
        float target = atan2(cible.y - y, cible.x - x);
        float diff = target - ori;
        while (diff > PI) diff -= TWO_PI;
        while (diff < -PI) diff += TWO_PI;
        ori += diff * 0.04;
      }
    }

    // === METEORE : grossit et ralentit ===
    if (comp.equals("meteore")) {
      speed *= 0.995;
      // Tremblements de l'écran simulés par particules
      if (frameCount % 3 == 0) {
        FeuParticules(x + random(-10, 10), y + random(-10, 10), 2);
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

    // === FORAGE : particules de foreuse ===
    if (comp.equals("forage")) {
      if (frameCount % 2 == 0) {
        EtincellesDir(x, y, 2, ori + PI, PI/2, 2, type.couleur);
      }
    }

    // === COLLISION MURS ===
    float nextX = x + speed * cos(ori);
    float nextY = y + speed * sin(ori);

    // Plasma traverse les murs (pas les bordures)
    if (comp.equals("plasma")) {
      // Ne rebondit que sur les bordures (les 4 premiers murs)
      for (int i = 0; i < min(4, AllMurs.size()); i++) {
        Mur mur = AllMurs.get(i);
        if (mur.DansMur(nextX, nextY)) {
          aSupprimer = true;
          BoumParticulesCouleur(x, y, 8, 20, 4, type.couleur);
          return;
        }
      }
    }
    // Forage détruit tous les murs au contact
    else if (comp.equals("forage")) {
      for (int i = AllMurs.size() - 1; i >= 0; i--) {
        Mur mur = AllMurs.get(i);
        if (mur.DansMur(nextX, nextY)) {
          // Détruit le mur, même indestructible (sauf bordures = 4 premiers murs)
          if (i >= 4) {
            mur.hp = 0;
            mur.type = "destructible";
            BoumParticulesCouleur(mur.x, mur.y, 15, 30, 6, mur.couleur);
            FumeeParticules(mur.x, mur.y, 6);
          } else {
            // Bordure : rebondir
            String cote = CoteRect(x, y, mur.x, mur.y, mur.tailleX, mur.tailleY);
            ori = ReflexionAngle(ori, cote);
            EtincellesDir(x, y, 8, ori + PI, PI/3, 4, type.couleur);
          }
          break;
        }
      }
    }
    else {
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
          // Pitch selon vitesse et taille : rapide/petit = aigu, lent/gros = grave
          float pitchVitesse = constrain(speed / 8.0, 0.6, 1.5);
          float pitchTaille = constrain(map(type.taille, 3, 20, 1.4, 0.7), 0.6, 1.5);
          JouerSon("rebond", 1, pitchVitesse * pitchTaille);
          break;
        }
      }
    }

    // === COLLISION TANKS ===
    for (int i = 0; i < AllTanks.size(); i++) {
      Tank tank = AllTanks.get(i);
      if (tank.joueurId == proprietaireId && millis() - timer < 200) continue;
      if (!tank.vivant) continue;
      // Skip tanks déjà touchés par cette munition perçante
      if (type.perce && tanksTouches.contains(tank.joueurId)) continue;
      if (tank.DansTank(x, y)) {
        if (type.perce) tanksTouches.add(tank.joueurId);
        if (comp.equals("emp")) {
          // Ralentissement au lieu de dégâts
          tank.boosts.add(new BoostActif("ralenti", 0.3, 3000));
          BoumParticulesCouleur(x, y, 15, 35, 6, type.couleur);
        }
        else if (comp.equals("teleporteur")) {
          // Téléporte l'ennemi à une position aléatoire
          float marge = 80;
          for (int t = 0; t < 30; t++) {
            float nx = random(marge, LARGEUR - marge);
            float ny = random(marge, HAUTEUR - marge);
            boolean valide = true;
            for (Mur m : AllMurs) {
              if (m.DansMur(nx, ny)) { valide = false; break; }
            }
            if (valide) {
              BoumParticulesCouleur(tank.x, tank.y, 10, 25, 5, type.couleur);
              tank.x = nx; tank.y = ny;
              BoumParticulesCouleur(tank.x, tank.y, 10, 25, 5, type.couleur);
              FlashPleinEcran(0.2, type.couleur, 200);
              CreerTexteFlottant(tank.x, tank.y - 20, "TELEPORTE!", "", type.couleur);
              JouerSon("tank_teleport", 1, random(0.8, 1.2));
              break;
            }
          }
        }
        else if (comp.equals("miroir")) {
          // Inverse la direction du tank et rebondit
          tank.dir += PI;
          tank.boosts.add(new BoostActif("ralenti", 0.5, 1500));
          BoumParticulesCouleur(x, y, 12, 25, 5, type.couleur);
          // Rebondir (ne meurt pas)
          ori = atan2(y - tank.y, x - tank.x);
          rebonds++;
          EtincellesDir(x, y, 6, ori, PI/3, 3, type.couleur);
          FumeeParticules(x, y, 3);
          if (rebonds > type.rebondsMax) { aSupprimer = true; return; }
          continue; // ne meurt pas au contact
        }
        else if (comp.equals("chaine")) {
          // Dégâts puis saute à l'ennemi suivant
          if (type.degats > 0) tank.PrendreDegas(type.degats * multDegats);
          BoumParticulesCouleur(x, y, 10, 25, 5, type.couleur);
          // Trouver le prochain ennemi vivant
          Tank prochaineCible = null;
          float minDist = 400;
          for (Tank t2 : AllTanks) {
            if (t2 == tank || !t2.vivant) continue;
            float d = dist(x, y, t2.x, t2.y);
            if (d < minDist) { minDist = d; prochaineCible = t2; }
          }
          if (prochaineCible != null) {
            ori = atan2(prochaineCible.y - y, prochaineCible.x - x);
            // Éclair visuel entre les deux cibles
            EtincellesDir(x, y, 4, ori, PI/6, 4, type.couleur);
            FumeeParticules(x, y, 3);
            continue; // ne meurt pas, saute
          } else {
            aSupprimer = true;
            return;
          }
        }
        else if (comp.equals("fumigene")) {
          // Crée une zone de fumée
          AllZonesFumee.add(new ZoneFumee(x, y, 60, 5000));
          BoumParticulesCouleur(x, y, 15, 30, 5, type.couleur);
          FumeeParticules(x, y, 15);
          aSupprimer = true;
          return;
        }
        else {
          if (type.degats > 0) tank.PrendreDegas(type.degats * multDegats);
          BoumParticulesCouleur(x, y, 15, 30, 6, type.couleur);
          // Pitch selon taille : gros projectile = grave, petit = aigu
          float pitchImpact = constrain(map(type.taille, 3, 20, 1.3, 0.7), 0.6, 1.4) * random(0.95, 1.05);
          JouerSon("impact", 1, pitchImpact);
          // Vampirique : soigne le tireur
          if (type.degats > 0) {
            Tank tireur = TrouverTank(proprietaireId);
            if (tireur != null && tireur.vivant && tireur.ABoost("boost_vampirique")) {
              tireur.hp = min(tireur.hp + 1, tireur.type.hpMax);
              CreerTexteFlottant(tireur.x, tireur.y - 20, "+1 HP", "Drain", #CC0044);
            }
          }
        }
        FumeeParticules(x, y, 5);
        if (type.explose) Exploser();
        if (type.placeMur) PlacerMur(x, y);
        if (!type.perce) {
          aSupprimer = true;
          return;
        }
        // Laser/plasma perce : continue sans mourir
      }
    }

    // === MAGNETIQUE : déviation par les tanks avec boost magnétique ===
    for (Tank t : AllTanks) {
      if (!t.vivant || t.joueurId == proprietaireId) continue;
      if (t.ABoost("boost_magnetique")) {
        float d = dist(x, y, t.x, t.y);
        if (d < 100 && d > 5) {
          // Repousser le projectile
          float repulse = 0.8 * (100 - d) / 100;
          float angleRepulse = atan2(y - t.y, x - t.x);
          float diff = angleRepulse - ori;
          while (diff > PI) diff -= TWO_PI;
          while (diff < -PI) diff += TWO_PI;
          ori += diff * repulse * 0.1;
        }
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
    } else if (comp.equals("plasma")) {
      // Plasma : orbe translucide pulsante
      float pulse = 0.8 + sin(millis() * 0.02) * 0.2;
      fill(type.couleur, 20);
      ellipse(x, y, type.taille * 3 * pulse, type.taille * 3 * pulse);
      fill(type.couleur, 80);
      ellipse(x, y, type.taille * 1.5, type.taille * 1.5);
      fill(255, 220);
      ellipse(x, y, type.taille * 0.5, type.taille * 0.5);
    } else if (comp.equals("teleporteur")) {
      // Téléporteur : losange tournant
      pushMatrix();
      translate(x, y);
      rotate(millis() * 0.01);
      fill(type.couleur, 30);
      ellipse(0, 0, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      rectMode(CENTER);
      pushMatrix(); rotate(PI/4);
      rect(0, 0, type.taille * 0.8, type.taille * 0.8);
      popMatrix();
      popMatrix();
    } else if (comp.equals("aspirante")) {
      // Aspirante : forme avec ailes
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      pushMatrix();
      translate(x, y); rotate(ori);
      triangle(type.taille/2, 0, -type.taille/3, -type.taille/3, -type.taille/3, type.taille/3);
      popMatrix();
      fill(255, 180);
      ellipse(x, y, type.taille * 0.3, type.taille * 0.3);
    } else if (comp.equals("meteore")) {
      // Météore : gros et menaçant
      fill(type.couleur, 15);
      ellipse(x, y, type.taille * 4, type.taille * 4);
      fill(type.couleur, 40);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      ellipse(x, y, type.taille, type.taille);
      fill(#FFCC00, 150);
      ellipse(x, y, type.taille * 0.5, type.taille * 0.5);
    } else if (comp.equals("chaine")) {
      // Chaîne : étoile électrique
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2, type.taille * 2);
      fill(type.couleur);
      pushMatrix();
      translate(x, y); rotate(millis() * 0.015);
      for (int s = 0; s < 4; s++) {
        rotate(PI/2);
        rectMode(CENTER);
        rect(0, type.taille * 0.3, type.taille * 0.2, type.taille * 0.6);
      }
      popMatrix();
      fill(255, 200);
      ellipse(x, y, type.taille * 0.35, type.taille * 0.35);
    } else if (comp.equals("forage")) {
      // Foreuse : engrenage tournant
      fill(type.couleur, 25);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      pushMatrix();
      translate(x, y); rotate(millis() * 0.03);
      fill(type.couleur);
      for (int s = 0; s < 6; s++) {
        rotate(PI/3);
        rectMode(CENTER);
        rect(type.taille * 0.35, 0, type.taille * 0.3, type.taille * 0.2);
      }
      fill(lerpColor(type.couleur, #000000, 0.3));
      ellipse(0, 0, type.taille * 0.5, type.taille * 0.5);
      popMatrix();
    } else if (comp.equals("miroir")) {
      // Miroir : sphère réfléchissante
      fill(type.couleur, 20);
      ellipse(x, y, type.taille * 2.5, type.taille * 2.5);
      fill(type.couleur);
      ellipse(x, y, type.taille, type.taille);
      // Reflet
      fill(255, 150);
      ellipse(x - type.taille * 0.15, y - type.taille * 0.15, type.taille * 0.4, type.taille * 0.3);
    } else if (comp.equals("fumigene")) {
      // Fumigène : nuage
      fill(type.couleur, 30);
      ellipse(x, y, type.taille * 2, type.taille * 2);
      fill(type.couleur, 120);
      ellipse(x, y, type.taille, type.taille);
      fill(type.couleur, 60);
      ellipse(x + 3, y - 2, type.taille * 0.7, type.taille * 0.7);
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
    color murBase = (carteSelectionnee != null) ? carteSelectionnee.MurActif() : COULEUR_MUR;
    m.couleur = lerpColor(type.couleur, murBase, 0.5);
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
    TraceExplosion(x, y, type.rayonExplosion);
    FeuParticules(x, y, 25);
    BoumParticulesCouleur(x, y, 15, (int)type.rayonExplosion, 8, #FF6600);
    FumeeParticules(x, y, 10);
    FlashExplosion(x, y, type.rayonExplosion);
    if (type.rayonExplosion > 80) JouerSon("explosion_grosse", 1, random(0.7, 0.9));
    else JouerSon("explosion", 1, random(0.85, 1.15));
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
      // Fumigène qui expire = fumée
      else if (mun.type.comportement.equals("fumigene") && !mun.aSupprimer) {
        AllZonesFumee.add(new ZoneFumee(mun.x, mun.y, 60, 5000));
        FumeeParticules(mun.x, mun.y, 15);
      }
      // Munition explosive qui expire (météore, etc.) = explosion
      else if (mun.type.explose && !mun.aSupprimer) {
        mun.Exploser();
      }
      // Disparition normale
      else if (!mun.aSupprimer) {
        BoumParticulesCouleur(mun.x, mun.y, 5, 15, 3, mun.type.couleur);
      }
      AllMunitions.remove(i);
    }
  }
}
