class Villageois {
  float x;
  float y;
  float rayon;
  float orientation;
  float xdest;
  float ydest;

  boolean arrive = true;
  boolean attend = true;

  Villageois(float newx, float newy, float newrayon, float newori) {
    x = newx;
    y = newy;
    rayon = newrayon;
    orientation = newori;
  }

  void Affichage() {
    rectMode(CENTER);
    rect(x, y, 50, 50);
  }

  void Deplacement(int vitesse) {

    if (mousePressed == true && mouseButton == RIGHT) {
      xdest = (mouseX/echelle - xOrigine);
      ydest = (mouseY/echelle - yOrigine);
      arrive = false;
    }

    if (arrive == false) {
      if (abs(x-xdest) > vitesse+1) {
        if (x - xdest < 0 ) x = x + vitesse;
        if (x - xdest > 0 ) x = x - vitesse;    //Arrivé = true   -->  Deplacement vers le point
      }
      if (abs(y-ydest) > vitesse+1) {
        if (y - ydest < 0 ) y = y + vitesse;
        if (y - ydest > 0 ) y = y - vitesse;
      }
    }
  }
}

void Villageois() {
  no1.Deplacement(2);
  no1.Affichage();

  no2.Deplacement(4);
  no2.Affichage();
  
  no3.Deplacement(10);
  no3.Affichage();
}



Villageois no1 = new Villageois(0, 0, 100, 0);
Villageois no2 = new Villageois(400, 600, 100, 0);
Villageois no3 = new Villageois(100, 200, 100, 0);
