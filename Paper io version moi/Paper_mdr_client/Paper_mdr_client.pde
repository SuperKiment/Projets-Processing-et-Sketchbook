boolean start = false;
boolean gagne = false;
boolean clientActif = false;

int joueurNo = 0;

void setup() {
  frameRate(500);
  size(1000, 1000);
  background(0);
  rectMode(CENTER);
  //InitGrille();
  noSmooth();
  //client = new Client(this, "localhost", 5204);
  ID = random(1, 10);
}

void draw() {

  if (clientActif == true) {
    Cli();
    Gestion_xy_Joueurs();
  }

  //background(0);
  //AffichageGrille();

  //Affichage_Joueurs();
  joueur.Affichage();



  if (start == true) {
    Chrono();
    joueur.Deplacement();
  }

  if (start == true) text("true", 10, 10);
  if (start == false) text("false", 10, 10);
  if (gagne == true) Gagne();

  Debug();
}
