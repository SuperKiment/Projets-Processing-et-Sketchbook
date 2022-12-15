class Bouton {

  int x, y, taille;
  boolean click = false;

  Bouton(int newx, int newy, int newtaille) {
    x = newx;
    y = newy;
    taille = newtaille;
  }

  void Affichage(color couleur) {
    push();
    fill(couleur);
    rectMode(CORNER);
    rect(x, y, taille, taille);
    pop();
  }

  void DetectionSourisP() {
    if (mousePressed == true && mouseButton == LEFT) {
      click = true;
    } else click = false;
  }

  void Curseur() {
    if (mouseX > x && mouseY > y && mouseX < x+taille && mouseY < y+taille) {
      cursor(HAND);
    }
  }
}




Bouton bouton1 = new Bouton(200, 200, 50);

void BoutonsConstant() {
  bouton1.Affichage(color(0, 255, 0));
  bouton1.Curseur();
}

void BoutonsDetection() {
  bouton1.DetectionSourisP();
}
