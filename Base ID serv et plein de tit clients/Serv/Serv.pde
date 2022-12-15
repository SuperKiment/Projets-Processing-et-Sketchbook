import processing.net.*;

Server server;
Client client;
String dataIn = "0 / 0 / 0";
String client1 = "1";
String client2 = "2";

String DataIn[] = new String[40];
String dataOut = "10 / 20";

int [] IDs = new int [10];
int [] Xmouse = new int[10];
int [] Ymouse = new int[10];


void setup() {
  size(500, 500);
  server = new Server(this, 5050);
}

void draw() {

  server.write(dataOut); //<>//

  client = server.available();

  if (client != null) {
    dataIn = String.valueOf(client.readString());

    String list[] = split(dataIn, " / ");

    for (int i = 0; i<list.length; i++) {
      DataIn[i] = list[i];
    }

    for (int i = 0; i<10; i++) {
      if (int(DataIn[2]) != IDs[i]) {
        if (IDs[0] == 0) IDs[0] = int(DataIn[2]);
        if (IDs[0] != 0 && IDs[1] == 0 && IDs[0] != int(DataIn[2])) IDs[1] = int(DataIn[2]);
        if (IDs[0] != 0 && IDs[1] != 0 && IDs[2] == 0 && IDs[0] != int(DataIn[2]) && IDs[1] != int(DataIn[2])) IDs[2] = int(DataIn[2]);
      }
    }

    for (int i = 0; i<10; i++) {
      if (int(DataIn[2]) == IDs[i]) Xmouse[i] = int(DataIn[0]);
      if (int(DataIn[2]) == IDs[i]) Ymouse[i] = int(DataIn[0]);
    }
  }

  background(0);
  fill(255);
  text(client1, 50, 20);
  text(client2, 50, 40);
  text(dataIn, 50, 60);
  text(IDs[0] + "  " + Xmouse[0] + "  " + Ymouse[0], 50, 80);
  text(IDs[1] + "  " + Xmouse[1] + "  " + Ymouse[1], 50, 100);
  text(IDs[2] + "  " + Xmouse[2] + "  " + Ymouse[2], 50, 120);


  for (int i = 0; i<DataIn.length; i++) DataIn[i] = null;
}
