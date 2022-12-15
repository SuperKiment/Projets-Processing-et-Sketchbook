boolean start = false;
boolean gagne = false;

void setup() {
  frameRate(500);
  size(1000, 1000);
  background(0);
  rectMode(CENTER);
  //InitGrille();
  noSmooth();
  server = new Server(this, 5204);
}

void draw() {
  Serv();
  if (start == false) {
    background(0);
    Interface();
  }
  //AffichageGrille();

  Affichage_Joueurs();
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
