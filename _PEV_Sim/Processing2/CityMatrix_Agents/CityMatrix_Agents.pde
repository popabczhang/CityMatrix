// CityMatrix PEV Simulation v0020
// for MIT Media Lab, Changing Place Group

// by "Ryan" Yan Zhang <ryanz@mit.edu>
// April.9th.2016


// resolutions: 
// main canvas: 1920 x 1080
// keystone sruface and pgOffscreen: 800 x 800
// PEV pgRyan: 1920 x 1920
// pgWaleed: 800 x 800 ?


//import deadpixel.keystone.*;


// PEV tab main
PFont myFont;
PImage img_BG;
PGraphics pgRyan;
String roadPtFile;
int totalPEVNum = 10;
int targetPEVNum;
int totalRoadNum;
float scaleMeterPerPixel = 2.15952; //meter per pixel in processing; meter per mm in rhino
float ScrollbarRatioPEVNum = 0.12;
float ScrollbarRatioPEVSpeed = 0.5;
Roads roads;
PEVs PEVs;
boolean drawRoads = false;

// keystone
//Keystone ks;
//CornerPinSurface surface;
//PGraphics pgOffscreen;


void setup() {
  
  // main canvas setup
  size(1920, 1080, P3D); //projection res to be fullscreen
  smooth(8); //2,3,4, or 8
  
//  // keystone setup
//  ks = new Keystone(this);
//  surface = ks.createCornerPinSurface(800, 800, 20);
//  pgOffscreen = createGraphics(800, 800, P3D);
  
  
  // PEV setup
  setupScrollbars();
  //img_BG = loadImage("MAP_BG_ALL.png");
  
  pgRyan = createGraphics(1920, 1920); //the BG Image size
  
  // add roads
  roadPtFile = "RD_151231.txt";
  roads = new Roads();
  roads.addRoadsByRoadPtFile(roadPtFile);

  // add PEVs
  PEVs = new PEVs();
  PEVs.initiate(totalPEVNum);
  
  
  
}

void draw() {
  
  // PEV draw
  pgRyan.beginDraw();
  pgRyan.background(0); 
  pgRyan.smooth(8); //2,3,4, or 8
  
  pgRyan.imageMode(CORNER);
  
  pgRyan.image(img_BG, 0, 0, 1920, 1920);

  // draw roads
  if (drawRoads) {
    roads.drawRoads();
  }

  // run PEVs
  PEVs.run();
  
  pgRyan.endDraw();
  //image(pgRyan, 0, 0, width, height);
  
  // show frameRate
  //println(frameRate);
  textAlign(RIGHT);
  textSize(10*2);
  fill(200);
  text("frameRate: "+str(int(frameRate)), 1620 - 50, 50);

  // draw scollbars
  drawScrollbars();
  targetPEVNum = int(ScrollbarRatioPEVNum*45+5); //5 to 50
  PEVs.changeToTargetNum(targetPEVNum);
  maxSpeedKPH = (ScrollbarRatioPEVSpeed*20+10)*10; //units: kph  10.0 to 50.0 kph
  maxSpeedMPS = maxSpeedKPH * 1000.0 / 60.0 / 60.0; //20.0 KPH = 5.55556 MPS
  maxSpeedPPS = maxSpeedMPS / scaleMeterPerPixel; 
  fill(255);
  noStroke();
  rect(260, 701, 35, 14);
  rect(260, 726, 35, 14);
  textAlign(LEFT);
  textSize(10);
  fill(200);
  text("mouseX: "+mouseX+", mouseY: "+mouseY, 10, 20);
  fill(0);
  text(targetPEVNum, 263, 712);
  text(int(maxSpeedKPH/10), 263, 736);
  
  
//  // keystone draw
////  PVector surfaceMouse = surface.getTransformedMouse();
//  pgOffscreen.beginDraw();
////  pgOffscreen.background(255);
//  pgOffscreen.image(pgRyan, 0, 0, 1024, 1024);
//  pgOffscreen.endDraw();
//  background(0);
//  surface.render(pgOffscreen);
  
}


