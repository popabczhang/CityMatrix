// Andorra PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


float maxSpeedKPH = 200.0; //units: kph  20.0 kph
float maxSpeedMPS = maxSpeedKPH * 1000.0 / 60.0 / 60.0; //20.0 KPH = 5.55556 MPS
float maxSpeedPPS = maxSpeedMPS / scaleMeterPerPixel; 
float roadConnectionTolerance = 10.0; //pxl; smaller than 1.0 will cause error
float stateChangeOdd = 0.0075;

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

    //// drawn tangent
    //stroke(255, 255, 255);
    //strokeWeight(0.5F);
    //PVector v1 = locationTangent.setMag(50);
    //PVector v2 = PVector.sub(locationPt,v1);
    //PVector v3 = locationTangent.setMag(100);
    //PVector v4 = PVector.add(locationPt,v3);
    //line(v2.x, v2.y, v4.x, v4.y);

    //println("locationPt: " + locationPt);
    //println("locationNextPt: " + locationNextPt);
    //println("subPVector: " + subPVector);
    //println("rotation: " + rotation);
  }
  
  void changeState(){
    float rnd = random(0.0, 1.0);
    if (rnd <= stateChangeOdd) {
      int n = int(random(0, imgs_PEV.size()-1)+0.5);
      img_PEV = imgs_PEV.get(n);
    }
  }

  void render() {
  
    pushMatrix();
    translate(locationPt.x, locationPt.y);
    rotate(rotation);

    //// draw direction line
    //stroke(0, 255, 0); 
    //strokeWeight(0.5); 
    //line(0.0, 0.0, 25.0, 0.0);

    // draw PEV img
    scale(0.3);
    translate(-img_PEV.width/2, -img_PEV.height/2);
    image(img_PEV, 0, 0);
    popMatrix();
    
  }
}
