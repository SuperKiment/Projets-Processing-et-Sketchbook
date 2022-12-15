void RecupData() {
  if (client.available() != 0) {
    dataIn = String.valueOf(client.readString());
    String list[] = split(dataIn, " / ");
    for (int i = 0; i<list.length; i++) {
      DataIn[i] = list[i];
    }
  }
}

int ID = int(random(100000, 999999));

void EnvoiDataClear() {

  DataOutRep();

  for (int i = 0; i<DataOut.length; i++) {
    if (i == 0) dataOut = DataOut[0];
    
    if (DataOut[i] != null && i>0) {
      dataOut = dataOut + " / " + DataOut[i];
    }
  }

  client.write(dataOut);
  
  for (int i = 0; i<DataIn.length; i++) DataIn[i] = null;
  client.clear();
  dataOut = null;
}

void DataOutRep() {
  DataOut[0] =String.valueOf(mouseX);
  DataOut[1] =String.valueOf(mouseY);
  DataOut[2] =String.valueOf(ID);
}
