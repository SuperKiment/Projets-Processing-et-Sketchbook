import processing.net.*;

Client client;
String dataIn;
String dataOut;
String[] DataIn = new String[40];
String[] DataOut = new String[40];


void setup() {
  size(500, 500);
  
  client = new Client(this, "localhost", 5050);
}

void draw() {
  RecupData();



  background(0);
  for (int i = 0; i<DataIn.length; i++) {
    if (DataIn[i] != null) text(DataIn[i], 20, i*20 + 20);
  }
  text(ID, 50, 20);
  println(dataIn);

  EnvoiDataClear();
}
