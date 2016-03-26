////// 3D Contouring using OpenCV///////////////
////// August 2014 - Carson Smuts////////


ArrayList<Contour> contours;
ArrayList<ArrayList> contourLayers;
ArrayList<ArrayList> contourPShapes;

PGraphics pg ;
OpenCV opencv;


void initContours(PImage imageIn) {

  pg = createGraphics(width, height, OPENGL);
  pg.smooth(4);


  contourLayers =  new ArrayList<ArrayList>();
  contourPShapes =  new ArrayList<ArrayList>();

  opencv = new OpenCV(this, int(ssize), int(ssize));
  opencv.loadImage(imageIn);
}


void drawContours(PGraphics pg, float zHeight, boolean fill) {
  // pg.blendMode(SCREEN);//toon effect
  pg.blendMode(ADD);//glow effect
  for (int i = 0 ; i < contourPShapes.size() ; i ++) {
    pg.translate(0, 0, i * zHeight);
    for (PShape tempShape : (ArrayList<PShape>)contourPShapes.get(i)) {

      pg.hint(DISABLE_DEPTH_TEST);
      tempShape.disableStyle();


      if (!fill) {
        pg.fill(10, 118, 255, 0);
        pg.stroke(10, 118, 255, 200);
      }
      else {
        pg.fill(10, 118, 255, 24);
        pg.stroke(10, 118, 255, 60);
      }
      //pg.noStroke();
      pg.strokeWeight(1);
      pg.shape(tempShape);
      //println(contour.getVertexCount());
      //shape(contour);
      //println(contour.getVertex(0));
    }
    pg.translate(0, 0, -i * zHeight);
  }//end for


  //pg.translate(src.width/2 ,src.height/2);

  /*
  for (int i = 0 ; i < contourLayers.size() ; i ++) {
   pg.translate(0, 0, i/5);
   for (ArrayList contour : (ArrayList<ArrayList>)contourLayers.get(i)) {
   pg.beginShape();
   for (PVector point : (ArrayList<PVector>)contour) {
   //for (PVector point : contour.getPoints()) {
   pg.vertex(point.x, point.y);
   }
   pg.endShape(CLOSE);
   }
   }//end for
   */
}

void calculateContours() {

  contourLayers.clear();

  ArrayList<Contour> tempContours;

  for (int i = 1 ; i < 255 ; i += 5) {
    opencv.gray();
    opencv.threshold(i);
    //dst = opencv.getOutput();
    tempContours = opencv.findContours(false, false);
    //contourLayers.add(contours);

    ArrayList<ArrayList> contourGroups = new ArrayList<ArrayList>();
    for (Contour contour : tempContours) {
      ArrayList<PVector> Points = new ArrayList<PVector>();
      contour.setPolygonApproximationFactor(0.5);
      for (PVector point : contour.getPolygonApproximation().getPoints()) {
        Points.add(point);
      }
      contourGroups.add(Points);
    }
    contourLayers.add(contourGroups);
  }
}


void calculateContourPShapes() {

  contourPShapes.clear();

  ArrayList<Contour> tempContours;

  for (int i = 1 ; i < 300 ; i += 10) {
    opencv.gray();
    opencv.threshold(i);
    //dst = opencv.getOutput();
    tempContours = opencv.findContours(false, false);
    //contourLayers.add(contours);

    ArrayList<PShape> arrayPShapes = new ArrayList<PShape>();
    for (Contour contour : tempContours) {
      PShape tempShape=createShape();
      contour.setPolygonApproximationFactor(0.5);
      tempShape.beginShape();
      tempShape.fill(0, 0, 255, 20);
      //tempShape.noStroke();
      for (PVector point : contour.getPolygonApproximation().getPoints()) {
        tempShape.vertex(point.x, point.y);
      }
      tempShape.endShape(CLOSE);
      arrayPShapes.add(tempShape);
    }
    contourPShapes.add(arrayPShapes);
  }
}



void calculateSingleContours() {
  int tempV = int(cp5.getController("Value").getValue());

  opencv.gray();
  opencv.threshold(tempV);
  contours = opencv.findContours();
}

