// Andorra PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


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
    println(startLineID);
    println(endLineID);
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