ArrayList<Mur> AllMurs = new ArrayList<Mur>();

class Mur {

  float x, y, tailleX = 100, tailleY = 20;
  int hp = 100;

  Mur(float nx, float ny, float tx, float ty) {
    x = nx;
    y = ny;
    tailleX = tx;
    tailleY = ty;
  }
  Mur(float nx, float ny) {
    x = nx;
    y = ny;
  }

  void Affichage() {
    push();

    fill(150);
    translate(x, y);
    rect(0, 0, tailleX, tailleY);

    pop();
  }

  void Fonctions() {
    Affichage();
  }

  boolean DansMur(float xC, float yC) {
    if (xC > x-tailleX/2 && xC < x+tailleX/2 &&
      yC > y-tailleY/2 && yC < y+tailleY/2) {
      return true;
    } else return false;
  }

  String PosParRapport(float xC, float yC) {
    String rapport = "nope";

    if (xC < x-tailleX/2 && yC > y-tailleY && yC < y+tailleY) rapport = "gauche";
    if (xC > x+tailleX/2 && yC > y-tailleY && yC < y+tailleY) rapport = "droite";

    if (yC < y-tailleY/2 && xC > x-tailleX && xC < x+tailleX) rapport = "haut";
    if (yC > y+tailleY/2 && xC > x-tailleX && xC < x+tailleX) rapport = "bas";

    return rapport;
  }
}

//=============================

void Setup_Murs() {
  AllMurs.add(new Mur(400, 400));
  AllMurs.add(new Mur(400, 500, 50, 50));
}

void Fonctions_Murs() {
  for (int i = 0; i<AllMurs.size(); i++) {
    Mur mur = AllMurs.get(i);

    mur.Fonctions();
  }
}
