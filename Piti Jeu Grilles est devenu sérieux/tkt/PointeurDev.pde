PointeurDev pointeurDev = new PointeurDev();

class PointeurDev {
  float x, y;
  int posx, posy;
  boolean click = false;
  color couleurPointeur = tweakmode_int[251];
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

    if (posx<tweakmode_int[224]) posx = tweakmode_int[225];
    if (posy<tweakmode_int[226]) posy = tweakmode_int[227];

    if (posx>grilleActive.taillex-tweakmode_int[228]) posx = grilleActive.taillex-tweakmode_int[229];
    if (posy>grilleActive.tailley-tweakmode_int[230]) posy = grilleActive.tailley-tweakmode_int[231];
  }

  void Affichage() {
    push();
    fill(tweakmode_int[232]);
    strokeWeight(tweakmode_int[233]);
    stroke(tweakmode_int[234]);
    ellipse(x, y, tweakmode_int[235], tweakmode_int[236]);
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
