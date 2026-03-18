// ============================================
// Mur.pde - Classe Mur (obstacles)
// ============================================

ArrayList<Mur> AllMurs = new ArrayList<Mur>();

class Mur {
  float x, y, tailleX = 100, tailleY = 20;
  int hp = -1;       // -1 = indestructible
  int hpMax = -1;
  String type = "normal"; // "normal", "destructible"
  color couleur;

  Mur(float nx, float ny, float tx, float ty) {
    x = nx; y = ny; tailleX = tx; tailleY = ty;
    couleur = COULEUR_MUR;
  }

  Mur(float nx, float ny) {
    x = nx; y = ny;
    couleur = COULEUR_MUR;
  }

  void RendreDestructible(int nhp) {
    type = "destructible";
    hp = nhp;
    hpMax = nhp;
  }

  boolean EstDestructible() {
    return type.equals("destructible");
  }

  void PrendreDegas(int degats) {
    if (!EstDestructible()) return;
    hp -= degats;
    EtincellesDir(x, y, 6, random(TWO_PI), PI, 3, couleur);
    if (hp <= 0) {
      hp = 0;
    }
  }

  boolean Detruit() {
    return EstDestructible() && hp <= 0;
  }

  void Affichage() {
    push();
    noStroke();

    if (EstDestructible()) {
      // Couleur qui se dégrade avec les HP
      float ratio = (hpMax > 0) ? (float)hp / hpMax : 1;
      color cBase = lerpColor(#553333, couleur, ratio);
      fill(cBase);

      translate(x, y);
      rect(0, 0, tailleX, tailleY);

      // Fissures visuelles quand endommagé
      if (ratio < 0.7) {
        stroke(0, 80);
        strokeWeight(1);
        line(-tailleX * 0.3, -tailleY * 0.2, tailleX * 0.1, tailleY * 0.3);
      }
      if (ratio < 0.4) {
        stroke(0, 100);
        line(tailleX * 0.2, -tailleY * 0.3, -tailleX * 0.15, tailleY * 0.1);
      }
    } else {
      fill(couleur);
      translate(x, y);
      rect(0, 0, tailleX, tailleY);
    }

    pop();
  }

  void Fonctions() {
    Affichage();
  }

  boolean DansMur(float xC, float yC) {
    return PointDansRect(xC, yC, x, y, tailleX, tailleY);
  }
}

void Fonctions_Murs() {
  for (int i = AllMurs.size() - 1; i >= 0; i--) {
    Mur mur = AllMurs.get(i);
    mur.Fonctions();
    if (mur.Detruit()) {
      BoumParticulesCouleur(mur.x, mur.y, 20, (int)max(mur.tailleX, mur.tailleY), 6, mur.couleur);
      FumeeParticules(mur.x, mur.y, 8);
      AllMurs.remove(i);
    }
  }
}
