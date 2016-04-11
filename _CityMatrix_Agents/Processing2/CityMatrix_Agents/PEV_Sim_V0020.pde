// CityMatrix PEV Simulation v0020
// for MIT Media Lab, Changing Place Group

// by "Ryan" Yan Zhang <ryanz@mit.edu>
// April.9th.2016




/////////////////////////////////////// tab main ////////////////////////////////////////////////


///////////////////////////////////////////// tab PEV ////////////////////////////////////////
class PEV {

  //int id; //PEV agent id
  int status; //0 - empty; 1 - psg; 2 - pkg; 3 - psg & pkg
  //int roadID; //the road the PEV is currently on
  Road road; //current road object
  float t; //t location of the current road;
  PVector locationPt; //location coordination on the canvas
  PVector locationTangent;
  float rotation; //rotation in radius on the canvas
  float speedT; //current speed; units: t per frame
  PImage img_PEV;

  PEV(Road _road, float _t) {
    //id = _id;
    //roadID = _roadID;
    //road = roads.roads.get(roadID);
    road = _road;
    t = _t;
    status = 0;
    locationPt = road.getPt(t);
    speedT = maxSpeedMPS / road.roadLengthMeter / frameRate; //speedT unit: t per frame
    img_PEV = imgs_PEV.get(int(random(0, imgs_PEV.size()-1)+0.5));
  }

  void run() {

    move();

    getDirection();
    
    changeState();

    render();
  }

  void move() {
    // update the speed according to frameRate
    speedT = maxSpeedMPS / road.roadLengthMeter / frameRate; //speedT unit: t per frame
    
    // calc the next step
    t = t + speedT;
    
    // if at end of road
    if (t + speedT > 1.0) {
      // simple test on one road
      //speedT = -speedT;

      // looking for all next road connected
      ArrayList<Road> nextRoads = new ArrayList<Road>();
      PVector roadEndPt = road.roadPts[road.ptNum-1];
      PVector roadStartPt = road.roadPts[0];
      //int i = 0;
      for (Road tmpRoad : roads.roads) {
        PVector tmpRoadStartPt = tmpRoad.roadPts[0];
        PVector tmpRoadEndPt = tmpRoad.roadPts[tmpRoad.ptNum-1];
        //println("tmpRoad ["+i+"]: ");
        //println("PVector.dist(roadEndPt, tmpRoadStartPt) = "+PVector.dist(roadEndPt, tmpRoadStartPt));
        //println("PVector.dist(roadStartPt, tmpRoadEndPt) = "+PVector.dist(roadStartPt, tmpRoadEndPt));
        if (PVector.dist(roadEndPt, tmpRoadStartPt) <= roadConnectionTolerance) {
          //println("pass if 01");
          if (PVector.dist(roadStartPt, tmpRoadEndPt) > roadConnectionTolerance) {
            //println("pass if 02");
            nextRoads.add(tmpRoad);
          }
        }
        //i ++;
      }
      //println("find: "+nextRoads.size());

      // pick one next road
      if (nextRoads.size() <= 0) {
        println("ERROR: CAN NOT FIND NEXT ROAD!" + 
          "THERE MUST BE DEADEND ROAD! CHECK ROAD RHINO FILE OR ROAD PT DATA TXT");
      }
      int n = int(random(0, nextRoads.size()-1)+0.5); //int(0.7) = 0, so need +0.5
      //println("n = "+n+"; nextRoads.size()-1 = "+str(nextRoads.size()-1)
      //  +"; random(0, nextRoads.size()-1) = "+str(random(0, nextRoads.size()-1)));
      //println("t = "+t);
      Road nextRoad = nextRoads.get(n);

      // switch current road to next road
      road = nextRoad; 
      t = 0.0;
    }
  }

  void getDirection() {
    // get rotation
    locationPt = road.getPt(t);
    locationTangent = road.getTangentVector(t);
    rotation = PVector.angleBetween(new PVector(1.0, 0.0, 0.0), locationTangent);
    if (locationTangent.y < 0) {
      rotation = -rotation;
    }
  }
  
  void changeState(){
    float rnd = random(0.0, 1.0);
    if (rnd <= stateChangeOdd) {
      int n = int(random(0, imgs_PEV.size()-1)+0.5);
      img_PEV = imgs_PEV.get(n);
    }
  }

  void render() {
  
    pgRyan.pushMatrix();
    pgRyan.translate(locationPt.x, locationPt.y);
    pgRyan.rotate(rotation);

    // draw PEV img
    pgRyan.scale(0.3);
    pgRyan.translate(-img_PEV.width/2, -img_PEV.height/2);
    pgRyan.image(img_PEV, 0, 0);
    pgRyan.popMatrix();
    
  }
}

//////////////////////////////////////// tab PEVs //////////////////////////////////////////
class PEVs {

  ArrayList<PEV> PEVs;
  //int currentPEVID;

  PEVs() {
    PEVs = new ArrayList<PEV>();
    //currentPEVID = 0;
  }

  void initiate(int _totalPEVNum) {

    img_PEV_EMPTY = loadImage("MAP_PEV_EMPTY.png");
    img_PEV_PSG = loadImage("MAP_PEV_PSG.png");
    img_PEV_PKG = loadImage("MAP_PEV_PKG.png");
    img_PEV_FULL = loadImage("MAP_PEV_PSG AND PKG.png");
    imgs_PEV = new ArrayList<PImage>();
    imgs_PEV.add(img_PEV_EMPTY);
    imgs_PEV.add(img_PEV_PSG);
    imgs_PEV.add(img_PEV_PKG);
    imgs_PEV.add(img_PEV_FULL);

    int totalPEVNum = _totalPEVNum;
    for (int i = 0; i < totalPEVNum; i ++) {
      int tmpRoadID = int(random(0.0, totalRoadNum-1)+0.5);
      Road tmpRoad = roads.roads.get(tmpRoadID);
      float t = random(0.0, 0.75);
      //PEV tmpPEV = new PEV(currentPEVID, tmpRoadID, t);
      PEV tmpPEV = new PEV(tmpRoad, t);
      PEVs.add(tmpPEV);

    }

  }

  void run() {
    for (PEV PEV : PEVs) {
      PEV.run();
    }
  }

  void addPEV(PEV _PEV) {
    PEVs.add(_PEV);
  }

  void addRandomly() {
    int tmpRoadID = int(random(0.0, totalRoadNum-1)+0.5);
    Road tmpRoad = roads.roads.get(tmpRoadID);
    float t = random(0.0, 0.75);
    PEV tmpPEV = new PEV(tmpRoad, t);
    PEVs.add(tmpPEV);
  }

  void removeRandomly() {
    int n = int(random(0, PEVs.size()-1));
    PEVs.remove(n);
  }

  void changeToTargetNum(int _targetNum) {
    int tn = _targetNum;
    int cn = PEVs.size();
    if (cn>tn) {
      removeRandomly();
    } else if (cn<tn) {
      addRandomly();
    }
  }
}


//////////////////////////////////////// tab Road ///////////////////////////////////////
class Road {

  PVector[] roadPts;
  int ptNum;
  String roadPtFilePath;
  float roadLengthMeter;
  //int directionType; // 0 = one way(start pt to end pt); 1 = two way 

  Road() {
  }

  // class functions
  void getData(String[] _roadLines) {
    //directionType = _directionType;
    String[] lines = _roadLines;
    //println("there are " + lines.length + " lines");
    ptNum = lines.length;
    roadLengthMeter = ptNum * stepLengthMeter;
    roadPts = new PVector[ptNum];
    for (int i = 0; i < ptNum; i++) {
      //println(lines[i]);
      String[] pieces = split(lines[i], ",");
      float x = float(pieces[0]);
      float y = float(pieces[1]);
      float z = float(pieces[2]);
      roadPts[i] = new PVector(x, y, z);
    }
  }

  PVector getPt(float _t) {
    float t = _t;
    int l = roadPts.length;
    if ( t < 0.0 || t > 1.0 ) {
      println("\"t\" out of range! \"t\" must be between 0.0 and 1.0. Now t = " + t);
      return null;
    } else {
      int n = int((l-1)*t);
      return roadPts[n];
    }
  }
  
  PVector getTangentVector(float _t) {
    float t = _t;
    int l = roadPts.length;
    if ( t < 0.0 || t > 1.0 ) {
      println("\"t\" out of range! \"t\" must be between 0.0 and 1.0. Now t = " + t);
      return null;
    } else if (t == 1.0) {
      int n = int((l-1)*t);
      PVector v1 = roadPts[n-1];
      PVector v2 = roadPts[n];
      PVector v3 = PVector.sub(v2, v1);
      v3.normalize();
      return  v3;
    } else {
      int n = int((l-1)*t);
      PVector v1 = roadPts[n];
      PVector v2 = roadPts[n+1];
      PVector v3 = PVector.sub(v2, v1);
      v3.normalize();
      return  v3;
    }
  }


  void drawRoad() {
    for (int i = 0; i < ptNum - 1; i ++) {
      pgRyan.stroke(0, 255, 255); //cyan
      pgRyan.strokeWeight(1.0); 
      pgRyan.line(roadPts[i].x, roadPts[i].y, roadPts[i+1].x, roadPts[i+1].y);
    }
  }
}//class Road


///////////////////////////////////////////// tab Roads //////////////////////////////////////////
class Roads {

  ArrayList<Road> roads;
  String roadPtFile;

  Roads() {
    roads = new ArrayList<Road>();
  }

  void addRoadsByRoadPtFile(String _roadPtFile) {
    roadPtFile = _roadPtFile;
    String[] allLines = loadStrings(roadPtFile);
    //println("there are " + lines.length + " lines");
    int totalLines = allLines.length;
    int roadCount = 0;
    IntList startLineID = new IntList();
    IntList endLineID = new IntList();
    for (int i = 0; i < totalLines; i ++) {
      String line = allLines[i];
      if (line.indexOf("start") != -1) {
        roadCount ++;
        startLineID.append(i);
      }
      if (line.indexOf("end") != -1) {
        endLineID.append(i);
      }
    }
    //println(startLineID);
    //println(endLineID);
    int roadCountOneWay = 0;
    for (int i = 0; i < roadCount; i ++) {
      int ptNum = endLineID.get(i) - startLineID.get(i) - 2;
      String[] roadLines = subset(allLines, startLineID.get(i) + 2, ptNum);
      if (allLines[startLineID.get(i)+1].indexOf("one way") != -1) {
        // one way

        // add a road object
        Road road = new Road();
        road.getData(roadLines);
        roads.add(road);
        roadCountOneWay ++;
      } else {
        // two way, duplicate and reverse

        // add a road object
        Road road1 = new Road();
        road1.getData(roadLines);
        roads.add(road1);
        roadCountOneWay ++;

        // add another rivised road object
        roadLines = reverse(roadLines);
        Road road2 = new Road();
        road2.getData(roadLines);
        roads.add(road2);
        roadCountOneWay ++;
      }
    }
    totalRoadNum = roadCountOneWay;
    println("total road number (oneway) = " + totalRoadNum);
  }

  void addRoad(Road road) {
    roads.add(road);
  }

  void drawRoads() {
    for (Road road : roads) {
      road.drawRoad();
    }
  }
}


//////////////////////////////////////// tab scrollbar //////////////////////////////////////////////
void setupScrollbars() {
  //for (int i = 0; i < hs.length; i++) {
  //  hs[i] = new HScrollbar(x, y + i*(h+spacing), w, h, l);
  //}
//  hs[0] = new HScrollbar(156, 708, w, h, l);
//  hs[1] = new HScrollbar(156, 732, w, h, l);
  hs[0] = new HScrollbar(156+400, 708, w, h, l);
  hs[1] = new HScrollbar(156+400, 732, w, h, l);

  hs[0].setPos(ScrollbarRatioPEVNum);
  hs[1].setPos(ScrollbarRatioPEVSpeed);

}

void drawScrollbars() {
  
  textSize(10);
  
  ScrollbarRatioPEVNum = hs[0].getPos()*1.0;
  ScrollbarRatioPEVSpeed = hs[1].getPos()*1.0;


  for (int i = 0; i < hs.length; i++) {
    hs[i].update();
    hs[i].draw();
    fill(200);
    textAlign(LEFT);
    //text(labels[i],x+w+spacing,y+i*(h+spacing)+spacing);
    //text(labels[i]+": "+hs[i].getPos(),x+w+spacing,y+i*(h+spacing)+spacing);
    text(hs[i].getPos(),34,713+i*22);
  }
}


class HScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (int xp, int yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if(over()) {
      over = true;
    } 
    else {
      over = false;
    }
    if(mousePressed && over) {
      //scrollbar = true;
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
      //scrollbar = false;
    }
    if(locked) {
      newspos = constrain(int(mouseX)-sheight/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 0) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } 
    else {
      return false;
    }
  }

  void draw() {
    fill(255);
    stroke(0); 
    strokeWeight(0.75);
    rectMode(CORNER);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      fill(153, 102, 0);
    } 
    else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  void setPos(float s) {
    spos = xpos + s*(sposMax-sposMin);
    newspos = spos;
  }

  float getPos() {
    // convert spos to be values between
    // 0 and the total width of the scrollbar
    return ((spos-xpos))/(sposMax-sposMin);// * ratio;
  }
}



