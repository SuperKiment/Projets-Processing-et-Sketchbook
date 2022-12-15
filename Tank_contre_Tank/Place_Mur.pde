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
    tailleX = abs(xB-mouseX)*2;
    tailleY = abs(yB-mouseY)*2;
  }

  void Fonctions() {
    if (lock) {
      RecupTaille();
      Affichage();
    }
  }

  void Reset() {
    xB = mouseX;
    yB = mouseY;
  }

  void Place() {
    AllMurs.add(new Mur(xB, yB, tailleX, tailleY));
  }
}
