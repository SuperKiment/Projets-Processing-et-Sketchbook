import processing.net.*;

Server serv;

String dataIn;
float [] DataIn;

float ID1;
float ID2;


void setup() {
  size(500, 500);
  serv = new Server(this, 5204);

  DataIn = new float [2];
}


void draw() {
  background(0);
  serv.write("hehe");

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

    if (ID1 == 0) ID1 = DataIn[1];
    if (ID2 == 0 && DataIn[1] != ID1) ID2 = DataIn[1];
  }

  text(ID1, 100, 20);
  text(ID2, 100, 40);
}
