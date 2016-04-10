////
//// This is a script that allows one to open a new canvas for the purpose 
//// of simple 2D projection mapping, such as on a flat table surface
////
//// Right now, only appears to work in windows...
////
//// To use this example in the real world, you need a projector
//// and a surface you want to project your Processing sketch onto.
////
//// Simply press the 'c' key and drag the corners of the 
//// CornerPinSurface so that they
//// match the physical surface's corners. The result will be an
//// undistorted projection, regardless of projector position or 
//// orientation.
////
//// You can also create more than one Surface object, and project
//// onto multiple flat surfaces using a single projector.
////
//// This extra flexbility can comes at the sacrifice of more or 
//// less pixel resolution, depending on your projector and how
//// many surfaces you want to map. 
////
//
//// For any given setup, please update these dimensions, in pixels
////
//// Example TSV Format:
////
////  width   height  offset
////  1920    1080    1280
//
//import javax.swing.JFrame;
//import deadpixel.keystone.*;
//
//// Visualization may show 2D projection visualization, or not
//boolean displayProjection2D = false;
//
//// defines Keystone settings from xml file in parent folder
//Keystone ks;
//
//// defines various drawing surfaces, all pre-calibrated, to project
//CornerPinSurface[] surface;
//PGraphics[] offscreen;
//int numProj;
//int canvasIndex = 0;
//
//// New Application Window Parameters
//PFrame proj2D = null; // f defines window to open new applet in
//projApplet s; // s acts as new set of setup() and draw() functions that operate in parallel
//
//public class PFrame extends JFrame {
//  public PFrame() {
//    setBounds(0, 0, projectorWidth, projectorHeight );
//    setLocation(projectorOffset, 0);
//    s = new projApplet();
//    setResizable(false);
//    setUndecorated(true); 
//    setAlwaysOnTop(true);
//    add(s);
//    s.init();
//    show();
//    setTitle("Projection2D");
//  }
//}
//
//
//String projectorPath = "projector.tsv";
//Table projector;
//int projectorWidth, projectorHeight, projectorOffset; 
//
//void initializeProjection2D() {
//  projector = loadTable(legotizer_data + demoPrefix + demos[vizMode] + projectorPath, "header");
//  projectorWidth  = projector.getInt(0, "width");   // Projector Width in Pixels
//  projectorHeight = projector.getInt(0, "height");  // Projector Height in Pixels
//  projectorOffset = projector.getInt(0, "offset");  // If multiple screens stacked horizontally, 'offset' specifies number of, pixels to the right before projector screen begins
//  numProj = projector.getInt(0, "numProj");
//  
//  plan3DImage = new PImage[numProj];
//  projU = new float[numProj];
//  projV = new float[numProj];
//  projH = new float[numProj];
//  offscreen = new PGraphics[numProj];
//  
//  loadProjectorLocation();
//  
//  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
//}
//
//void loadProjectorLocation(){
//  
//  for (int i=0; i<numProj; i++) {
//    //Projector location (relative to table grid origin)
//    projU[i]  = projector.getInt(0, "U" + (i+1)); // Projector U Location (4LU units)
//    projV[i] = projector.getInt(0, "V" + (i+1));  // Projector V Location (4LU units)
//    projH[i] = projector.getInt(0, "H" + (i+1));  // Projector Height (4LU units)
//  }
//}
//
//void saveProjectorLocation(){
//  for (int i=0; i<numProj; i++) {
//    projector.setInt(0, "U" + (i+1), (int)projU[i]);  // Projector U Location (4LU units)
//    projector.setInt(0, "V" + (i+1), (int)projV[i]);  // Projector V Location (4LU units)
//    projector.setInt(0, "H" + (i+1), (int)projH[i]);  // Projector Height (4LU units)
//  }
//  
//  saveTable(projector, legotizer_data + demoPrefix + demos[vizMode] + "projector.tsv");
//}
//
//public void showProjection2D() {
//  if (proj2D == null) {
//    proj2D = new PFrame();
//  }
//  proj2D.setVisible(true);
//}
//
//public void closeProjection2D() {
//  proj2D.setVisible(false);
//}
//
//public void resetProjection2D() {
//  initializeProjection2D();
//  if (proj2D != null) {
//    proj2D.dispose();
//    proj2D = new PFrame();
//    if (displayProjection2D) {
//      showProjection2D();
//    } else {
//      closeProjection2D();
//    }
//  }
//}
//
//public class projApplet extends PApplet {
//  public void setup() {
//    // Keystone will only work with P3D or OPENGL renderers, 
//    // since it relies on texture mapping to deform
//    size(projectorWidth, projectorHeight, P2D);
//    
//    ks = new Keystone(this);
//    surface = new CornerPinSurface[numProj];
//    
//    // If 1 projector
//    if (numProj == 1) {
//      surface[0] = ks.createCornerPinSurface(plan.width, plan.height, 20);
//      offscreen[0] = createGraphics(plan.width, plan.height);
//    } 
//    
//    // If 2 projectors
//    else if (numProj == 2) {
//      for (int i=0; i<numProj; i++) {
//        surface[i] = ks.createCornerPinSurface(plan.width/2, plan.height, 20);
//        offscreen[i] = createGraphics(plan.width/2, plan.height);
//      }
//    } 
//    
//    // If more than 2 projectors (will probably need to create a custom array)
//    else {
//      for (int i=0; i<numProj; i++) {
//        surface[i] = ks.createCornerPinSurface(plan.width, plan.height, 20);
//        offscreen[i] = createGraphics(plan.width, plan.height);
//      }
//      
//    }
//    
//    try{
//      ks.load();
//    } catch(RuntimeException e){
//      println("No Keystone.xml.  Save one first if you want to load one.");
//    }
//    
//    println("numProj = " + numProj);
//  }
//  
//  public void draw() {
//    
//    // Convert the mouse coordinate into surface coordinates
//    // this will allow you to use mouse events inside the 
//    // surface from your screen. 
//    PVector surfaceMouse = surface[0].getTransformedMouse();
//    
//    // most likely, you'll want a black background to minimize
//    // bleeding around your projection area
//    background(0);
//      
//    // If 1 projector
//    if (numProj == 1) {
//      // Draw the scene, offscreen
//      renderCrop(offscreen[0], 0, 0);
//      surface[0].render(offscreen[0]);
//    }
//    
//    // If 2 projectors
//    else if (numProj == 2) {
//      // render the scene, transformed using the corner pin surface
//        
//      // Draw the scene, offscreen
//      renderCrop(offscreen[0], 0, 0);
//      surface[0].render(offscreen[0]);
//      
//      // Draw the scene, offscreen
//      renderCrop(offscreen[1], -plan.width/2, 1);
//      surface[1].render(offscreen[1]);
//    } 
//  
//  }
//  
//  void renderCrop(PGraphics p, int x_offset, int _canvasIndex) {
//    // Draw the scene, offscreen
//    p.beginDraw();
//    p.background(#0000FF);
//    //p.blendMode(MULTIPLY);
//    p.fill(0, 255, 0);
//    p.translate(x_offset, 0);
//    p.image(plan3DImage[_canvasIndex], 0, 0);
//    p.endDraw();
//  }
//  
//  void keyPressed() {
//    switch(key) {
//    case 'c':
//      // enter/leave calibration mode, where surfaces can be warped 
//      // and moved
//      ks.toggleCalibration();
//      break;
//
//    case 'l':
//      // loads the saved layout
//      ks.load();
//      break;
//
//    case 's':
//      // saves the layout
//      ks.save();
//      break;
//    
//    case '`': 
//      if (displayProjection2D) {
//        displayProjection2D = false;
//        closeProjection2D();
//      } else {
//        displayProjection2D = true;
//        showProjection2D();
//      }
//      break;
//      
//    }
//  }
//}
//
//void toggle2DProjection() {
//  if (System.getProperty("os.name").substring(0,3).equals("Mac")) {
//    println("Projection Mapping Currently not Supported for MacOS");
//  } else {
//    if (displayProjection2D) {
//      displayProjection2D = false;
//      closeProjection2D();
//    } else {
//      displayProjection2D = true;
//      showProjection2D();
//    }
//  }
//}
//

