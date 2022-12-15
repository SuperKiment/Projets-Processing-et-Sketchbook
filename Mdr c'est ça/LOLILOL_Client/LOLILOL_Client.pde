import processing.net.*;
Client client;

void setup() {
  size(500, 500);
  client = new Client(this, "localhost", 5050);
}

void draw() {
  background(0);
  fill(255);

  Client();
}
