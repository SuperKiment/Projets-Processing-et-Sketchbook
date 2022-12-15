import processing.net.*;

Client client;

String z = "4";
float ID;


void setup() {
  frameRate(200);
  size(500, 500);
  client = new Client(this, "localhost", 5204);

  ID = random(1, 10);
}

void draw() {
  
  z = mouseX + "." + mouseY;
  
  background(0);
  client.write(z + "/" + ID);

  fill(255);
  text(z + "       " + ID, 20, 60);
  String dataIn = " coucou";
  if (client.available() != 0) {
    println("presque lu");
    dataIn = client.readString();
    println("Et lu");
    println("client : " + dataIn); 
  }
  
  text(dataIn, 200, 200);
}
