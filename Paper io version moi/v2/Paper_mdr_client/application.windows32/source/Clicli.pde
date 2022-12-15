import processing.net.*;

Client client;

String z = "4";
float ID;

int compteurCli;

String []DataIn = new String [4];
float[] DataJ1 = new float [5];
float[] DataJ2 = new float [7];
float[] DataJ3 = new float [7];

String dataIn = " coucou";

String ipClient = "192.168.0.";

void Cli() {



  int oriJ1 = Switch_Joueurs_Oris(joueur.orientation);
  int oriJ2 = Switch_Joueurs_Oris(joueur2.orientation);
  int oriJ3 = Switch_Joueurs_Oris(joueur3.orientation);

  compteurCli++;
  z = "0!0!";
  boolean printretard = false;
  if (compteurCli >= 500) {
    printretard = true;
    compteurCli = 0;

    switch(joueurNo) {
    case 2 :
      z = joueur2.x + "!" + joueur2.y + "!";
      break;
    case 3 :
      z = joueur3.x + "!" + joueur3.y + "!";
      break;
    }
  }

  if (joueurNo == 2) z += oriJ2;
  if (joueurNo == 3) z += oriJ3;

  if (printretard == true) println("z : " + z);

  client.write(z + "/" + ID + "/");  

  fill(255);


  if (client.available() != 0) {
    dataIn = client.readString();
    println("dataIn : " + dataIn);
    DataIn = split(dataIn, "/");
    if (start == false) AfficherTableau(DataIn);

    DataJ1 = float(split(DataIn[0], "!"));
    DataJ2 = float(split(DataIn[1], "!"));
    DataJ3 = float(split(DataIn[2], "!"));
  }

  if (DataJ2[3] == ID) joueurNo = 2;
  if (DataJ3[3] == ID) joueurNo = 3;

  if (DataIn[3] == "1") {
    println("DataIn = 1");
  }
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

void EcrireIP() {
  push();
  rectMode(CENTER);
  stroke(255);
  fill(0);
  rect(width/2, height*3/4, 500, 200);
  textSize(30);
  fill(255);
  text(ipClient,400, height*3/4 + 0);
  text("N'utiliser que les touches &é\"'(", 280, height*3/4 -70);
  text("pour entrer l'IP :", 280, height*3/4 -40);
  text("CTRL pour effacer", 280, height*3/4 +70);
  pop();
}
