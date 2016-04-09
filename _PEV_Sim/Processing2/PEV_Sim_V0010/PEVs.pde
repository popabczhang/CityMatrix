// Andorra PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


PImage img_PEV_EMPTY;
PImage img_PEV_PSG;
PImage img_PEV_PKG;
PImage img_PEV_FULL;
ArrayList<PImage> imgs_PEV;

class PEVs {

  ArrayList<PEV> PEVs;
  //int currentPEVID;

  PEVs() {
    PEVs = new ArrayList<PEV>();
    //currentPEVID = 0;
  }

  void initiate(int _totalPEVNum) {

    img_PEV_EMPTY = loadImage("PEV_EMPTY_300DPI.png");
    img_PEV_PSG = loadImage("PEV_PSG_300DPI.png");
    img_PEV_PKG = loadImage("PEV_PKG_300DPI.png");
    img_PEV_FULL = loadImage("PEV_PSG AND PKG_300DPI.png");
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