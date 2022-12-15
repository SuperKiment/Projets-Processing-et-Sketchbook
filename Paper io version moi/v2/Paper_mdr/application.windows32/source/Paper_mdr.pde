boolean start = false;
boolean gagne = false;

void setup() {
  frameRate(300);
  size(1000, 1000);
  background(0);
  rectMode(CENTER);
  //InitGrille();
  noSmooth();
  server = new Server(this, 5204);
  surface.setTitle("Paper de Kiment Server");
}

void draw() {
  Serv();
  if (start == false) {
    background(0);
    Interface();
    push();
    textSize(30);
    fill(255);
    text("'ESPACE' POUR DEMARRER", width/2-180, height/3);
    pop();
  }
  //AffichageGrille();

  Affichage_Joueurs();
  joueur.Affichage();



  if (start == true) {
    Chrono();
    joueur.Deplacement();

    if (ID1 != 0) joueur2.Deplacement();
    if (ID2 != 0) joueur3.Deplacement();
  }

  //if (start == true) text("true", 10, 10);
  //if (start == false) text("false", 10, 10);
  if (gagne == true) Gagne();




  //if (start == false) Debug();
}
