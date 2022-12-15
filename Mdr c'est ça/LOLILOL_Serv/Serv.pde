float [] DataIn = new float [60];
float [] DataOut = new float [60];
String dataIn;
String dataOut;

void Serv() {
  server.write(10);
  Client client = server.available();
  if (client != null) {
    text(client.read(), 50, 50);
  }
}
