boolean start = false;
boolean gagne = false;
boolean clientActif = false;

int joueurNo = 0;

void setup() {
  frameRate(300);
  size(1000, 1000);
  background(0);
  rectMode(CENTER);
  //InitGrille();
  noSmooth();
  //client = new Client(this, "localhost", 5204);
  ID = random(1, 10);
  surface.setTitle("Paper de Kiment Client");
  push();
  textSize(30);
  text("'C' POUR SE CONNECTER", width/2-180, height/3);
  pop();
}

void draw() {
  if (!start) EcrireIP();

  if (clientActif == true) {
    Cli();
    Gestion_xy_Joueurs();
  }

  //background(0);
  //AffichageGrille();

  //Affichage_Joueurs();

  Affichage_Joueurs();

  if (joueur.x != 500) start = true;

  if (start == true) {
    Chrono();
    joueur.Deplacement();

    joueur2.Deplacement();

    if (joueurNo == 3) joueur3.Deplacement();
  }

  //if (start == true) text("true", 10, 10);
  //if (start == false) text("false", 10, 10);
  if (gagne == true) Gagne();

  //if (start ==  false) Debug();
}
