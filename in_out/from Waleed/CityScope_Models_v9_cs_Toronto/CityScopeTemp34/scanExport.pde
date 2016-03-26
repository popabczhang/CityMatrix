//
// REPORT ALL CHANGES WITH DATE AND USER IN THIS AREA:
// - Updated to include location array "locArray" that passes x, y, width, and height values for scanGrids
// -
// -
// -

boolean viaUDP = true;

// import UDP library
import hypermedia.net.*;
UDP udp;  // define the UDP object

void startUDP() {

  println("StartUp UDP");

  if (decode == false) {
    viaUDP = false;
  }

  if (viaUDP) {
    udp = new UDP( this, 6669 );
    //udp.log( true );     // <-- printout the connection activity
    udp.listen( false );
  }
}

void sendData() {

  if (viaUDP) {


    String dataToSend = "";

    for (int u=0; u<tagDecoder[0].U; u++) {
      for (int v=0; v<tagDecoder[0].V; v++) {
        dataToSend += tagDecoder[0].id[u][v] ;
        dataToSend += "\t" ;
        dataToSend += tagDecoder[0].U-u-1 ;
        dataToSend += "\t" ;
        dataToSend += v ;
        dataToSend += "\t" ;
        dataToSend += tagDecoder[0].rotation[u][v] ;
        dataToSend += "\t" ;
        dataToSend += tagDecoder[0].quadcode[u][v] ;
        if (u != tagDecoder[0].U-1 || v != tagDecoder[0].V-1) {
          dataToSend += "\n" ;
        }
      }
    }

    /*
    // Slider and Toggle Values
     for (int i=0; i<sliderDecoder.length; i++) {
     dataToSend += sliderDecoder[i].code;
     if (i != sliderDecoder.length-1) {
     dataToSend += "\t";
     } else {
     dataToSend += "\n";
     }
     }
     
     
     // Slider and Toggle Locations
     for (int i=0; i<numGridAreas[0]; i++) {
     dataToSend += gridLocations.getInt(0, 0 + i*4); 
     dataToSend += "\t" ;
     dataToSend += gridLocations.getInt(0, 1 + i*4);
     dataToSend += "\t" ;
     dataToSend += gridLocations.getInt(0, 2 + i*4); 
     dataToSend += "\t" ;
     dataToSend += gridLocations.getInt(0, 3 + i*4);
     dataToSend += "\n";
     }
     
     
     // Slider and Toggle Canvas Dimensions
     dataToSend += vizRatio; 
     dataToSend += "\t" ;
     dataToSend += vizWidth;
     dataToSend += "\n" ;
     */

    saveStrings("data.txt", split(dataToSend, "\n"));
    //udp.send( dataToSend, "18.85.55.241", 6152 );
    udp.send( dataToSend, "localhost", 6150 );
    //println("Sending UDP data.....");
  }
}

