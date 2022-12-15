import processing.net.*;
Client client;
Server server;

boolean activation_client = false;

String dataOut;
String dataIn;


void setup() {
  size(500, 500);

  server = new Server(this, 5203);
}

void draw() {
  if (millis() >= 5000 & activation_client == false) { 
    activation_client = true;
    client = new Client(this, "127.0.0.1", 5204);
  }

  background(0);
  fill(255);
  text(millis(), 100, 100);


  dataOut = String.valueOf(mouseX);
  server.write(dataOut);

  client = server.available();
  if (client != null) dataIn = client.readString();

  println("dataIn : " + dataIn + " / dataOut : " + dataOut + 
    " / Client actif : " + activation_client);
}
