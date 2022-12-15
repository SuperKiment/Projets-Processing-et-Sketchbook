import processing.net.*;

Server serv;

String dataIn;
float [] DataIn;


void setup() {
  size(500, 500);
  serv = new Server(this, 5204);
  
  DataIn = new float [2];
}


void draw() {
  background(0);
  //serv.write();

  Client client = serv.available();
  if (client != null) {
    dataIn = client.readString();
  }
  if (dataIn != null) {
    float list[] = float(split(dataIn, "/"));

    DataIn[0] = list[0];
    DataIn[1] = list[1];
    
    fill(255);
    text(DataIn[0], 20, 20);
    text(DataIn[1], 20, 40);
  }
}
