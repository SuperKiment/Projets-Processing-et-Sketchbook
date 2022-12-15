PImage imLoup1;
PImage imLoup2;
PImage imLoup3;

Loup loup1 = new Loup(4, 5, 10, 10, 1);
Loup loup2 = new Loup(10, 12, 10, 10, 2);
Loup loup3 = new Loup(14, 4, 10, 10, 3);
Loup loup4 = new Loup(13, 7, 10, 10, 1);
Loup loup5 = new Loup(12, 9, 10, 10, 3);

class Loup {
  int x;
  int y;

  float HP;
  int lvl;
  int force;

  float orientation;

  int timer;
  int temps;
  int bougeX;
  int bougeY;

  PImage apparence;
  int noapparence;

  Loup(int newx, int newy, int newlvl, int newforce, int newnoapparence) {
    x = newx;
    y = newy;
    lvl = newlvl;
    force = newforce;
    noapparence = newnoapparence;
  }

  void Affichage() {
    push();
    translate(x*50, y*50);
    imageMode(CENTER);
    rotate(-orientation);
    apparence = loadImage("Loup" + String.valueOf(noapparence) + ".png");
    image(apparence, 0, 0, 100, 100);
    pop();
  }

  void Idle() {

    if (timer > temps) {

      bougeX = int(random(-1.4, 1.4));
      bougeY = int(random(-1.4, 1.4));

      if (bougeX == -1 && x > 0 && Tableau[x-1][y] != 1) {
        x = x-1;
        orientation = PI;
      }
      if (bougeX ==  1 && x < tailleGrille-1 && Tableau[x+1][y] != 1) {
        x = x+1;
        orientation = 0;
      }
      if (bougeY == -1 && y > 0 && Tableau[x][y-1] != 1) {
        y = y-1;
        orientation = PI/2;
      }
      if (bougeY ==  1 && y < tailleGrille-1 && Tableau[x][y+1] != 1) {
        y = y+1;
        orientation = -PI/2;
      }

      TimerReinit();
    }

    timer++;
  }

  void TimerReinit() {
    timer = 0;
    temps = int(random(20, 70));
  }

  void TrucsQuiSontPassifs() {
    Affichage();
    Idle();
  }
}

void Loup() {
  loup1.TrucsQuiSontPassifs();
  loup2.TrucsQuiSontPassifs();
  loup3.TrucsQuiSontPassifs();
  loup4.TrucsQuiSontPassifs();
  loup5.TrucsQuiSontPassifs();
}
