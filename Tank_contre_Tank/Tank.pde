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
    }
    else if (nom.equals("Titan")) {
      // Forteresse : invincible 2s
      forteresseActive = true;
      forteresseFin = millis() + 2000;
      FlashPleinEcran(0.15, #4488FF, 300);
      CreerTexteFlottant(x, y - 30, "FORTERESSE", "Invincible!", #4488FF);
    }
    else if (nom.equals("Artilleur")) {
      // Surcharge : prochain tir x3
      surchargeActive = true;
      CreerTexteFlottant(x, y - 30, "SURCHARGE", "Prochain tir x3", #FF4400);
      FlashTir(x, y, #FF4400);
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
      // Effet de disparition à l'ancienne position
      BoumParticulesCouleur(x, y, 8, 20, 4, couleur);
      if (!bloque) { x = nx; y = ny; }
      // Apparition à la nouvelle position
      BoumParticulesCouleur(x, y, 8, 20, 4, couleur);
      boosts.add(new BoostActif("boost_invisible", 1, 2500));
      CreerTexteFlottant(x, y - 30, "PHASE", "Invisibilite!", #8888CC);
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
    noStroke();

    float alphaBase = ABoost("boost_invisible") ? 50 : 255;

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
    for (int i = 0; i < AllMurs.size(); i++) {
      Mur mur = AllMurs.get(i);
      if (mur.DansMur(nextX, nextY)) {
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
        TraceChenille(x, y, dir, type.taille, couleur);
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

  boolean DansTank(float px, float py) {
    return dist(px, py, x, y) < type.hitboxRayon;
  }

  void PrendreDegas(float degats) {
    if (!vivant) return;
    if (forteresseActive) {
      // Invincible - juste des étincelles
      EtincellesDir(x, y, 6, random(TWO_PI), PI, 3, #4488FF);
      return;
    }
    float degatsFinal = degats * MultDefense();
    hp -= max(1, (int)degatsFinal);
    BoumParticulesCouleur(x, y, 10, 30, 5, couleur);
    if (hp <= 0) Mourir();
  }

  void Mourir() {
    vivant = false;
    TraceMort(x, y, type.taille, couleur);
    BoumParticulesCouleur(x, y, 25, 50, 8, couleur);
    FeuParticules(x, y, 15);
    FumeeParticules(x, y, 10);
    FlashMort(x, y);
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
  }

  // Canon
  fill(lerpColor(couleur, #000000, 0.4));
  noStroke();
  rectMode(CENTER);
  float lon = type.canonLongueur;
  float lar = type.canonLargeur;
  rect(lon/2, 0, lon, lar);

  pop();
}
