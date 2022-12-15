PImage imLoup1;
PImage imLoup2;
PImage imLoup3;

Loup loup1 = new Loup(4, 5, 10, 10, 1, 0);
Loup loup2 = new Loup(10, 12, 10, 10, 2, 0);
Loup loup3 = new Loup(14, 4, 10, 10, 3, 1);
Loup loup4 = new Loup(13, 7, 10, 10, 1, 1);
Loup loup5 = new Loup(12, 9, 10, 10, 3, 1);

class Loup {
  int x;
  int y;

  float HP;
  int lvl;
  int force;

  float orientation;

  int timer;
  int temps;
  

  int noDim;

  int xSui, ySui, vitesseSui = 10;

  PImage apparence;
  int noapparence;

  Loup(int newx, int newy, int newlvl, int newforce, int newnoapparence, int nodim) {
    x = newx;
    y = newy;
    lvl = newlvl;
    force = newforce;
    noapparence = newnoapparence;
    noDim = nodim;
    xSui = newx*50;
    ySui = newy*50;
  }

  void Affichage() {
    /*push();
     TranslateArPl();
     imageMode(CORNER);
     //rotate(-orientation);
     rect(x*50, y*50, 50, 50);    
     pop();*/
    Suiveur();
  }

int bougeX, bougeY;

  void Idle(Terrain dimension) {

    if (timer > temps) {

      bougeX = int(random(-1.4, 1.4));
      bougeY = int(random(-1.4, 1.4));

      if (bougeX == -1 && x > 0 && VerifCollisionOk(x, y, dimension.Grille, 'g')) {
        x--;
        orientation = PI;
      }
      if (bougeX ==  1 && x < dimension.x-1 && VerifCollisionOk(x, y, dimension.Grille, 'd')) {
        x = x+1;
        orientation = 0;
      }
      if (bougeY == -1 && y > 0 && VerifCollisionOk(x, y, dimension.Grille, 'h')) {
        y = y-1;
        orientation = PI/2;
      }
      if (bougeY ==  1 && y < dimension.y-1 && VerifCollisionOk(x, y, dimension.Grille, 'b')) {
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
    if (dimensionActive == noDim)Affichage();
    if (noDim == 0) Idle(Dim0);
    if (noDim == 1) Idle(Dim1);
  }

  void Suiveur() {
    push();

    if (x*50>xSui) xSui+=vitesseSui;
    if (x*50<xSui) xSui-=vitesseSui;
    if (y*50>ySui) ySui+=vitesseSui;
    if (y*50<ySui) ySui-=vitesseSui;

    TranslateArPl(true);    

    fill(255);
    rect(xSui, ySui, 50, 50);

    pop();
  }
}

void Loup() {
  loup1.TrucsQuiSontPassifs();
  loup2.TrucsQuiSontPassifs();
  loup3.TrucsQuiSontPassifs();
  loup4.TrucsQuiSontPassifs();
  loup5.TrucsQuiSontPassifs();
}
