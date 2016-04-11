// CityMatrix Agents
// for MIT Media Lab, Changing Place Group

// by "Ryan" Yan Zhang <ryanz@mit.edu>, Waleed
// April.9th.2016


import deadpixel.keystone.*;


// PEV tab main
PFont myFont;
PImage img_BG;
PGraphics pgRyan;
String roadPtFile;
int totalPEVNum = 10;
int targetPEVNum;
int totalRoadNum;
float scaleMeterPerPixel = 2.15952; //meter per pixel in processing; meter per mm in rhino
float ScrollbarRatioPEVNum = 0.5;  //0.12
float ScrollbarRatioPEVSpeed = 0.0; //0.5
Roads roads;
PEVs PEVs;
boolean drawRoads = false;

// keystone
Keystone ks;
CornerPinSurface surface;
PGraphics pgOffscreen;
// resolutions: 
// main canvas: 1920 x 1080
// keystone surface and pgOffscreen:
int resPgOffscreen = 1600;
// PEV pgRyan: 1920 x 1920
// pgWaleed: 800 x 800

// tab PEV
float maxSpeedKPH = 200.0; //units: kph  20.0 kph
float maxSpeedMPS = maxSpeedKPH * 1000.0 / 60.0 / 60.0; //20.0 KPH = 5.55556 MPS
float maxSpeedPPS = maxSpeedMPS / scaleMeterPerPixel; 
float roadConnectionTolerance = 10.0; //pxl; smaller than 1.0 will cause error
float stateChangeOdd = 0.0075;

// tab PEVs
PImage img_PEV_EMPTY;
PImage img_PEV_PSG;
PImage img_PEV_PKG;
PImage img_PEV_FULL;
ArrayList<PImage> imgs_PEV;

// tab Road
//1 mm(pxl)
//= 2.15952 meter
//currently, 
//road step length
//= 0.50 mm(pxl)/pt
//>>
//road length (meter)
//= road pt number * 0.5 * 2.15952
//= road pt number * 1.07976
float stepLengthPixel = 0.5; //for the road pts generated in rhino/gh; units: mm(pxl)/pt
float stepLengthMeter = stepLengthPixel * scaleMeterPerPixel; //units: meter/pt

// tab Roads
// NA

// tab scrollbar
// Code based on "Scrollbar" by Casey Reas
// Editted by Yan Zhang (Ryan) <ryanz@mit.edu>
// Log:
// 160118 - add screenScale factor
HScrollbar[] hs = new HScrollbar[2];//
String[] labels =  {"SCORE_1", "SCORE_2"};
int x = 10;
int y = 30;
int w = 102;
int h = 14;
int l = 2;
int spacing = 4;
boolean showScollbars = true;
boolean showBG = true;

// human interation
color[] pix;
ArrayList<Agent> agent;
PGraphics pgWaleed;


void setup() {
  
  // main canvas setup
  size(1920, 1080, P3D); //projection res to be fullscreen
  smooth(8); //2,3,4, or 8
  background(0);
  
  // keystone setup
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(resPgOffscreen, resPgOffscreen, 20);
  pgOffscreen = createGraphics(resPgOffscreen, resPgOffscreen, P3D);
  ks.load(); //load the saved corner positions
  
  // PEV setup
  setupScrollbars();
  img_BG = loadImage("MAP_BG_CityMatrix_1920.png");
  
  pgRyan = createGraphics(1920, 1920); //the BG Image size
  
  // add roads
  roadPtFile = "RD_160411.txt";
  roads = new Roads();
  roads.addRoadsByRoadPtFile(roadPtFile);

  // add PEVs
  PEVs = new PEVs();
  PEVs.initiate(totalPEVNum);
  
  // Human Interation setup
  pgWaleed = createGraphics(800, 800);
  PImage img = loadImage("MAP_sidewalk_buffer_800pxl.png");
  img.loadPixels();
  pix = img.pixels;
  agent = new ArrayList<Agent>();
  for (int i = 0; i < 300; i++) {
    newAgent(559,643,1);
    //newAgent(351,452,1);
    newAgent(358,542,1);
    //newAgent(107,95,1);
  }
//    for (int i = 0; i < 1; i++) {
//    newAgent(557,642,2);
//    //newAgent(352,450,2);
//    newAgent(358,540,2);
//    //newAgent(105,93,2);
//  }
  
  
}

void draw() {
  
  // background draw
  background(0);
  
  
  // PEV draw
  pgRyan.beginDraw();
  //pgRyan.background(0); 
  pgRyan.clear();
  pgRyan.smooth(8); //2,3,4, or 8
  
  pgRyan.imageMode(CORNER);
  
  if (showBG) {
    pgRyan.image(img_BG, 0, 0, 1920, 1920);
  }
  
  // draw roads
  if (drawRoads) {
    roads.drawRoads();
  }

  // run PEVs
  PEVs.run();
  
  pgRyan.endDraw();
  //image(pgRyan, 0, 0, 1080, 1080);
  
  
  // Human Interation draw
  pgWaleed.beginDraw();
  //pgWaleed.background(0);
  pgWaleed.clear();
  for (Agent a : agent) {
    a.applyBehaviors(agent);
    a.run();
  }
  pgWaleed.endDraw();
  
  
  // keystone draw
  pgOffscreen.beginDraw();
  //pgOffscreen.background(0);
  pgOffscreen.clear();
  pgOffscreen.image(pgRyan, 0, 0, resPgOffscreen, resPgOffscreen);
  pgOffscreen.image(pgWaleed, 0, 0, resPgOffscreen, resPgOffscreen); 
  pgOffscreen.endDraw();
  surface.render(pgOffscreen);
  
  
  // main canvas UI draw
  if (showScollbars) {
    // show frameRate
    //println(frameRate);
    textAlign(RIGHT);
    textSize(10*2);
    fill(200);
    text("frameRate: "+str(int(frameRate)), 1620 - 50, 50);
  
    // draw scrollbars
    drawScrollbars();
    targetPEVNum = int(ScrollbarRatioPEVNum*45+5); //5 to 50
    PEVs.changeToTargetNum(targetPEVNum);
    maxSpeedKPH = (ScrollbarRatioPEVSpeed*20+10)*10; //units: kph  10.0 to 50.0 kph
    maxSpeedMPS = maxSpeedKPH * 1000.0 / 60.0 / 60.0; //20.0 KPH = 5.55556 MPS
    maxSpeedPPS = maxSpeedMPS / scaleMeterPerPixel; 
    fill(255);
    noStroke();
    rect(260+400, 701, 35, 14);
    rect(260+400, 726, 35, 14);
    textAlign(LEFT);
    textSize(10);
    fill(200);
    text("mouseX: "+mouseX+", mouseY: "+mouseY, 10, 20);
    fill(0);
    text(targetPEVNum, 263+400, 712);
    text(int(maxSpeedKPH/10), 263+400, 736);
  }
  
}

void mousePressed(){
//  PVector surfaceMouse = surface.getTransformedMouse();
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 2);
//  newAgent(surfaceMouse.x/2, surfaceMouse.y/2, 1);
}
