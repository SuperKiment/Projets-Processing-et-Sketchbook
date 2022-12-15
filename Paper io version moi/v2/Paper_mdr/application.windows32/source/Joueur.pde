Joueur joueur = new Joueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 500, 500);

class Joueur {

  float x, y;
  float xspawn, yspawn;
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
    xspawn = newx;
    yspawn = newy;
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

    if (start == false) {
      x = xspawn;
      y = yspawn;
    }
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

AJoueur joueur2 = new AJoueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 200, 200);
AJoueur joueur3 = new AJoueur(color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255))), 700, 700);

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

  void Lignes() {
  }
}

//---------------------------------------------------------------------------

void Affichage_Joueurs() {
  if (ID1 != 0) {

    float[] xyJoueur2 = new float[3];

    joueur2.Affichage();

    xyJoueur2 = float(split(dataIn1, "!"));

    if (xyJoueur2[0] !=0 || xyJoueur2[1] != 0) {

      joueur2.x = xyJoueur2[0];
      joueur2.y = xyJoueur2[1];
    }

    joueur2.orientation = Switch_Joueur_Ori_char(int(xyJoueur2[2]));
  }

  if (ID2 != 0 && ID1 !=0) {

    float[] xyJoueur3 = new float[3];

    joueur3.Affichage();

    if (dataIn2 != null) {
      xyJoueur3 = float(split(dataIn2, "!"));
    }

    if (xyJoueur3[0] !=0 || xyJoueur3[1] !=0) {

      joueur3.x = xyJoueur3[0];
      joueur3.y = xyJoueur3[1];
    }

    joueur3.orientation = Switch_Joueur_Ori_char(int(xyJoueur3[2]));
  }
}

char Switch_Joueur_Ori_char(int base) {    //Transforme 0123 en dghb
  char finalite = 'd';
  switch(base) {
  case 0:
    finalite = 'd';
    break;
  case 1:
    finalite = 'h';
    break;
  case 2:
    finalite = 'g';
    break;
  case 3:
    finalite = 'b';
    break;
  }
  return finalite;
}
