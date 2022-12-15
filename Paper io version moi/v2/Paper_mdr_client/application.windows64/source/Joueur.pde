Joueur joueur = new Joueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 500, 500);

class Joueur {

  float x;
  float y;
  int vitesse = 1;
  char orientation = 'd';
  color couleur;
  color couleurligne;
  color couleurVerif;

  float coorPt1 = 100;
  float coorPt2 = 200;

  Joueur(color newcouleur, float newx, float newy) {
    couleur = newcouleur;
    couleurligne = couleur-125;
    couleurVerif = couleurligne-100;
    x = newx;
    y = newy;
  }

  void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurVerif);
    rect(20, 0, 20, 60);

    pop();

    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();
  }

  void D() {
    if (orientation != 'g') orientation = 'd';
  }
  void G() {
    if (orientation != 'd') orientation = 'g';
  }
  void H() {
    if (orientation != 'b') orientation = 'h';
  }
  void B() {
    if (orientation != 'h') orientation = 'b';
  }

  void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }

  void Lignes() {
  }
}

//---------------------------------------------------------------------------------------------

Joueur joueur2 = new Joueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 200, 200);
Joueur joueur3 = new Joueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 700, 700);

class AJoueur {

  float x;
  float y;
  int vitesse = 1;
  char orientation = 'd';
  color couleur;
  color couleurligne;
  color couleurVerif;

  float coorPt1 = 100;
  float coorPt2 = 200;

  AJoueur(color newcouleur, float newx, float newy) {
    couleur = newcouleur;
    couleurligne = couleur-125;
    couleurVerif = couleurligne-100;
    x = newx;
    y = newy;
  }

  void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurVerif);
    rect(20, 0, 20, 60);

    pop();
    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();
  }

  void D() {
    if (orientation != 'g') orientation = 'd';
  }
  void G() {
    if (orientation != 'd') orientation = 'g';
  }
  void H() {
    if (orientation != 'b') orientation = 'h';
  }
  void B() {
    if (orientation != 'h') orientation = 'b';
  }

  void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }

/*
  void Lignes() {
  }*/
}

/*
void Affichage_Joueurs() {
 if (ID1 != 0) {
 
 float[] xyJoueur2 = new float[2];
 
 joueur2.Affichage();
 
 xyJoueur2 = float(split(dataIn1, "."));
 
 if (xyJoueur2[0] !=0 || xyJoueur2[1] !=0) {
 
 joueur2.x = xyJoueur2[0];
 joueur2.y = xyJoueur2[1];
 
 }
 }
 }
 */


//--------------------------------------Gestion client--------------------

void Gestion_xy_Joueurs() {
  if (DataJ1[0] != 0) {

    joueur.x = DataJ1[0];
    joueur.y = DataJ1[1];

    switch(int(DataJ1[2])) {
    case 0 :
      joueur.orientation = 'd';      //Gestion de l'envoi DataInJx vers joueur.x/y 
      break;
    case 1 :
      joueur.orientation = 'h';
      break;
    case 2 :
      joueur.orientation = 'g';
      break;
    case 3 :
      joueur.orientation = 'b';
      break;
    }
  }
}


void Affichage_Joueurs() {
  joueur.Affichage();
  if (joueurNo == 2) {
    joueur2.Affichage();
  }
  if (joueurNo == 3) {
    joueur2.Affichage();
    joueur3.Affichage();
  }
}
