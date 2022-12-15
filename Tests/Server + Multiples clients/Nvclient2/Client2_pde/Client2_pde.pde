import processing.net.*;

Client client;

int z = 4;
float ID;


void setup() {
  size(500, 500);
  client = new Client(this, "localhost", 5204);

  ID = random(1, 10);
}

void draw() {
  z = mouseX;
  background(0);
  client.write(z + "/" + ID);
  
  fill(255);
  text(z + "       " + ID, 20, 60);
}
