import processing.net.*;

Bateau bat = new Bateau(100, 100);

void setup() {
  size(1080, 720);
  background(0);
  rectMode(CENTER);
  textAlign(CENTER);
  noStroke();
  
  serv = new Server(this, 5204);

  Setup_Bateaux();
}

void draw() {
  background(0);
  bat.Affichage();
  //bat.Print();

  Fonctions_Bateaux();
}
