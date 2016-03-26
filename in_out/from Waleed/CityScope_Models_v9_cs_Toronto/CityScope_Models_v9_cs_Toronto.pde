////// 3D UI for CityScope///////////////
////// August 2014 - Carson Smuts////////

/* HOW TO USE THIS
 
 The app receieves a codeArray from the camera detection via UDP. This code array tells 
 the app which of the 256 blocks is to represented by which "Structure"
 
 Structures are created by using the StructureClass. In order to prevent Processing from
 freaking out , only 15 Structures are ever created right at the begining of the apps launch.
 This happens in "loadAllModels()".
 
 These are then stored in the "structureArray" and called upon when processing wants to draw the
 individual block ID's stored in the "codeArray".
 
 The codeArray changes frequently and is driven by the data coming from the camera detection app.
 
 
 CANVAS:
 
 There are three canvas PGraphics objects. 
 
 "planImage" : the plan or top view
 "perspectiveImage" : the rotating model view
 "ratioImage" : this is used to draw a 2D key of Types and Densities on top of everything else.
 
 
 KEYBOARD:
 
 z : Activates the single Zoomed view or Overall view (zoom).
 b : Shows only the code tags for each of the buildings. Overrides eveything else.
 c : Activates old TouchDesigner color scheme
 r : Shows realistic textures, Overides white and color models
 n : Shows night-time environment.
 e : Activates the Editor mode for invidual buildings.
 RIGHT and LEFT: Toggles through "structureArray" ,  changing the "currentStructure" and "currentStructureID".
 
 s : Not yet implemented , but this will SAVE settings.
 
 */

import javax.media.opengl.GL2;
import hypermedia.net.*;
UDP udp;  // define the UDP object

//Chess Board Size
int gridU = 16; // Number of grid cells in U direction
int gridV = 16; // Number of grid cells in V direction

boolean baseModelActive = false;

PGraphics perspectiveImage;  //PGraphic canvas that holds the perspective model view
PGraphics planImage;         //PGraphic canvas that holds the top down , plan view
PGraphics ratioImage;        //PGraphic canvas that holds the toggles for editing

ArrayList <String[]> codeArray;         //Holds the values from the scanner application
String lines[];                         //Used to load static codeArray data.
ArrayList <Structure> structureArray;    //Holds the different structure types

boolean editingStructure = false;     //True when editing the typology of a building
int currentStructure = 0;             //The index of the chosen building type from structureArray
int currentStructureID = 0;           //The corresponding building ID - see Structure Class "def" index 1 (second item)
int currentType = 0;                  //The index of the chosen typology within a building to edit ie: Residential -  see "float[] type" in StructureClass

boolean staticOnly=false;             //When active, only the static models imported from CAD are rendered.
boolean closeRender=false;             //Activates individual building perspective, used for editing a building.
boolean baseOnly=false;               //When true , only the codes are shown - overides all other render options.
boolean realistic=false;              //When true , renders textures on building - overides white and color model modes.
boolean night=false;                  //When true , renders night time textures on building - only works when realistic = true.
boolean colorOver=false;              //When true , renders orginal TouchDesigner colors.
boolean leader = false;               //When true , draws the leaders for type when editing a structures typological makeup.

boolean tableToggle = true;

boolean topPerspective=false;             //Activates individual building perspective, used for editing a building.
boolean gradientMap=false;             //Activates individual building perspective, used for editing a building.


float overallDensity = 0.5;
float liveWorkRatio = 0.5;


boolean setStyle=false;

boolean modelsLoaded = false;         //Is true once all models have being loaded.

boolean rendering = false;            //OpenGL sets to true when rendering and false once all buffers have being drawn to - 
//this is to prevent premature alterations of the codeArray which causes a hangup in the program.

PFont font ;

//FIXED Variables
float boxW;
float boxH;
float gridW;
float gridBorderOffSet;


int imageCapture_width = 650;
int imageCapture_height = 700 ;

void setup() {

  size(1300, 700, OPENGL); //Size used for testBoxes()
  frameRate(30);

  //Setup Projection frame/windows
  setup_ImageProj();


  //size(1920, 1080, OPENGL);  //Size used for cityGrid()
  startSlider();

  //create environments
  perspectiveImage = createGraphics(imageCapture_width, imageCapture_height, OPENGL);
  planImage = createGraphics(imageCapture_width, imageCapture_height, OPENGL);
  ratioImage = createGraphics(195, 300, P2D);


  perspectiveImage.smooth(4);
  planImage.smooth(4);
  ratioImage.smooth(4);


  initialize_crudeCam();

  structureArray = new ArrayList<Structure>();
  loadAllModels();

  codeArray = new ArrayList<String[]>();



  font = loadFont("ArialMT-24.vlw");

  // lines = loadStrings("codeArray14.tsv");
  lines = loadStrings("codeArray16.tsv");
  println("Length:" + lines.length);
  if (lines.length== (gridU*gridV +2 )) {
    ImportData(lines);
  }

  getStructureID();


  udp = new UDP( this, 6150 );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );

  //initialize variables from Ira Winder's code
  // Units are centimeters
  boxW = 7.986*4.0/10;   //Derived from known dimentions of 1 "Lego Unit" in millimeters
  boxH = 3.2115/10.0; //Derived from known dimentions of 1 "Lego Unit" in millimeters
  // gridW = 3.41875;     //Measured directly from value used in touch designer which already seems to be working
  gridW = 3.433;     //Accurate to physical model
  gridBorderOffSet = 0.206 ;//+ 0.0315; //The LaserCut width of the grid

  setUpGradientMap();
  updateGradientMap();
  initContours(dstGrad);
  calculateSingleContours();
  calculateContourPShapes();
}


void draw() {

  background(0);
  //println(frameRate);

  clearAll(perspectiveImage, color(0));
  clearAll(planImage, color(40));
  clearAll(ratioImage, color(0, 0, 0, 0));


  leader = false;

  PVector pos = new PVector(0, 0, 0);
  crudeCam(perspectiveImage);

  rendering = true;//Delcare rendering

  updateGradientMap();


  planImage.beginDraw();
  planImage.noLights();
  if (topPerspective) {
    crudeCamTop(planImage);
    planImage.lights();
    if (!gradientMap) {

      drawArray(planImage, true);
    }
    else {
      planImage.image(gradMap, gridW*(float)gridU, gridW*(float)gridU, -gridW*(float)gridU, -gridW*(float)gridU);
      planImage.scale(0.143);
      drawContours(planImage, 0, false);
    }
  }
  else {
    topCam(planImage);
    addLightingToScenePlan(planImage);
    if (!gradientMap) {
      //  planImage.translate( 0, 0, 0);
      // planImage.translate(200,200, 0);
      // planImage.scale(5);
      drawArray(planImage, false);
      // planImage.translate( 0, 0, 0);
    }
    else {
      planImage.image(gradMap, gridW*(float)gridU, gridW*(float)gridU, -gridW*(float)gridU, -gridW*(float)gridU);
      planImage.scale(0.143);
      drawContours(planImage, 0, false);
    }
  }


  planImage.endDraw();


  leader = true;
  if (gradientMap) {
    crudeCamGradient(perspectiveImage);

    perspectiveImage.beginDraw();
    perspectiveImage.translate( ssize/2, ssize/2, 0);
    perspectiveImage.rotateZ(radians(frameCount)/2.5);
    perspectiveImage.translate( -ssize/2, -ssize/2, 0);
    perspectiveImage.fill(0, 0, 255, 4);
    perspectiveImage.stroke(1);
    drawContours(perspectiveImage, 3, true);
    perspectiveImage.endDraw();
  }
  else {
    if (closeRender ) {
      //perspectiveImage.fill(255, 222, 0, 100); //set model color
      //theModel.disableStyle(); //override model color

        //Model 2011
      // drawModel(perspectiveImage, baseOnly, model2010, pos, 1.0f, radians(frameCount));

      perspectiveImage.beginDraw();
      drawModel(perspectiveImage, baseOnly, structureArray.get(currentStructure), pos, 1.0f, frameCount);
      perspectiveImage.endDraw();
    }
    else {

      perspectiveImage.beginDraw();

      if (!realistic) {
        perspectiveImage.lights();
      }
      else {
        addLightingToScene(perspectiveImage);
      }

      drawArray(perspectiveImage, true);
      perspectiveImage.endDraw();
    }
  }

  rendering = false; //release rendering

  imgCapture = planImage.get();

  //Box Test
  //  drawBoxes(perspectiveImage);
  //Model Test
  //drawModelArray(perspectiveImage, model);

  drawRatioImage();


  image(perspectiveImage, width/2, 0);
  image(planImage, 0, 0);

  if (editingStructure && !closeRender) {
    fill(20, 150);
    rect(width/2, 0, 285, 275);
  }

  blendMode(SCREEN);
  image(ratioImage, width/2 + 90, 0);
  blendMode(NORMAL);

  fill(255, 255, 255);
  textFont(font, 18);
  text("Global Density= " + overallDensity, 15, 15);
  text("Live Work Ratio= " + liveWorkRatio, 15, 70);
}


void drawContours() {
}



void drawRatioImage() {
  if (editingStructure ) {

    ratioImage.beginDraw();

    int step = 0;

    for ( int i = structureArray.get(currentStructure).type.length-1 ; i >= 0 ; i--) {

      ratioImage.noStroke();
      ratioImage.fill(structureArray.get(currentStructure).typeColors[i]);
      ratioImage.rect(15, 15+ step, 20, 20);

      if (currentType == i) {
        ratioImage.stroke(255);
        ratioImage.strokeWeight(1.0);
        ratioImage.noFill();
        ratioImage.rect(11, 11+ step, 27, 27);
      }

      ratioImage.fill(255, 255, 255);
      ratioImage.textFont(font, 12);

      String title = "none";
      switch(i) {
      case 0: 
        title = "Open-Ground:";
        break;
      case 1: 
        title = "Recreation:";   
        break;
      case 2: 
        title = "Retail:"; 
        break;
      case 3: 
        title = "Office:";       
        break;
      case 4: 
        title = "Family:";       
        break;
      case 5: 
        title = "Single:";       
        break;
      case 6: 
        title = "Special:";        
        break;
      case 7: 
        title = "Void:";
        break;
      default:             // Default executes if the case labels
        println("None:");   // don't match the switch parameter
        break;
      }

      if (!closeRender) {
        ratioImage.text(title + int(structureArray.get(currentStructure).type[i]*100)  + "%  d=" + int(structureArray.get(currentStructure).typeDensity[i] * 100) + "%", 44, 30 + step);
      }
      step += 30;
    }


    ratioImage.endDraw();
  }
}




void drawArray(PGraphics pg, boolean rotateBool) {



  if (staticOnly) {
    if (baseModelActive) {

      //Draw Base
      pg.pushMatrix();
      pg.translate(-gridBorderOffSet, -gridBorderOffSet, 0); // iterates along x axis
      baseModels.drawStructure(pg, 0.0f);
      pg.translate(0, 0, 0); // iterates along x axis
      pg.popMatrix();
    }
  }
  else {

    if (baseModelActive) {
      //Draw Base
      pg.pushMatrix();
      pg.translate(-gridBorderOffSet, -gridBorderOffSet, 0); // iterates along x axis
      baseModels.drawStructure(pg, 0.0f);
      pg.translate(0, 0, 0); // iterates along x axis
      pg.popMatrix();
    }


   // println("draw called to draw codearray size:" + codeArray.size());
    
    //Draw Pieces
    for (int i=0;i<codeArray.size();i++) {

      String[] tempA = codeArray.get(i);

      int bldID = int(tempA[0]);
      int bldRot = int(tempA[3]);
      int bldX = int(tempA[1]);
      int bldY = int(tempA[2]);
      
      println(tempA[0]);

      for (int j = 0 ; j<  structureArray.size();j++) {

        if ( bldID == structureArray.get(j).def[1]) { //compare to bldg ID

          drawModelArray(pg, baseOnly, structureArray.get(j), rotateBool, float(bldRot)-90, bldX, bldY+1);//bldY +1 to line up with base

          break;
        }
      }
    }
  }
}



void clearAll(PGraphics pg, color greyV) {
  pg.beginDraw();
  pg.background(greyV);
  pg.endDraw();
}

void drawModel(PGraphics pg, boolean base, Structure theModel, PVector pos, float scale, float rotation) {
  pg.pushMatrix();

  //add Lighting
  //pg.lights();e
  addLightingToScene(pg);

  pg.translate(pos.x, pos.y, pos.z);
  pg.scale(scale);
  theModel.drawStructure(pg, base, realistic, rotation);

  pg.popMatrix();
}

void drawModelArray(PGraphics pg, boolean baseOnly, Structure theModel, boolean rotate, float modelRotation, int y, int x) {
  // perspectiveImage.lights();

  pg.pushMatrix();
  if (rotate) {
    pg.translate((-gridW*(float)gridU/2) + (gridW*gridU), gridW*(float)gridU/2, 0);
    pg.rotateZ(radians(frameCount)/2.5);
    pg.translate(gridW*(float)gridU/2  - (gridW*gridU), -gridW*(float)gridU/2, 0);
  }

  pg.translate((-x*gridW) + (gridW*gridU), y*gridW, 0); // iterates along x axis
  theModel.drawStructure(pg, baseOnly, realistic, modelRotation);
  pg.translate((x*gridW) - (gridW*gridU), - y*gridW, 0); // iterates along x axis

  pg.popMatrix();
}

void drawBoxes(PGraphics pg) {
  // Draws Grid of Boxes test
  pg.beginDraw();
  pg.smooth(4);
  int fillstep = 255;
  for (int i = 0; i<gridU; i++) {
    for (int j = 0; j<gridV; j++) {
      fillstep-=1;
      if (fillstep<0) {
        fillstep=0;
      }
      pg.fill(fillstep);
      pg.box(boxW, boxW, boxW);
      pg.translate(gridW, 0, 0); // iterates along j axis
    }
    pg.translate(-gridW*gridU, gridW, 0); // iterates along i axis
  }
  pg.endDraw();
}




void addLightingToScene(PGraphics pg) {

  pg.pointLight(255, 242, 193, -100, 100, 60); // top Sun
  pg.pointLight(20, 20, 20, -100, 100, 80); // top LightWhite
  pg.pointLight(140, 140, 140, 100, 100, 80); // top LightWhite
  pg.pointLight(70, 70, 70, 100, -100, 80); // top LightWhite
  pg.pointLight(193, 239, 255, -5, -100, 60); // side Blue
} // end addLightingToScene


void addLightingToScenePlan(PGraphics pg) {
  pg.pointLight(255, 242, 193, -100, 100, 60); // top Sun
  pg.pointLight(20, 20, 20, -100, 100, 80); // top LightWhite
  pg.pointLight(193, 239, 255, -5, -100, 60); // side Blue
} // end addLightingToScene



void getStructureID() {
  currentStructureID = int(structureArray.get(currentStructure).def[1]);
}

void getStructure() {

  for (int i = 0 ; i<structureArray.size();i++) {

    if (structureArray.get(i).def[1] == currentStructureID) {
      currentStructure = i;
      println("found structure");
    }
  }
}


//Camera Functions
//Camera Mode - modified from Ira Winder's code//

float fov;
float cameraZ;

void initialize_crudeCam() {
  fov = PI/3.0;
  cameraZ = (height/2.0) / tan(fov/2.0);
}

void crudeCam(PGraphics pg) {
  // Sets "Eye" Coordinates, "Scene Center" Coordinates, and X,Y,Z Directions
  if (closeRender ) {
    pg.camera(30, 30, 30, 0, 0, 5, 0, 0, -1);
    // Sets "Field of View" and "Aspect Ratio"
    float fovT = PI/7.0;
    pg.perspective(fovT, -1*(float(pg.width)/float(pg.height)), cameraZ/100.0, cameraZ*1000.0);
  }
  else {
    pg.camera(70, 70, 30, 0, 0, -20, 0, 0, -1);
    // Sets "Field of View" and "Aspect Ratio"
    pg.perspective(fov, -1*(float(pg.width)/float(pg.height)), cameraZ/100.0, cameraZ*1000.0);
  }
}


void crudeCamGradient(PGraphics pg) {
  // Sets "Eye" Coordinates, "Scene Center" Coordinates, and X,Y,Z Directions

  pg.camera(500, 500, 270, 0, 0, -20, 0, 0, -1);
  // Sets "Field of View" and "Aspect Ratio"
  pg.perspective(fov, -1*(float(pg.width)/float(pg.height)), cameraZ/100.0, cameraZ*1000.0);
}

void crudeCamTop(PGraphics pg) {
  // Sets "Eye" Coordinates, "Scene Center" Coordinates, and X,Y,Z Directions

  pg.camera(70, 70, 30, 0, 0, -20, 0, 0, -1);
  // Sets "Field of View" and "Aspect Ratio"
  pg.perspective(fov, -1*(float(pg.width)/float(pg.height)), cameraZ/100.0, cameraZ*1000.0);
}

void topCam(PGraphics pg) {
  pg.camera(  (gridW*((float)gridU/2+1)), gridW*(float)gridU/2, 8000, (gridW*((float)gridU/2)), gridW*((float)gridU/2), 0, 0, 0, 1);
  float fovT = PI/300.0;
  pg.perspective(fovT, 1*(float(pg.width)/float(pg.height)), cameraZ/10.0, cameraZ*1000.0);
  pg.rotateZ(radians(180));
  pg.translate(-55, -55, 0);
  //pg.camera(  (gridW*((float)gridU/2+1)), gridW*(float)gridU/2, 240, 
  //(gridW*((float)gridU/2+1)), gridW*((float)gridU/2-1), 0, 0, 0, 1);
  //pg.ortho(0, pg.width*3, 0, pg.height*3); // same as ortho()
  //pg.ortho(0, width, 0, height); // same as ortho()

  // pg.ortho(0, pg.width , 0, pg.height,-1, 1);

  //   pg.ortho(-250, ((pg.width) - 250), 0, pg.height);
}

