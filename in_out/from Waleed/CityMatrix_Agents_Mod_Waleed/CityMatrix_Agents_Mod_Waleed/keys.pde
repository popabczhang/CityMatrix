/////////////////////////////////////////// tab keys ////////////////////////////////////
void keyPressed() {
  if (key == 'a'){
    for (int i = 0; i < 30; i++) {
      newAgent(477,55,3);
      newAgent(350,55,2);
      newAgent(590,55,2);
      newAgent(110,220,3);
      newAgent(110,240,3);
      newAgent(110,411,2);
      newAgent(200,260,2);
      newAgent(144,269,2);
      newAgent(355,269,3);
      newAgent(350,559,2);
      newAgent(355,355,3);
      newAgent(590,269,2);
    }
  }    // Remove boid
  if (key == 'd') {
    if (agent.size() > 0) {
      for (int j = 0; j <agent.size(); j++){  
        agent.remove(0);
      }
    }
  }
  if(key == 'm'){
      for (int i = 0; i < 30; i++) {
      newAgent(140,95,1);
      newAgent(110, 150,1);
      newAgent(355,95,1);
      newAgent(555,95,1);
      newAgent(140,298,1);
      newAgent(395,298,1);
      newAgent(355,555,1);
      newAgent(395,555,1);
      newAgent(555,555,1);
      newAgent(355,255,1);
      newAgent(355,298,1);
      newAgent(140,595,1);
      newAgent(595,150,1);
      newAgent(595,555,1);
      newAgent(595,298,1);
      newAgent(555,400,1);
    }
  }
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
