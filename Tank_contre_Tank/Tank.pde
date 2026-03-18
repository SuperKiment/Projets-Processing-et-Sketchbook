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

  Tank(int jId, TypeTank t, float nx, float ny, float nd, PlayerInput pi) {
    joueurId = jId; type = t;
    x = nx; y = ny; dir = nd; speed = 0;
    hp = t.hpMax; input = pi;
    couleur = #FFFFFF;
    canon = new Canon(this);
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

  void Affichage() {
    if (!vivant) return;

    push();
    translate(x, y);
    rotate(dir);
    noStroke();

    // Invisibilité
    float alphaBase = ABoost("boost_invisible") ? 50 : 255;

    // Corps
    fill(couleur, alphaBase);
    rect(0, 0, type.taille, type.taille);

    // Contours boost
    if (ABoost("boost_vitesse")) {
      stroke(#FF44FF, min(alphaBase, 150));
      strokeWeight(2); noFill();
      rect(0, 0, type.taille + 4, type.taille + 4);
      noStroke();
    }
    if (ABoost("boost_degats")) {
      stroke(#FF2200, min(alphaBase, 150));
      strokeWeight(2); noFill();
      rect(0, 0, type.taille + 6, type.taille + 6);
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
      // Petits arcs EMP
      fill(#4488FF, min(alphaBase, 40));
      for (int i = 0; i < 3; i++) {
        float a = (millis() * 0.003) + i * TWO_PI/3;
        ellipse(cos(a) * type.taille * 0.6, sin(a) * type.taille * 0.6, 4, 4);
      }
    }

    // Canon
    canon.Affichage();
    pop();
  }

  void Deplacement() {
    if (!vivant) return;

    float sMax = SpeedMax();
    boolean bouge = input.avancer || input.reculer || input.gauche || input.droite;
    speed = bouge ? lerp(speed, sMax, 0.01) : lerp(speed, 0, 0.05);

    if (input.gauche) dir -= type.dirSpeed;
    if (input.droite) dir += type.dirSpeed;

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
    if (!collision) { x = nextX; y = nextY; }

    if (input.tir || input.tirMaintenu) canon.Tir();
  }

  void MettreAJourBoosts() {
    for (int i = boosts.size() - 1; i >= 0; i--) {
      if (boosts.get(i).Expire()) boosts.remove(i);
    }
  }

  boolean DansTank(float px, float py) {
    return dist(px, py, x, y) < type.taille / 2;
  }

  void PrendreDegas(float degats) {
    if (!vivant) return;
    float degatsFinal = degats * MultDefense();
    hp -= max(1, (int)degatsFinal);
    BoumParticulesCouleur(x, y, 10, 30, 5, couleur);
    if (hp <= 0) Mourir();
  }

  void Mourir() {
    vivant = false;
    BoumParticulesCouleur(x, y, 25, 50, 8, couleur);
    FeuParticules(x, y, 15);
    FumeeParticules(x, y, 10);
  }

  void Fonctions() {
    if (!vivant) return;
    input.MettreAJour();
    MettreAJourBoosts();
    Deplacement();
    Affichage();
  }
}

void Fonctions_Tanks() {
  for (int i = AllTanks.size() - 1; i >= 0; i--) {
    AllTanks.get(i).Fonctions();
  }
}
