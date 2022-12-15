import processing.net.*;

Client client;

String z = "4";
float ID;

int compteurCli;

String []DataIn = new String [2];
float[] DataJ1 = new float [3];
float[] DataJ2 = new float [4];
float[] DataJ3 = new float [4];

String dataIn = " coucou";

String ipClient = "192.168.0.177";

void Cli() {
  
  int oriJ1 = Switch_Joueurs_Oris(joueur.orientation);
  int oriJ2 = Switch_Joueurs_Oris(joueur2.orientation);
  int oriJ3 = Switch_Joueurs_Oris(joueur3.orientation);

  compteurCli++;
  z = "0.0";
  if (compteurCli >= 500) {
    compteurCli = 0;
    
    switch(joueurNo) {
      case 2:
      z = joueur2.x + "!" + joueur2.y + "!" + oriJ2;
      break;
      case 3:
      z = joueur3.x + "!" + joueur3.y + "!" + oriJ3;
      break;
    }
  }

  client.write(z + "/" + ID + "/");  

  fill(255);


  if (client.available() != 0) {
    dataIn = client.readString();
    println("dataIn : " + dataIn);
    DataIn = split(dataIn, "/");

    DataJ1 = float(split(DataIn[0], "!"));
    DataJ2 = float(split(DataIn[1], "!"));
    DataJ3 = float(split(DataIn[2], "!"));
  }

  text(dataIn, 200, 200);

  if (DataJ2[3] == ID) joueurNo = 2;
  if (DataJ3[3] == ID) joueurNo = 3;
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
