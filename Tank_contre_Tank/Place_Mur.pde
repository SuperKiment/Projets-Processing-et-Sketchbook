Place_Mur placeMur = new Place_Mur();

class Place_Mur {

  float xB, yB;
  boolean lock;
  float tailleX, tailleY;

  Place_Mur() {
  }

  void Affichage() {
    push();
    rect(xB, yB, tailleX, tailleY);

    pop();
  }

  void RecupTaille() {
    tailleX = abs(xB-sourisX)*2;
    tailleY = abs(yB-sourisY)*2;
  }

  void Fonctions() {
    if (lock) {
      RecupTaille();
      Affichage();
    }
  }

  void Reset() {
    xB = sourisX;
    yB = sourisY;
  }

  void Place() {
    AllMurs.add(new Mur(xB, yB, tailleX, tailleY));
  }
}
