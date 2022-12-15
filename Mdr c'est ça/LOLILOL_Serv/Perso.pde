PImage Perso1;
PImage Perso2;

Perso perso1 = new Perso(11, 11, 1, Perso1);
Perso perso2 = new Perso(4, 4, 2, Perso2);

class Perso {
  int x;
  int y;
  int no;
  PImage image = herbe;
  float orientation;
  float HP;
  int vitesse = 5;
  int doublevitesse = vitesse/2;
  int timing;

  boolean clickZ = false;
  boolean clickQ = false;
  boolean clickS = false;
  boolean clickD = false;

  boolean clickO = false;
  boolean clickK = false;
  boolean clickL = false;
  boolean clickM = false;

  boolean clickA = false;

  int timingZ;
  int timingQ;
  int timingS;
  int timingD;


  Perso(int newx, int newy, int newno, PImage newimage) {
    x = newx;
    y = newy;
    no = newno;
    image = newimage;
  }


  void Deplacement() {

    if (clickZ == true && Tableau[x][y-1] != 1 && y > 1) {
      timingZ++;
      if (timingZ > vitesse) {
        timingZ = 0;
        y = y-1;
        orientation = PI/2;
      }
    }
    if (clickQ == true && Tableau[x-1][y] != 1 && x > 1) {
      timingQ++;
      if (timingQ > vitesse) {
        timingQ = 0;
        x = x-1;
        orientation = PI;
      }
    }
    if (clickS == true && Tableau[x][y+1] != 1 && y < tailleGrille - 2) {
      timingS++;
      if (timingS > vitesse) {
        timingS = 0;
        y = y+1;
        orientation = -PI/2;
      }
    }
    if (clickD == true && Tableau[x+1][y] != 1 && x < tailleGrille - 2) {
      timingD++;
      if (timingD > vitesse) {
        timingD = 0;
        x = x+1;
        orientation = 0;
      }
    }

    if (clickA == true) {
      vitesse = doublevitesse;
    }

    if (clickA == false) {
      vitesse = 2*doublevitesse;
    }



    if (Tableau[x][y] == 1) x = x+1;
  }

  void Affichage() {
    image = loadImage("Perso" + no + ".png");


    if (no == 1) {
      push();
      translate(1050/2, 1050/2);
      rotate(-orientation);
      imageMode(CENTER);
      image(image, 0, 0);
      pop();
    }

    if (no != 1) {
      push();
      translate(-(perso1.x-11)*50-25 + x*50, -(perso1.y-11)*50-25 + y*50);
      imageMode(CENTER);
      rotate(-orientation);
      image(image, 0, 0);
      pop();
    }
  }




  void Passifs() {
    Deplacement();
    Affichage();
  }
}



void Perso() {
  perso1.Passifs();
  perso2.Passifs();
}
