// Hamburg PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015

PFont myFont;
PImage img_BG;
//PGraphics pg;
String roadPtFile;
float screenScale;  //1.0F(for normal res or OS UHD)  2.0F(for WIN UHD)
int totalPEVNum = 10;
int targetPEVNum;
int totalRoadNum;
float scaleMeterPerPixel = 2.15952; //meter per pixel in processing; meter per mm in rhino
float ScrollbarRatioPEVNum = 0.12;
float ScrollbarRatioPEVSpeed = 0.5;
Roads roads;
PEVs PEVs;
boolean drawRoads = false;


void setup() {

  size(1024, 1024); //1920 x 1920: screenScale is about 1.5
  screenScale = width / 1920.0; //fit everything with screen size
  scale(screenScale);
  println("width = "+width);
  println("screenScale = "+screenScale);

  //  pg = createGraphics(1920, 1920);
  //Checking github
  setupScrollbars();

  smooth(8); //2,3,4, or 8

    img_BG = loadImage("BG_ALL_75DPI.png");

  // add roads
  roadPtFile = "RD_CRV_PTS_151231.txt";
  roads = new Roads();
  roads.addRoadsByRoadPtFile(roadPtFile);

  // add PEVs
  PEVs = new PEVs();
  PEVs.initiate(totalPEVNum);
}

void draw() {

  scale(screenScale);
  background(0);

  //  pg.beginDraw();
  //  pg.background(0);
  //  pg.stroke(255);
  //  pg.line(20, 20, mouseX, mouseY);

  imageMode(CORNER);

  image(img_BG, 0, 0, 1920, 1920);

  // draw roads
  if (drawRoads) {
    roads.drawRoads();
  }

  // run PEVs
  PEVs.run();

  //  image(pg, 0, 0);

  // show frameRate
  //println(frameRate);
  textAlign(RIGHT);
  textSize(10*2/screenScale);
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
  text("mouseX: "+mouseX/screenScale+", mouseY: "+mouseY/screenScale, 10, 20);
  fill(0);
  text(targetPEVNum, 263, 712);
  text(int(maxSpeedKPH/10), 263, 736);
}