import hypermedia.net.*;
int PORT_RX=7001; //port
String HOST_IP="localhost"; //
UDP udp;
String receivedFromUDP = "";
String isPEV = "0";

void initUDP() {
  udp= new UDP(this,PORT_RX,HOST_IP);
  //udp.log(true);
  udp.listen(true);
}

void receive(byte[] data, String HOST_IP, int PORT_RX) {
  receivedFromUDP ="";
  String message = new String( data ); 
  receivedFromUDP = message;
  saveStrings("data.txt", split(message, "\n"));
  String[] split = split(message, "\n");
  String[] fls = split(split[266], "\t");
  isPEV = split[7];
  println(isPEV);
}
