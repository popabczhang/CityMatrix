

class StructureBase

{

  ArrayList <PShape> models;

  StructureBase() 
  {
    models = new ArrayList <PShape> ();  // Create an empty ArrayList
  }


  void addModel(String path) {

    PShape tempModel = loadShape(path);
    models.add(tempModel);
  }


  void drawStructure(PGraphics pg, float rotation) {

    //pg.translate((boxW/2), (boxW/2), 0);
    pg.rotateZ(radians(rotation));
  //  pg.translate(-(boxW/2), -(boxW/2), 0);

    for (int i = 0 ; i < models.size(); i++) {
      pg.shape(models.get(i));
    }
  }
}

