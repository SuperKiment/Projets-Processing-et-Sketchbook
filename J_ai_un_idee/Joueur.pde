class Joueur {
  float x;
  float y;
  float orientation = 0;
  float vitesse = 3;

  boolean depHaut = false;
  boolean depBas = false;
  boolean depGauche = false;
  boolean depDroite = false;

  int hp = 100;

  Joueur() {
  }

  void Affichage() {

    if (depHaut == true && depBas == false && depGauche == false && depDroite == false) orientation = PI/2   ;  //h
    if (depHaut == true && depBas == false && depGauche == false && depDroite == true)  orientation = PI/4   ;  //hd
    if (depHaut == false && depBas == false && depGauche == false && depDroite == true) orientation = 0      ;  //d
    if (depHaut == false && depBas == true && depGauche == false && depDroite == true)  orientation = -PI/4  ;  //db
    if (depHaut == false && depBas == true && depGauche == false && depDroite == false) orientation = -PI/2  ;  //b
    if (depHaut == false && depBas == true && depGauche == true && depDroite == false)  orientation = -3*PI/4;  //bg
    if (depHaut == false && depBas == false && depGauche == true && depDroite == false) orientation = PI     ;  //g
    if (depHaut == true && depBas == false && depGauche == true && depDroite == false)  orientation = 3*PI/4 ;  //gh

    pushMatrix();
    translate(350, 300);
    rotate(-orientation);     //Je sais pas pourquoi mais c'est inversé

    fill(100, 100, 100, 255);
    stroke(0);
    rectMode(CENTER);           //Personnage (bon là c'est un carré mdr)
    rect(0, 0, 50, 50);
    line(0, 0, 25, 0);       //Et une ligne pour l'orientation

    popMatrix();

    pushMatrix();
    translate(350, 350);
    noStroke();              //Barre de vie
    fill(30);
    rect(0, 0, 55, 8);
    rectMode(CORNER);
    fill(255, 0, 0);
    rect(-25.5, -2.5, hp/2, 5);
    fill(255);
    text(hp + "/100", 0, 15);
    popMatrix();
  }

  void Deplacement() {
    if (orientation == PI/4 ||orientation == 3*PI/4 ||orientation == -PI/4 ||orientation == -3*PI/4 ) {
      vitesse = 3*sqrt(2)/2;                                //Pour avoir une vitesse constante entre orthogonal et diagonal
    } else vitesse = 3;
    if (depHaut == true)   y = y + vitesse;
    if (depBas == true)    y = y - vitesse;
    if (depGauche == true) x = x + vitesse;
    if (depDroite == true) x = x - vitesse;
  }

  void Attaques() {
    if (keyPressed == true && key == 'k' && slash1.actif == false) {
      slash1.Ini(100, true, -orientation);
    }
    if (slash1.actif == true) {
      slash1.Attaque(350, 300, 30, 70, 1);
    }
  }
}

void Joueur() {
  joueur2.Deplacement();
  joueur2.Affichage();
  joueur2.Attaques();



  joueur.Deplacement();
  joueur.Affichage();
  joueur.Attaques();
}

Joueur joueur = new Joueur();

Slash slash1 = new Slash();
