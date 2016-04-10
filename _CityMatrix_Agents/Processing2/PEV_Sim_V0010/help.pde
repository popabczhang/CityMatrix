//boolean displayHelp = false;
//
//String help[] = {
// "Legotizer v" + version +" by Ira Winder [jiw@mit.edu]",
// "CityScope Project, Changing Places Group, MIT Media Lab",
// "",
// "This code draws a visualization of a digital, voxelized reconstruction of a physical Lego Model.",
// "Legotized Reconstructions are based upon templates in the 'legotizer_data' folder.",
// "User should have knowledge of 'CityScope' Color Scanning Technology by Changing Places Group in MIT Media Lab",
// "Script uses data recieved via UDP from a Lego color/pattern scanning algorithm such as 'Colortizer' written by Ira Winder [jiw@mit.edu]",
// "",
// "Developer Keycodes specified in 'keyPressed()' (these are for troubleshooting and debugging, not meant to be final UI):",
// "'h' Displays advanced developer functions and help",
// "'S/L' Save/Load Table State",
// "'p' Toggle plexiglas grid gap for static model [On/Off]",
// "';' Toggle plexiglas grid gap for dynamic model [On/Off]",
// "'q' Toggle 1x1 or 4x4 piece type",
// "'SPACEBAR' Change Color Mode (Use-based, Form-based, or Heatmap)",
// "'m' Toggle Camera Mode [Screen or Projector]",
// "'s' Toggle Static Model [On/Off]",
// "'c' Toggle different test piece configurations (does not render if connection to Colortizer is Active)",
// "'d' Toggle Dynamic Model [On/Off]",
// "'r' Rotate Screen Camera 90degrees",
// "'R' Toggle data transfer to Remote via DDP",
// "'v' Change Demo Being Visualized (Kendall, Riyadh, etc)",
// "'a' Toggle Grid Axes [On/Off]",
// "'t' Toggle Statistics (not finished)",
// "'g' Toggle Grid View Mode (turns off everthing else)",
// "'z' Toggle override of Static Buildings [On/Off]",
// "'l' Display Plan in Upper Left Corner",
// "'k' Rotate pieces 90 degrees",
// "'f' flip model upside down",
// "'P' Refresh Projection Mapping Cancas",
// "'`' turn on secondary canvas for projection mapping",
// "   'c' [secondary canvas only] turns on calibration mode",
// "   's' [secondary canvas only] save calibration state",
// "   'l' [secondary canvas only] load calibration state",
// "'e' Toggle satellite image in perspective [On/Off]",
// "'w' change satellite image type",
// "'o'/'O' next basemaps for screen and projection, repectively",
// "'i'/'I' next basemaps for screen and projection, repectively",
// "'[' draw satellite image in plan",
// "']' draw static buildings in plan",
// "'b' Toggle 'Web' for drawing scores",
// "'x' Change colorweb fill type (constant, average, and binary)",
// "'n' Change 3D visualization to use Nodes as input instead of building files",
// "'/' Toggle dynamic pieces to have width of 1 or 4 Lego units",
// "'.' Toggle dynamic pieces to have hieght of 1 or 3 Lego units",
// "'=' Saves a JSON file of nodes to '../legotizer_data/demo_name/' folder",
// "'1' Sends '1' String to colortizer (i.e. 'resimulate' in SDL RhinoScript)",
// "'2' Sends '2' String to colortizer (i.e. 'save' in SDL RhinoScript)",
// "'3' Sends '3' String to colortizer (i.e. 'displaymode energy' in SDL RhinoScript)",
// "'4' Sends '4' String to colortizer (i.e. 'displaymode walkability' in SDL RhinoScript)",
// "'5' Sends '5' String to colortizer (i.e. 'displaymode daylighting' in SDL RhinoScript)",
// "'6' Sends '6' String to colortizer (i.e. (re)initiates SDL RhinoScript server)",
// "'UP', 'DOWN', 'LEFT', 'RIGHT', '-', and '+' adjust the projector's location in 3D space.",
// "'C' Change Canvas for adjusting projector's locationin 3D space",
// "",
// "Press 'h' key to return to Legotizer"
//};
//
//void drawHelp() {
//  textFont(font12);
//  fill(#FFFFFF);
//  textAlign(LEFT);
//  background(0);
//  for (int i=0; i<help.length; i++) {
//    text(help[i], 10, 13*(i+1));
//  }
//}
//
//void toggleHelp() {
//  if (displayHelp == false) {
//    displayHelp = true;
//  } else {
//    displayHelp = false;
//  }
//}
