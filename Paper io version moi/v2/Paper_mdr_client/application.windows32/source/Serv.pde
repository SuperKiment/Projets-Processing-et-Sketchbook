/*import processing.net.*;
 Server server;
 String []DataIn = new String[2];
 String dataIn;
 float ID1;
 float ID2;
 
 String dataOut = "test no 15641";
 
 String dataIn1;
 String dataIn2;
 
 void Serv() {
 
 server.write(dataOut);
 
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
 
 
 
 //text(ID1, 100, 20);
 //text(ID2, 100, 40);
 }*/
