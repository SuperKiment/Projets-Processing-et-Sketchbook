//Balle1 x, Balle1 y, Balle2 x, Balle2 y, Taille Balle1, Taille Balle2, Raquette1 y, Raquette2 y, Taille Raqu1, Taille Raqu2, scoreG, scoreD,
String dataOut;
String dataIn;
float DataIn[] = new float[4];

String ip;

void Envoi_Donnees() {

  dataOut = String.valueOf(balle1.x) + "/" + String.valueOf(balle1.y) + "/" + String.valueOf(balle2.x) + "/" + String.valueOf(balle2.y) + "/" + String.valueOf(balle1.taille) + "/" + String.valueOf(balle2.taille) + "/" + String.valueOf(raquette1.y) + "/" + String.valueOf(raquette2.y) + "/" + String.valueOf(raquette1.taille) + "/" + String.valueOf(raquette2.taille) + "/" + String.valueOf(scoreG) + "/" + String.valueOf(scoreD) + "/";
  //                Balle1 x                   Balle1 y                         Balle2 x                           Balle2 y                         Taille Balle1                         Taille Balle2                     Raquette1 y                            Raquette2 y                            Taille Raqu 1                           Taille Raqu 2                          ScoreG                          ScoreD
  server.write(dataOut);
}


void Recup_Donnees() {
  Client client =  server.available();
  if (client !=null) {
    dataIn = client.readString();       //Passe le read dans dataIn
  }


  if (dataIn != null) {
    float list[] = float(split(dataIn, '/'));  //Split le dataIn

    for (int i = 0; i <= 3; i ++) {  //Passe le dataIn dans DataIn
      DataIn[i] = list[i];
      println("i = " + i + "       Data : " +list[i] + "       ID : " + list[2]);
    }
  }

  Traitement_Donnees();
}
