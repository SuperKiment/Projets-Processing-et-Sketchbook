import processing.net.*;

int haut = 0;
int bas  = 0;

float ID;

Client client;

void setup() {
  frameRate(60);
  size(1500, 1000);
  client = new Client(this, "localhost", 5204);

  ID = random(1, 10);
}

void draw() {
  background(0);


  Recup_Donnees();
  Envoi_Donnees();
}

void keyPressed() {
  if (key == 'a') haut = 1; 
  if (key == 'q') bas  = 1;
}

void keyReleased() {
  if (key == 'a') haut = 0; 
  if (key == 'q') bas  = 0;
}
