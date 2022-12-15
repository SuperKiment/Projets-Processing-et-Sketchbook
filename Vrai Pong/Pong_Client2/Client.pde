String dataIn;
float DataIn[] = new float[7];
String dataOut;

void Recup_Donnees() {
  if (client.available() != 0) {
    dataIn = client.readString();
  }

  if (dataIn != null) {
    float list[] = float(split(dataIn, '/'));


    for (int i = 0; i <= 6; i ++) {
      DataIn[i] = list[i];
      println("i = " + i + "       Data : " +list[i]);
    }


    text(dataIn + "      " + ID, 20, 20);
  }
}

void Envoi_Donnees() {
  //haut, bas
  dataOut = String.valueOf(haut) + "/" + String.valueOf(bas) + "/" + String.valueOf(ID);

  client.write(dataOut);
}
