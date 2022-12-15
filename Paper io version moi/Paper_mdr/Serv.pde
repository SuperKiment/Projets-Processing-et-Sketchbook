import processing.net.*;
Server server;
String []DataIn = new String[2];
String dataIn;
float ID1 = 0;
float ID2 = 0;

String dataOut = "test no 15641";

String dataIn1;
String dataIn2;

void Serv() {



  Client client = server.available();
  if (client != null) {
    dataIn = client.readString();
  }
  if (dataIn != null) {
    String list[] = split(dataIn, "/");

    DataIn[0] = list[0];
    DataIn[1] = list[1];

    push();
    fill(255);
    //text(DataIn[0], 20, 20);
    //text(DataIn[1], 20, 40);
    pop();

    if (ID1 == 0) ID1 = float(DataIn[1]);
    if (ID2 == 0 && float(DataIn[1]) != ID1) ID2 = float(DataIn[1]);

    if (float(DataIn[1]) == ID1) dataIn1 = DataIn[0];
    if (float(DataIn[1]) == ID2) dataIn2 = DataIn[0];
  }

  String infoJ1 = "0!0!0";
  String infoJ2 = "0!0!0!0";
  String infoJ3 = "0!0!0!0";  //mettre les infos là dessous

  int oriJ1 = Switch_Joueurs_Oris(joueur.orientation);
  int oriJ2 = Switch_Joueurs_Oris(joueur2.orientation);
  int oriJ3 = Switch_Joueurs_Oris(joueur3.orientation);

  

  dataOut = joueur.x + "!" + joueur.y + "!" + oriJ1 + "/" + joueur2.x + "!" + joueur2.y + "!" + oriJ2 + "!" + ID1 + "/" + joueur3.x + "!" + joueur3.y + "!" + oriJ3 + "!" + ID2 + "/";
  server.write(dataOut);
  //x1.y1.o1/x2.y2.o2.ID/x3.y3.o3.ID/

  //text(ID1, 100, 20);
  //text(ID2, 100, 40);
}


int Switch_Joueurs_Oris(int ori_base) {
  int oriJ = 0;
  switch(ori_base) {
  case 'd':
    oriJ = 0;
    break;
  case 'h':
    oriJ = 1;        // d : 0 / h : 1 / g : 2 / b : 3
    break;
  case 'g':
    oriJ = 2;
    break;
  case 'b':
    oriJ = 3;
    break;
  }
  return oriJ;
}
