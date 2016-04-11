/////////////////////////////////////////// tab keys ////////////////////////////////////
void keyPressed() {
  switch(key) {
    
    // PEV
    case 'r': 
      drawRoads = !drawRoads;
      break;
    
    // scollbar, BG
    case '1':
      showScollbars = !showScollbars;
      break;
    case '2':
      showBG = !showBG;
      break;
      
    // keystone
    case 'c':
      ks.toggleCalibration();
      break;
    case 'l':
      ks.load();
      break;
    case 's':
      ks.save();
      break;
    
  }
}
