/////////////////////////////////////////// tab keys ////////////////////////////////////
void keyPressed() {
  switch(key) {
    
    //PEV
    case 'r': 
      drawRoads = !drawRoads;
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
