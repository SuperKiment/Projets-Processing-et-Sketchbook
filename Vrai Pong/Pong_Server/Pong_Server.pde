import processing.net.*;

Server server;

int test;

boolean start = false;

int scoreG;
int scoreD;
int compteurRebond;

Balle balle1 = new Balle(500, 500, random(1, 3), random(0, 3));
Balle balle2 = new Balle(500, 500, random(1, 3), random(0, 3));

Raquette raquette1 = new Raquette(20 , 20, 5, 100);
Raquette raquette2 = new Raquette(980, 20, 5, 100);

void setup() {
  frameRate(60);
  size(500, 500);
  background(0);
  fill(255);

  server = new Server(this, 5204);
}

void draw() {
  background(0);
  Test();

  Deplacement_Raquettes();

  Affichage_des_valeurs();
  
  if (start == true) Balle();

  Recup_Donnees();
  Envoi_Donnees();
}



void keyPressed() {
}

void keyReleased() {
  if (key == ' ') start = true;
}





void Test() {
  test = test + 1;
  if (test >= 100) test = 0;
}
