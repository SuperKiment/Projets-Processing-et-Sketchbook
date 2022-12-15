PImage Porteur_Sheet;
Porteur no1;
Porteur no2;
Porteur no3;
Porteur no4;
Porteur no5;
Porteur no6;
Porteur no7;
Porteur no8;
Porteur no9;
Porteur no10;


void Porteur_Setup() {

  Porteur_Sheet = loadImage("Porteur_Sheet.png");
  no1 = new Porteur (0, 845);
  no2 = new Porteur (1920/10, 845);
  no3 = new Porteur (1920/10*2, 845);
  no4 = new Porteur (1920/10*3, 845);
  no5 = new Porteur (1920/10*4, 845);
  no6 = new Porteur (1920/10*5, 845);
  no7 = new Porteur (1920/10*6, 845);
  no8 = new Porteur (1920/10*7, 845);
  no9 = new Porteur (1920/10*8, 845);
  no10 = new Porteur(1920/10*9, 845);
}


void Porteur_Draw() {
  no1.affichage();
  no2.affichage();
  no3.affichage();
  no4.affichage();
  no5.affichage();
  no6.affichage();
  no7.affichage();
  no8.affichage();
  no9.affichage();
  no10.affichage();
}


class Porteur {
  int xpos;
  int ypos;
  PImage[] Images = new PImage [6];
  int Compteur;

  Porteur (int x, int y) {

    for (int i = 0; i<6; i++) {
      Images[i] = Porteur_Sheet.get(i*320, 0, 320, 700);
    }

    xpos = x;
    ypos = y;
  }

  void affichage() {
    Compteur = Compteur + 1;
    if (Compteur == 6) {
      Compteur = 0;
    }
    
    image(Images[Compteur], xpos, ypos, 160, 350);
  }
}
