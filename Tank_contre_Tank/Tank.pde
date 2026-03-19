// ============================================
// Tank.pde - Classe Tank
// ============================================

ArrayList<Tank> AllTanks = new ArrayList<Tank>();

class Tank {
  int joueurId;
  TypeTank type;
  float x, y, dir, speed;
  int hp;
  Canon canon;
  PlayerInput input;
  color couleur;
  boolean vivant = true;
  ArrayList<BoostActif> boosts = new ArrayList<BoostActif>();

  // Spécial
  float dernierSpecial = -99999;
  boolean specialPret = true;
  boolean surchargeActive = false; // Artilleur
  boolean radarActif = false;      // Sentinelle
  float radarFin = 0;
  boolean forteresseActive = false; // Titan
  float forteresseFin = 0;
  boolean rageActive = false;      // Berserker
  float rageFin = 0;

  Tank(int jId, TypeTank t, float nx, float ny, float nd, PlayerInput pi) {
    joueurId = jId; type = t;
    x = nx; y = ny; dir = nd; speed = 0;
    hp = t.hpMax; input = pi;
    couleur = #FFFFFF;
    canon = new Canon(this);
    dernierSpecial = -t.specialCooldown;
  }

  float SpeedMax() {
    float s = type.speedMax;
    // Berserker passif : plus rapide quand blessé
    if (type.nom.equals("Berserker") && hp < type.hpMax) {
      float rage = 1.0 + (1.0 - (float)hp / type.hpMax) * 0.5;
      s *= rage;
    }
    for (BoostActif b : boosts) {
      if (b.categorie.equals("boost_vitesse")) s *= b.multiplicateur;
      if (b.categorie.equals("ralenti")) s *= b.multiplicateur;
    }
    return s;
  }

  float MultDefense() {
    float m = 1.0;
    for (BoostActif b : boosts) {
      if (b.categorie.equals("boost_defense")) m /= b.multiplicateur;
    }
    return m;
  }

  boolean ABoost(String cat) {
    for (BoostActif b : boosts) {
      if (b.categorie.equals(cat)) return true;
    }
    return false;
  }

  float RayonPickup() {
    return ABoost("boost_aimant") ? 75 : 25;
  }

  float CooldownSpecial() {
    float elapsed = millis() - dernierSpecial;
    return constrain(elapsed / type.specialCooldown, 0, 1);
  }

  // === SPECIAL ===
  void UtiliserSpecial() {
    if (millis() - dernierSpecial < type.specialCooldown) return;
    dernierSpecial = millis();

    String nom = type.nom;

    if (nom.equals("Sentinelle")) {
      // Radar : révèle tous les ennemis pendant 3s
      radarActif = true;
      radarFin = millis() + 3000;
      FlashPleinEcran(0.2, couleur, 200);
      CreerTexteFlottant(x, y - 30, "RADAR", "Ennemis reveles", couleur);
      JouerSon("special_radar");
    }
    else if (nom.equals("Eclaireur")) {
      // Dash : propulsion instantanée
      float dashDist = 80;
      float nx = x + cos(dir) * dashDist;
      float ny = y + sin(dir) * dashDist;
      // Vérifier qu'on ne dash pas dans un mur
      boolean bloque = false;
      for (Mur m : AllMurs) {
        if (m.DansMur(nx, ny)) { bloque = true; break; }
      }
      if (!bloque) {
        // Traînée de particules entre les deux positions
        for (int i = 0; i < 10; i++) {
          float t = i / 10.0;
          float px = lerp(x, nx, t);
          float py = lerp(y, ny, t);
          EtincellesDir(px, py, 2, dir + PI, PI/2, 2, couleur);
        }
        x = nx; y = ny;
      }
      FlashTir(x, y, couleur);
      CreerTexteFlottant(x, y - 30, "DASH", "", couleur);
      JouerSon("tank_dash");
    }
    else if (nom.equals("Titan")) {
      // Forteresse : invincible 2s
      forteresseActive = true;
      forteresseFin = millis() + 2000;
      FlashPleinEcran(0.15, #4488FF, 300);
      CreerTexteFlottant(x, y - 30, "FORTERESSE", "Invincible!", #4488FF);
      JouerSon("special_forteresse");
    }
    else if (nom.equals("Artilleur")) {
      // Surcharge : prochain tir x3
      surchargeActive = true;
      CreerTexteFlottant(x, y - 30, "SURCHARGE", "Prochain tir x3", #FF4400);
      FlashTir(x, y, #FF4400);
      JouerSon("special_surcharge");
    }
    else if (nom.equals("Fantome")) {
      // Phase : teleport 60px + invisibilite 2s
      float phaseDist = 60;
      float nx = x + cos(dir) * phaseDist;
      float ny = y + sin(dir) * phaseDist;
      boolean bloque = false;
      for (Mur m : AllMurs) {
        if (m.DansMur(nx, ny)) { bloque = true; break; }
      }
      BoumParticulesCouleur(x, y, 8, 20, 4, couleur);
      if (!bloque) { x = nx; y = ny; }
      BoumParticulesCouleur(x, y, 8, 20, 4, couleur);
      boosts.add(new BoostActif("boost_invisible", 1, 2500));
      CreerTexteFlottant(x, y - 30, "PHASE", "Invisibilite!", #8888CC);
      JouerSon("special_phase");
    }
    else if (nom.equals("Ingenieur")) {
      // Tourelle : place une tourelle auto qui tire
      AllTourelles.add(new Tourelle(x - cos(dir) * 30, y - sin(dir) * 30, joueurId, couleur));
      BoumParticulesCouleur(x, y, 6, 15, 3, couleur);
      CreerTexteFlottant(x, y - 30, "TOURELLE", "Deploiement!", couleur);
      JouerSon("special_tourelle");
    }
    else if (nom.equals("Berserker")) {
      // Rage : vitesse et dégâts x2 pendant 3s
      rageActive = true;
      rageFin = millis() + 3000;
      boosts.add(new BoostActif("boost_vitesse", 2.0, 3000));
      boosts.add(new BoostActif("boost_degats", 1, 3000));
      FlashPleinEcran(0.3, #FF2200, 300);
      CreerTexteFlottant(x, y - 30, "RAGE!", "Degats et vitesse x2", #FF2200);
      JouerSon("special_rage");
    }
    else if (nom.equals("Magnetiseur")) {
      // Impulsion : repousse toutes les munitions et tanks proches
      float impulsionRayon = 150;
      for (Munition m : AllMunitions) {
        float d = dist(x, y, m.x, m.y);
        if (d < impulsionRayon && d > 5) {
          m.ori = atan2(m.y - y, m.x - x);
          m.speed *= 1.5;
          EtincellesDir(m.x, m.y, 3, m.ori, PI/4, 2, #44FFAA);
        }
      }
      for (Tank t : AllTanks) {
        if (t == this || !t.vivant) continue;
        float d = dist(x, y, t.x, t.y);
        if (d < impulsionRayon && d > 5) {
          float repAngle = atan2(t.y - y, t.x - x);
          float force = (impulsionRayon - d) * 0.5;
          t.x += cos(repAngle) * force;
          t.y += sin(repAngle) * force;
          t.boosts.add(new BoostActif("ralenti", 0.4, 1500));
          EtincellesDir(t.x, t.y, 4, repAngle, PI/3, 3, #44FFAA);
        }
      }
      FlashPleinEcran(0.2, #44FFAA, 200);
      BoumParticulesCouleur(x, y, 20, (int)impulsionRayon, 6, #44FFAA);
      CreerTexteFlottant(x, y - 30, "IMPULSION", "Tout repousse!", #44FFAA);
      JouerSon("special_impulsion");
    }
    else if (nom.equals("Pyromane")) {
      // Napalm : anneau de feu autour du tank
      int nbZones = 8;
      for (int i = 0; i < nbZones; i++) {
        float a = TWO_PI * i / nbZones;
        float fx = x + cos(a) * 60;
        float fy = y + sin(a) * 60;
        AllZonesFeu.add(new ZoneFeu(fx, fy, 25, 3500, 1));
      }
      FeuParticules(x, y, 30);
      FlashExplosion(x, y, 80);
      CreerTexteFlottant(x, y - 30, "NAPALM", "Anneau de feu!", #FF4400);
      JouerSon("special_napalm");
    }
    else if (nom.equals("Colosse")) {
      // Salve : tire 8 projectiles en cercle
      TypeMunition typeSalve = TypesMunitions.get(canon.typeMunActuel.nom);
      if (typeSalve == null) typeSalve = TypesMunitions.get("standard");
      for (int i = 0; i < 8; i++) {
        float a = dir + TWO_PI * i / 8;
        float sx = x + cos(a) * (type.taille / 2 + 5);
        float sy = y + sin(a) * (type.taille / 2 + 5);
        Munition m = new Munition(sx, sy, a, typeSalve, joueurId);
        AllMunitions.add(m);
      }
      FlashExplosion(x, y, 50);
      BoumParticulesCouleur(x, y, 15, 30, 5, couleur);
      CreerTexteFlottant(x, y - 30, "SALVE", "8 tirs en cercle!", couleur);
      JouerSon("special_salve");
    }
  }

  void MettreAJourSpecial() {
    // Radar
    if (radarActif && millis() >= radarFin) {
      radarActif = false;
    }
    // Forteresse
    if (forteresseActive && millis() >= forteresseFin) {
      forteresseActive = false;
    }
    // Rage
    if (rageActive && millis() >= rageFin) {
      rageActive = false;
    }
  }

  // === AFFICHAGE ===
  void Affichage() {
    if (!vivant) return;

    // Radar : cercles autour des ennemis
    if (radarActif) {
      for (Tank t : AllTanks) {
        if (t.joueurId == joueurId || !t.vivant) continue;
        push();
        noFill();
        stroke(couleur, 120 + sin(millis() * 0.01) * 60);
        strokeWeight(2);
        float r = 35 + sin(millis() * 0.008) * 8;
        ellipse(t.x, t.y, r, r);
        // Croix de ciblage
        float cr = 20;
        line(t.x - cr, t.y, t.x + cr, t.y);
        line(t.x, t.y - cr, t.x, t.y + cr);
        pop();
      }
    }

    push();
    translate(x, y);
    rotate(dir);

    // Échelle pour gigantisme/miniature
    float tailleScale = TailleActuelle() / type.taille;
    scale(tailleScale);

    noStroke();

    float alphaBase = ABoost("boost_invisible") ? 50 : 255;
    // Fantôme : rendu semi-transparent pulsant
    if (ABoost("boost_fantome")) {
      alphaBase = min(alphaBase, (int)(100 + sin(millis() * 0.01) * 40));
    }
    // Herbe haute : semi-transparent
    if (ABoost("herbe_cache")) {
      alphaBase = min(alphaBase, 80);
    }

    // Corps selon la forme
    fill(couleur, alphaBase);
    DessinerForme(type.forme, type.taille, alphaBase);

    // Contours boost
    DessinerContoursBoosts(alphaBase);

    // Forteresse active : bouclier visible
    if (forteresseActive) {
      noFill();
      stroke(#4488FF, 180 + sin(millis() * 0.02) * 75);
      strokeWeight(3);
      ellipse(0, 0, type.taille + 18, type.taille + 18);
      stroke(#88CCFF, 100);
      strokeWeight(1);
      ellipse(0, 0, type.taille + 24, type.taille + 24);
      noStroke();
    }

    // Surcharge active : lueur
    if (surchargeActive) {
      fill(#FF4400, 30 + sin(millis() * 0.015) * 20);
      ellipse(0, 0, type.taille + 20, type.taille + 20);
    }

    // Rage active : flammes rouges
    if (rageActive) {
      fill(#FF2200, 40 + sin(millis() * 0.02) * 25);
      ellipse(0, 0, type.taille + 16, type.taille + 16);
      noFill();
      stroke(#FF4400, 120 + sin(millis() * 0.025) * 60);
      strokeWeight(2);
      ellipse(0, 0, type.taille + 10, type.taille + 10);
      noStroke();
    }

    // Canon
    canon.Affichage();
    pop();

    // Cooldown spécial : petit arc sous le tank
    AfficherCooldownSpecial();
  }

  void DessinerForme(String forme, float t, float alpha) {
    if (forme.equals("carre")) {
      // Sentinelle : carré classique avec coin chanfreinés
      rectMode(CENTER);
      rect(0, 0, t, t, 2);
      // Détails : lignes internes
      stroke(lerpColor(couleur, #000000, 0.3), alpha * 0.5);
      strokeWeight(1);
      line(-t*0.3, -t*0.3, t*0.3, -t*0.3);
      line(-t*0.3, t*0.3, t*0.3, t*0.3);
      noStroke();
    }
    else if (forme.equals("losange")) {
      // Éclaireur : losange rapide avec ailettes
      push();
      rotate(PI/4);
      rectMode(CENTER);
      rect(0, 0, t * 0.8, t * 0.8);
      pop();
      // Ailettes aérodynamiques
      fill(lerpColor(couleur, #000000, 0.25), alpha);
      triangle(-t*0.5, 0, -t*0.2, -t*0.15, -t*0.2, t*0.15);
      triangle(t*0.5, 0, t*0.2, -t*0.15, t*0.2, t*0.15);
    }
    else if (forme.equals("octogone")) {
      // Titan : octogone massif avec rivets
      float r = t * 0.55;
      beginShape();
      for (int i = 0; i < 8; i++) {
        float a = TWO_PI * i / 8 + PI/8;
        vertex(cos(a) * r, sin(a) * r);
      }
      endShape(CLOSE);
      // Rivets décoratifs
      fill(lerpColor(couleur, #000000, 0.3), alpha);
      float rivetR = t * 0.4;
      for (int i = 0; i < 4; i++) {
        float a = TWO_PI * i / 4 + PI/4;
        ellipse(cos(a) * rivetR, sin(a) * rivetR, 3, 3);
      }
      // Plaque blindée centrale
      fill(lerpColor(couleur, #FFFFFF, 0.1), alpha * 0.4);
      rectMode(CENTER);
      rect(0, 0, t * 0.4, t * 0.4);
    }
    else if (forme.equals("rectangle")) {
      // Artilleur : rectangle large avec plate-forme
      rectMode(CENTER);
      rect(0, 0, t * 0.7, t * 1.15);
      // Plateforme arrière (recul)
      fill(lerpColor(couleur, #000000, 0.2), alpha);
      rect(-t * 0.25, 0, t * 0.2, t * 0.8);
      // Viseur
      stroke(lerpColor(couleur, #FFFFFF, 0.3), alpha * 0.6);
      strokeWeight(1);
      line(t * 0.1, -t * 0.3, t * 0.35, 0);
      line(t * 0.1, t * 0.3, t * 0.35, 0);
      noStroke();
    }
    else if (forme.equals("triangle")) {
      // Fantôme : triangle furtif
      triangle(t * 0.55, 0, -t * 0.45, -t * 0.4, -t * 0.45, t * 0.4);
      // Ligne interne spectrale
      fill(lerpColor(couleur, #FFFFFF, 0.2), alpha * 0.3);
      triangle(t * 0.3, 0, -t * 0.2, -t * 0.2, -t * 0.2, t * 0.2);
    }
    else if (forme.equals("hexagone")) {
      // Berserker : hexagone avec lignes de rage
      float r = t * 0.5;
      beginShape();
      for (int i = 0; i < 6; i++) {
        float a = TWO_PI * i / 6;
        vertex(cos(a) * r, sin(a) * r);
      }
      endShape(CLOSE);
      // Griffures
      stroke(lerpColor(couleur, #FF0000, 0.5), alpha * 0.5);
      strokeWeight(1);
      line(-t * 0.2, -t * 0.3, t * 0.15, t * 0.1);
      line(-t * 0.1, -t * 0.25, t * 0.2, t * 0.15);
      noStroke();
    }
    else if (forme.equals("cercle")) {
      // Magnétiseur : cercle avec anneaux
      ellipse(0, 0, t, t);
      noFill();
      stroke(lerpColor(couleur, #FFFFFF, 0.3), alpha * 0.4);
      strokeWeight(1);
      ellipse(0, 0, t * 0.6, t * 0.6);
      // Arcs magnétiques
      stroke(lerpColor(couleur, #44FFAA, 0.5), alpha * 0.5);
      arc(0, 0, t * 1.1, t * 1.1, -PI/4, PI/4);
      arc(0, 0, t * 1.1, t * 1.1, PI - PI/4, PI + PI/4);
      noStroke();
    }
    else if (forme.equals("trapeze")) {
      // Pyromane : trapèze (avant large)
      quad(t * 0.45, -t * 0.45, t * 0.45, t * 0.45,
           -t * 0.4, t * 0.3, -t * 0.4, -t * 0.3);
      // Flammes décoratives
      fill(lerpColor(couleur, #FF4400, 0.5), alpha * 0.4);
      ellipse(-t * 0.3, 0, t * 0.3, t * 0.4);
    }
    else if (forme.equals("double_canon")) {
      // Colosse : carré large avec double canon visuel
      rectMode(CENTER);
      rect(0, 0, t * 0.9, t, 3);
      // Lignes internes
      fill(lerpColor(couleur, #000000, 0.2), alpha);
      rect(0, -t * 0.2, t * 0.5, t * 0.1);
      rect(0, t * 0.2, t * 0.5, t * 0.1);
    }
  }

  void DessinerContoursBoosts(float alphaBase) {
    if (ABoost("boost_vitesse")) {
      stroke(#FF44FF, min(alphaBase, 150));
      strokeWeight(2); noFill();
      ellipse(0, 0, type.taille + 6, type.taille + 6);
      noStroke();
    }
    if (ABoost("boost_degats")) {
      stroke(#FF2200, min(alphaBase, 150));
      strokeWeight(2); noFill();
      ellipse(0, 0, type.taille + 8, type.taille + 8);
      noStroke();
    }
    if (ABoost("boost_defense")) {
      stroke(#4488FF, min(alphaBase, 120));
      strokeWeight(2); noFill();
      ellipse(0, 0, type.taille + 10, type.taille + 10);
      noStroke();
    }
    if (ABoost("ralenti")) {
      stroke(#4488FF, min(alphaBase, 100));
      strokeWeight(1); noFill();
      ellipse(0, 0, type.taille + 8, type.taille + 8);
      noStroke();
      fill(#4488FF, min(alphaBase, 40));
      for (int i = 0; i < 3; i++) {
        float a = (millis() * 0.003) + i * TWO_PI/3;
        ellipse(cos(a) * type.taille * 0.6, sin(a) * type.taille * 0.6, 4, 4);
      }
    }
    if (ABoost("boost_vampirique")) {
      stroke(#CC0044, min(alphaBase, 130));
      strokeWeight(1.5); noFill();
      float vr = type.taille + 6 + sin(millis() * 0.008) * 3;
      ellipse(0, 0, vr, vr);
      noStroke();
    }
    if (ABoost("boost_fantome")) {
      noFill();
      stroke(#9966FF, min(alphaBase, 80 + (int)(sin(millis() * 0.01) * 40)));
      strokeWeight(1.5);
      float gr = type.taille + 10 + sin(millis() * 0.006) * 4;
      ellipse(0, 0, gr, gr);
      noStroke();
    }
    if (ABoost("boost_magnetique")) {
      noFill();
      stroke(#44FFAA, min(alphaBase, 100));
      strokeWeight(1);
      float mr = type.taille + 12;
      // Cercles concentriques pulsants
      float mPhase = millis() * 0.005;
      for (int i = 0; i < 2; i++) {
        float mp = (mPhase + i * PI) % TWO_PI;
        float ma = 80 * (1.0 - mp / TWO_PI);
        stroke(#44FFAA, min(alphaBase, (int)ma));
        ellipse(0, 0, mr + mp * 15, mr + mp * 15);
      }
      noStroke();
    }
  }

  void AfficherCooldownSpecial() {
    float cd = CooldownSpecial();
    if (cd >= 1.0) return; // prêt = pas d'indicateur
    push();
    noFill();
    stroke(couleur, 150);
    strokeWeight(2);
    float r = type.taille + 14;
    arc(x, y, r, r, dir - PI * cd, dir + PI * cd);
    pop();
  }

  // === DEPLACEMENT ===
  void Deplacement() {
    if (!vivant) return;

    float sMax = SpeedMax();
    boolean bouge = input.avancer || input.reculer || input.gauche || input.droite;
    speed = bouge ? lerp(speed, sMax, 0.01) : lerp(speed, 0, 0.05);

    float rotSpeed = type.dirSpeed * input.rotationIntensiteX;
    if (input.gauche) dir -= rotSpeed;
    if (input.droite) dir += rotSpeed;

    float nextX = x, nextY = y;
    if (input.avancer) { nextX = x + speed * cos(dir); nextY = y + speed * sin(dir); }
    if (input.reculer) { nextX = x - speed * cos(dir); nextY = y - speed * sin(dir); }

    boolean collision = false;
    boolean fantome = ABoost("boost_fantome");
    for (int i = 0; i < AllMurs.size(); i++) {
      Mur mur = AllMurs.get(i);
      if (mur.DansMur(nextX, nextY)) {
        if (fantome && i >= 4) {
          // Passe à travers les murs (sauf bordures = 4 premiers)
          continue;
        }
        String cote = CoteRect(x, y, mur.x, mur.y, mur.tailleX, mur.tailleY);
        dir = ReflexionAngle(dir, cote);
        speed /= 4;
        EtincellesDir(nextX, nextY, 4, dir + PI, PI/4, 2, couleur);
        collision = true;
        break;
      }
    }
    if (!collision) {
      // Traces de chenilles au sol
      if (input.avancer || input.reculer) {
        TraceChenille(x, y, dir, TailleActuelle(), couleur);
      }
      x = nextX; y = nextY;
    }

    if (input.tir || input.tirMaintenu) canon.Tir();
    if (input.specialPresse) UtiliserSpecial();
  }

  void MettreAJourBoosts() {
    for (int i = boosts.size() - 1; i >= 0; i--) {
      if (boosts.get(i).Expire()) boosts.remove(i);
    }
  }

  float TailleActuelle() {
    float t = type.taille;
    if (ABoost("boost_gigantisme")) t *= 1.8;
    if (ABoost("boost_miniature")) t *= 0.5;
    return t;
  }

  float HitboxActuelle() {
    float r = type.hitboxRayon;
    if (ABoost("boost_gigantisme")) r *= 1.8;
    if (ABoost("boost_miniature")) r *= 0.5;
    return r;
  }

  boolean DansTank(float px, float py) {
    return dist(px, py, x, y) < HitboxActuelle();
  }

  void PrendreDegas(float degats) {
    if (!vivant) return;
    if (forteresseActive) {
      EtincellesDir(x, y, 6, random(TWO_PI), PI, 3, #4488FF);
      return;
    }
    float degatsFinal = degats * MultDefense();
    hp -= max(1, (int)degatsFinal);
    BoumParticulesCouleur(x, y, 10, 30, 5, couleur);
    JouerSon("tank_degats");
    if (hp <= 0) Mourir();
  }

  void Mourir() {
    vivant = false;
    TraceMort(x, y, type.taille, couleur);
    BoumParticulesCouleur(x, y, 25, 50, 8, couleur);
    FeuParticules(x, y, 15);
    FumeeParticules(x, y, 10);
    FlashMort(x, y);
    JouerSon("tank_mort");
  }

  void Fonctions() {
    if (!vivant) return;
    input.MettreAJour();
    MettreAJourBoosts();
    MettreAJourSpecial();
    Deplacement();
    Affichage();
  }
}

void Fonctions_Tanks() {
  for (int i = AllTanks.size() - 1; i >= 0; i--) {
    AllTanks.get(i).Fonctions();
  }
}

// --- Tourelles automatiques (Ingénieur) ---
ArrayList<Tourelle> AllTourelles = new ArrayList<Tourelle>();

class Tourelle {
  float x, y, dir;
  int proprietaireId;
  color couleur;
  float timer;
  float dernierTir;
  float dureeVie = 12000;
  int hp = 2;

  Tourelle(float nx, float ny, int propId, color c) {
    x = nx; y = ny; dir = 0;
    proprietaireId = propId; couleur = c;
    timer = millis();
    dernierTir = millis();
  }

  void Fonctions() {
    // Chercher la cible la plus proche
    Tank cible = null;
    float minDist = 250;
    for (Tank t : AllTanks) {
      if (t.joueurId == proprietaireId || !t.vivant) continue;
      float d = dist(x, y, t.x, t.y);
      if (d < minDist) { minDist = d; cible = t; }
    }

    // Viser la cible
    if (cible != null) {
      float targetDir = atan2(cible.y - y, cible.x - x);
      float diff = targetDir - dir;
      while (diff > PI) diff -= TWO_PI;
      while (diff < -PI) diff += TWO_PI;
      dir += diff * 0.05;

      // Tirer
      if (millis() - dernierTir > 1200 && abs(diff) < 0.3) {
        TypeMunition tm = TypesMunitions.get("standard");
        Munition m = new Munition(x + cos(dir) * 15, y + sin(dir) * 15, dir, tm, proprietaireId);
        AllMunitions.add(m);
        EtincellesDir(x + cos(dir) * 15, y + sin(dir) * 15, 3, dir, PI/6, 2, couleur);
        FlashTir(x, y, couleur);
        JouerSon("tir");
        dernierTir = millis();
      }
    }

    // Affichage
    push();
    translate(x, y);
    noStroke();
    // Base
    fill(couleur, 60);
    ellipse(0, 0, 22, 22);
    fill(couleur, 180);
    ellipse(0, 0, 14, 14);
    // Canon
    rotate(dir);
    fill(lerpColor(couleur, #000000, 0.4));
    rectMode(CENTER);
    rect(10, 0, 20, 5);
    pop();

    // Barre de vie restante
    float vie = 1.0 - (millis() - timer) / dureeVie;
    push();
    noStroke();
    fill(couleur, 60);
    rectMode(CORNER);
    rect(x - 10, y + 14, 20, 3);
    fill(couleur, 150);
    rect(x - 10, y + 14, 20 * max(0, vie), 3);
    pop();
  }

  boolean Mort() {
    return millis() - timer >= dureeVie || hp <= 0;
  }
}

void Fonctions_Tourelles() {
  for (int i = AllTourelles.size() - 1; i >= 0; i--) {
    AllTourelles.get(i).Fonctions();
    if (AllTourelles.get(i).Mort()) {
      Tourelle t = AllTourelles.get(i);
      BoumParticulesCouleur(t.x, t.y, 10, 20, 4, t.couleur);
      FumeeParticules(t.x, t.y, 4);
      AllTourelles.remove(i);
    }
  }
}

// Dessiner un tank en preview (pour menus)
void DessinerTankPreview(float px, float py, float angle, TypeTank type, color couleur, float echelle) {
  push();
  translate(px, py);
  rotate(angle);
  scale(echelle);
  noStroke();
  fill(couleur);

  String forme = type.forme;
  float t = type.taille;

  if (forme.equals("carre")) {
    rectMode(CENTER);
    rect(0, 0, t, t, 2);
    stroke(lerpColor(couleur, #000000, 0.3), 130);
    strokeWeight(1);
    line(-t*0.3, -t*0.3, t*0.3, -t*0.3);
    line(-t*0.3, t*0.3, t*0.3, t*0.3);
    noStroke();
  } else if (forme.equals("losange")) {
    push(); rotate(PI/4);
    rectMode(CENTER);
    rect(0, 0, t * 0.8, t * 0.8);
    pop();
    fill(lerpColor(couleur, #000000, 0.25));
    triangle(-t*0.5, 0, -t*0.2, -t*0.15, -t*0.2, t*0.15);
    triangle(t*0.5, 0, t*0.2, -t*0.15, t*0.2, t*0.15);
  } else if (forme.equals("octogone")) {
    float r = t * 0.55;
    beginShape();
    for (int i = 0; i < 8; i++) {
      float a = TWO_PI * i / 8 + PI/8;
      vertex(cos(a) * r, sin(a) * r);
    }
    endShape(CLOSE);
    fill(lerpColor(couleur, #000000, 0.3));
    float rivetR = t * 0.4;
    for (int i = 0; i < 4; i++) {
      float a = TWO_PI * i / 4 + PI/4;
      ellipse(cos(a) * rivetR, sin(a) * rivetR, 3, 3);
    }
  } else if (forme.equals("rectangle")) {
    rectMode(CENTER);
    rect(0, 0, t * 0.7, t * 1.15);
    fill(lerpColor(couleur, #000000, 0.2));
    rect(-t * 0.25, 0, t * 0.2, t * 0.8);
  } else if (forme.equals("triangle")) {
    triangle(t * 0.55, 0, -t * 0.45, -t * 0.4, -t * 0.45, t * 0.4);
    fill(lerpColor(couleur, #FFFFFF, 0.2), 80);
    triangle(t * 0.3, 0, -t * 0.2, -t * 0.2, -t * 0.2, t * 0.2);
  } else if (forme.equals("hexagone")) {
    float r = t * 0.5;
    beginShape();
    for (int i = 0; i < 6; i++) {
      float a = TWO_PI * i / 6;
      vertex(cos(a) * r, sin(a) * r);
    }
    endShape(CLOSE);
    stroke(lerpColor(couleur, #FF0000, 0.5), 130);
    strokeWeight(1);
    line(-t * 0.2, -t * 0.3, t * 0.15, t * 0.1);
    noStroke();
  } else if (forme.equals("cercle")) {
    ellipse(0, 0, t, t);
    noFill(); stroke(lerpColor(couleur, #FFFFFF, 0.3), 100); strokeWeight(1);
    ellipse(0, 0, t * 0.6, t * 0.6);
    noStroke();
  } else if (forme.equals("trapeze")) {
    quad(t * 0.45, -t * 0.45, t * 0.45, t * 0.45,
         -t * 0.4, t * 0.3, -t * 0.4, -t * 0.3);
    fill(lerpColor(couleur, #FF4400, 0.5), 100);
    ellipse(-t * 0.3, 0, t * 0.3, t * 0.4);
  } else if (forme.equals("double_canon")) {
    rectMode(CENTER);
    rect(0, 0, t * 0.9, t, 3);
    fill(lerpColor(couleur, #000000, 0.2));
    rect(0, -t * 0.2, t * 0.5, t * 0.1);
    rect(0, t * 0.2, t * 0.5, t * 0.1);
  }

  // Canon
  fill(lerpColor(couleur, #000000, 0.4));
  noStroke();
  rectMode(CENTER);
  float lon = type.canonLongueur;
  float lar = type.canonLargeur;
  if (forme.equals("double_canon")) {
    float ecart = lar * 1.2;
    rect(lon/2, -ecart, lon, lar);
    rect(lon/2, ecart, lon, lar);
  } else {
    rect(lon/2, 0, lon, lar);
  }

  pop();
}
