
class Joueur_2 {
  float x = 100;
  float y = 200;
  float orientation = PI;
  float vitesse = 3;

  boolean depHaut = false;
  boolean depBas = false;           //pareil que le 1 mais indépendant
  boolean depGauche = false;
  boolean depDroite = false;

  int hp = 100;

  Joueur_2() {
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
    translate(joueur.x + x, joueur.y + y);
    rotate(-orientation);     //Je sais pas pourquoi c'est inversé

    fill(200, 200, 200, 255);
    stroke(255);
    rectMode(CENTER);
    rect(0, 0, 50, 50);

    line(0, 0, 25, 0);

    popMatrix();

    pushMatrix();
    translate(joueur.x + x, joueur.y + y + 50);
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
    if (depHaut == true)   y = y - vitesse;
    if (depBas == true)    y = y + vitesse;
    if (depGauche == true) x = x - vitesse;
    if (depDroite == true) x = x + vitesse;
  }
  
  void Attaques() {
    if (keyPressed == true && key == 'a' && slash2.actif == false) {
      slash2.Ini(100, true, -orientation);
    }
    if (slash2.actif == true) {
      slash2.Attaque(x, y, 30, 70, 2);
    }
  }
}
Joueur_2 joueur2 = new Joueur_2();

Slash slash2 = new Slash();
