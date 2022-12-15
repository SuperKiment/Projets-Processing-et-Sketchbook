import processing.net.*;
Server server;

void setup() {
  //fullScreen();
  size(1050, 1050);
  IniImages();
  server = new Server(this, 5050);
  IntGrille();
  IniEcranTruc();
}

void draw() {
  background(100);
  pushMatrix();

  EcranTruc();

  Grille();
  Loup();
  Serv();
  popMatrix();
  Perso();
  Debug();
}

void keyReleased() {
  if (key == 'z') perso1.clickZ = false;
  if (key == 'q') perso1.clickQ = false;
  if (key == 's') perso1.clickS = false;
  if (key == 'd') perso1.clickD = false;

  if (key == 'o') perso2.clickO = false;
  if (key == 'k') perso2.clickK = false;
  if (key == 'l') perso2.clickL = false;
  if (key == 'm') perso2.clickM = false;

  if (key == 'a') perso1.clickA = false;
}


void keyPressed() {
  if (key == 'z') perso1.clickZ = true;
  if (key == 'q') perso1.clickQ = true;
  if (key == 's') perso1.clickS = true;
  if (key == 'd') perso1.clickD = true;
  if (key == 'a') perso1.clickA = true;
}


void IniImages() {
  herbe = loadImage("Herbe.png");
  herbe2 = loadImage("Herbe2.png");
  sol = loadImage("Sol.png");
  sol2 = loadImage("Sol2.png");
  roche = loadImage("Roche.png");

  Perso1 = loadImage("Perso1.png");
  Perso2 = loadImage("Perso2.png");

  imLoup1 = loadImage("Loup1.png");
  imLoup2 = loadImage("Loup2.png");
  imLoup3 = loadImage("Loup3.png");
}


int xecran;
int yecran;

int xaffichage;
int yaffichage;

void IniEcranTruc() {
  xecran = -(perso1.x-11)*50-50;
  yecran = -(perso1.y-11)*50-50;
}

void EcranTruc() {

  if (xaffichage > xecran+1) xaffichage = xaffichage-1;
  if (yaffichage > yecran+1) yaffichage = yaffichage-1;
  if (xaffichage < xecran-1) xaffichage = xaffichage+1;
  if (yaffichage < yecran-1) yaffichage = yaffichage+1;

  translate(xaffichage, yaffichage);
}
