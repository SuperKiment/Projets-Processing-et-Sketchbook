PointeurDev pointeurDev = new PointeurDev();

class PointeurDev {
  float x, y;
  int posx, posy;
  boolean click = false;
  color couleurPointeur = #11AD49;

  PointeurDev() {
  }

  void Deplacement() {
    x = mouseX - translateX;
    y = mouseY - translateY;

    float x1 = x/grilleActive.tailleRect;
    float y1 = y/grilleActive.tailleRect;

    if (x1 < int(x1)+0.5) 
      posx = int(x1);
    else posx = ceil(x1);

    if (y1 < int(y1)+0.5) 
      posy = int(y1);
    else posy = ceil(y1);

    if (posx<0) posx = 0;
    if (posy<0) posy = 0;

    if (posx>grilleActive.taillex-1) posx = grilleActive.taillex-1;
    if (posy>grilleActive.tailley-1) posy = grilleActive.tailley-1;
  }

  void Affichage() {
    push();
    fill(255);
    strokeWeight(1);
    stroke(0);
    ellipse(x, y, 5, 5);

    grilleActive.grille[posx][posy] = couleurPointeur;

    pop();
  }

  void PointeurDevFonctions() {
    Deplacement();
    Affichage();
  }

  void ChangementCouleur() {
    switch(couleurPointeur) {
    case #11AD49 : //Vert
      couleurPointeur = #C64C4C;
      break;
    case #C64C4C : //Rouge
      couleurPointeur = #11AD49;
      break;
    }
  }

  void Debug() {
    println("Pointeur X : " + x + " / Pointueur Y : " + y);
    println("Pointeur posX : " + posx + " / Pointueur posY : " + posy);
  }
}
