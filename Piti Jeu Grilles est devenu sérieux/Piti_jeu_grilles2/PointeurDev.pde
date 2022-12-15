PointeurDev pointeurDev = new PointeurDev();
color vert_gazon = #11AD49;
color rouge_pointe = #C64C4C;
color blanc = #FFFFFF;
int Pointeur_taille;

class PointeurDev {
  float x, y;
  int posx, posy;
  boolean click = false;
  color couleurPointeur = vert_gazon;
  boolean peinture = false;

  PointeurDev() {
  }

  void Deplacement() {
    x = mouseX - translateX;
    y = mouseY - translateY;

    float x1 = x/grilleActive.tailleRect;  //Position décimale de grille
    float y1 = y/grilleActive.tailleRect;

    posx = Arrondir(x1);     //Position de grille
    posy = Arrondir(y1);

    if (posx<zero) posx = zero;
    if (posy<zero) posy = zero;

    if (posx>grilleActive.taillex-un) posx = grilleActive.taillex-un;
    if (posy>grilleActive.tailley-un) posy = grilleActive.tailley-un;
  }

  void Affichage() {
    push();
    fill(blanc);
    strokeWeight(un);
    stroke(noir);
    ellipse(x, y, Pointeur_taille, Pointeur_taille);
    pop();
  }

  void Peinture() {   //Changer les couleurs du terrain
    if (peinture) {
      grilleActive.grille[posx][posy] = couleurPointeur;
    }
  }

  void PointeurDevFonctions() {
    Deplacement();
    Affichage();             //Fonctions du pointeur
    Peinture();
  }


  void ChangementPeinture() {
    if (peinture) peinture = false;     //Activation de la peinture
    else if (!peinture) peinture = true;
  }

  void Debug() {
    println("Pointeur X : " + x + " / Pointueur Y : " + y);
    println("Pointeur posX : " + posx + " / Pointueur posY : " + posy);
  }
}
