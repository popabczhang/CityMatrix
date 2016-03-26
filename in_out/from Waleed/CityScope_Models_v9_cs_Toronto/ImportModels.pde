StructureBase baseModels;

void loadAllModels() {
  println("in loadAllPShapes");
  println("loading model files");


  println("trying to load file" );
  
  //Load Model File
  baseModels = new StructureBase();
  baseModels.addModel("Models/LegoBaseModels/basecuts.obj");
  baseModels.addModel("Models/LegoBaseModels/basemodel.obj");
  

  //2111 - Ground Tile Purple - ID: 13
  Structure model2111 = new Structure();
  //Asphalt
  model2111.addModel("Models/LegoBlockModels/2111base.obj");
  model2111.addModel("Models/LegoBlockModels/2111.obj");
  model2111.addModel("Models/LegoBlockModels/2111real.obj");
  model2111.addModel("Models/LegoBlockModels/Night/2111real.obj");

  model2111.mColor = color(255, 0, 243);
  model2111.def = new float [] { 
    2111, 13, 0, 3
  };

  structureArray.add(model2111);

  //2011 - Ground Tile Green - Grass - ID: 12
  Structure model2011 = new Structure();
  //Grass
  model2011.addModel("Models/LegoBlockModels/2011base.obj");
  model2011.addModel("Models/LegoBlockModels/2011.obj");
  model2011.addModel("Models/LegoBlockModels/2011real.obj");
  model2011.addModel("Models/LegoBlockModels/Night/2011real.obj");

  model2011.mColor = color( 100, 255, 0);
  model2011.def = new float [] {  
    2011, 12, 0, 4
  };
  structureArray.add(model2011);


  //3111 - Single Story Red - ID: 15
  Structure model3111 = new Structure();
  //Double Story commercial
  model3111.addModel("Models/LegoBlockModels/3111base.obj");
  model3111.addModel("Models/LegoBlockModels/3111.obj");
  model3111.addModel("Models/LegoBlockModels/3111Real.obj");
  model3111.addModel("Models/LegoBlockModels/Night/3111Real.obj");

  model3111.mColor = color( 255, 0, 0);
  model3111.def = new float [] { 
    3111, 15, 2, 0
  };
  structureArray.add(model3111);


  //3000 - Single Story Green - ID: 0
  Structure model3000 = new Structure();
  //Double Story residential
  model3000.addModel("Models/LegoBlockModels/3000base.obj");
  model3000.addModel("Models/LegoBlockModels/3000.obj");
  model3000.addModel("Models/LegoBlockModels/3000Real.obj");
  model3000.addModel("Models/LegoBlockModels/Night/3000Real.obj");

  model3000.mColor = color( 0, 255, 0);
  model3000.def = new float [] { 
    3000, 0, 2, 1
  };
  structureArray.add(model3000);

  //3010 - Single story special - ID: 4
  Structure model3010 = new Structure();
  //7 Story Commercial Glass
  model3010.addModel("Models/LegoBlockModels/3010base.obj");
  model3010.addModel("Models/LegoBlockModels/3010.obj");
  model3010.addModel("Models/LegoBlockModels/3010Real.obj");
  model3010.addModel("Models/LegoBlockModels/Night/3010Real.obj");

  model3010.mColor = color( 255, 234, 0);
  model3010.def = new float [] { 
    3010, 4, 7, 0
  };
  structureArray.add(model3010);
  
   //3010 - Single story special - ID: 4
  Structure model3011 = new Structure();
  //7 Story Commercial Glass
  model3011.addModel("Models/LegoBlockModels/3010base.obj");
  model3011.addModel("Models/LegoBlockModels/3010.obj");
  model3011.addModel("Models/LegoBlockModels/3010Real.obj");
  model3011.addModel("Models/LegoBlockModels/Night/3010Real.obj");

  model3011.mColor = color( 255, 234, 0);
  model3011.def = new float [] { 
    3011, 14, 7, 1
  };
  structureArray.add(model3011);

  //2000 - Single story special - ID: 1
  Structure model2000 = new Structure();
  //Double Story commercial with bridge
  model2000.addModel("Models/LegoBlockModels/2000base.obj");
  model2000.addModel("Models/LegoBlockModels/2000.obj");
  model2000.addModel("Models/LegoBlockModels/2000Real.obj");
  model2000.addModel("Models/LegoBlockModels/Night/2000Real.obj");

  model2000.mColor = color( 0, 355, 0);
  model2000.def = new float [] { 
    2000, 1, 2.5, 0
  };
  structureArray.add(model2000);

  //2100 - 4 Story Terrace- ID: 3
  Structure model2100 = new Structure();
  //4 Story Terraced Residential
  model2100.addModel("Models/LegoBlockModels/2100base.obj");
  model2100.addModel("Models/LegoBlockModels/2100.obj");
  model2100.addModel("Models/LegoBlockModels/2100Real.obj");
  model2100.addModel("Models/LegoBlockModels/Night/2100Real.obj");

  model2100.mColor = color( 255, 0, 0);
  model2100.def = new float [] { 
    2100, 3, 3.5, 1
  };
  structureArray.add(model2100);


  //3100 - 4 Story - ID: 2
  Structure model3100 = new Structure();
  //4 Story Commercial
  model3100.addModel("Models/LegoBlockModels/3100base.obj");
  model3100.addModel("Models/LegoBlockModels/3100.obj");
  model3100.addModel("Models/LegoBlockModels/3100Real.obj");
  model3100.addModel("Models/LegoBlockModels/Night/3100Real.obj");

  model3100.mColor = color( 150, 0, 255);
  model3100.def = new float [] { 
    3100, 2, 4, 0
  };
  structureArray.add(model3100);

  //2010 - 7 Story Terraced Green- ID: 5
  Structure model2010 = new Structure();
  //Terraced 7 Story commercial
  model2010.addModel("Models/LegoBlockModels/2010base.obj");
  model2010.addModel("Models/LegoBlockModels/2010.obj");
  model2010.addModel("Models/LegoBlockModels/2010Real.obj");
  model2010.addModel("Models/LegoBlockModels/Night/2010Real.obj");

  model2010.mColor = color( 0, 255, 0);
  model2010.def = new float [] { 
    2010, 5, 5.25, 1
  };
  structureArray.add(model2010);


  //3110 - 10 Story Pink- ID: 6
  Structure model3110 = new Structure();
  //10 Story Residential
  model3110.addModel("Models/LegoBlockModels/3110base.obj");
  model3110.addModel("Models/LegoBlockModels/3110.obj");
  model3110.addModel("Models/LegoBlockModels/3110Real.obj");
  model3110.addModel("Models/LegoBlockModels/Night/3110Real.obj");

  model3110.mColor = color( 250, 0, 255);
  model3110.def = new float [] { 
    3110, 6, 10, 0
  };
  structureArray.add(model3110);


  //2110 - 10 Story Terraced Cyan- ID: 7
  Structure model2110 = new Structure();
  //10 Story Commercial
  model2110.addModel("Models/LegoBlockModels/2110base.obj");
  model2110.addModel("Models/LegoBlockModels/2110.obj");
  model2110.addModel("Models/LegoBlockModels/2110Real.obj");
  model2110.addModel("Models/LegoBlockModels/Night/2110Real.obj");

  model2110.mColor = color( 250, 255, 0);
  model2110.def = new float [] { 
    2110, 7, 9.25, 1
  };
  structureArray.add(model2110);


  //3001 - 14 Story Pink- ID: 7
  Structure model3001 = new Structure();
  //14 story Terraced glass 
  model3001.addModel("Models/LegoBlockModels/3001base.obj");
  model3001.addModel("Models/LegoBlockModels/3001.obj");
  model3001.addModel("Models/LegoBlockModels/3001Real.obj");
  model3001.addModel("Models/LegoBlockModels/Night/3001Real.obj");

  model3001.mColor = color( 255, 0, 255);
  model3001.def = new float [] { 
    3001, 8, 14, 0
  };
  structureArray.add(model3001);


  //2001 - 14 Story Terraced Pink- ID: 9
  Structure model2001 = new Structure();
  //14 story glass commercial
  model2001.addModel("Models/LegoBlockModels/2001base.obj");
  model2001.addModel("Models/LegoBlockModels/2001.obj");
  model2001.addModel("Models/LegoBlockModels/2001Real.obj");
  model2001.addModel("Models/LegoBlockModels/Night/2001Real.obj");

  model2001.mColor = color( 255, 0, 255);
  model2001.def = new float [] { 
    2001, 9, 13.25, 1
  };
  structureArray.add(model2001);


  //3101 - 18 Story  Cyan- ID: 10
  Structure model3101 = new Structure();
  //18 story Commercial Tower
  model3101.addModel("Models/LegoBlockModels/3101base.obj");
  model3101.addModel("Models/LegoBlockModels/3101.obj");
  model3101.addModel("Models/LegoBlockModels/3101Real.obj");
  model3101.addModel("Models/LegoBlockModels/Night/3101Real.obj");

  model3101.mColor = color( 0, 255, 255);
  model3101.def = new float [] { 
    3101, 10, 18, 1
  };
  structureArray.add(model3101);


  //2101 - 29 Story Terraced Cyan- ID: 11
  Structure model2101 = new Structure();
  //25-29 Story SkyScraper
  model2101.addModel("Models/LegoBlockModels/2101base.obj");
  model2101.addModel("Models/LegoBlockModels/2101.obj");
  model2101.addModel("Models/LegoBlockModels/2101Real.obj");
  model2101.addModel("Models/LegoBlockModels/Night/2101Real.obj");

  model2101.mColor = color( 0, 255, 255);
  model2101.def = new float [] { 
    2101, 11, 29, 1
  };
  structureArray.add(model2101);


//4447 
  Structure model4447 = new Structure();
  //25-29 Story SkyScraper
  model4447.addModel("Models/LegoBlockModels/2011base.obj");
  model4447.addModel("Models/LegoBlockModels/2011.obj");
  model4447.addModel("Models/LegoBlockModels/2011real.obj");
  model4447.addModel("Models/LegoBlockModels/Night/2011real.obj");

  model4447.mColor = color( 0, 255, 255);
  model4447.def = new float [] { 
    4447, 18, 29, 1
  };
  structureArray.add(model4447);






  println("model loaded");
  println("finished loading all shapes");
  modelsLoaded = true;
} // end init



float[][] buildingDef = new float[][] { 
  // Code, BLG ID, #floors, residential(0), commericial/ammenities(1), street(3), or park(4)
  {
    2000, 1, 2.5, 0
  }
  , 
  {
    2100, 3, 3.5, 1
  }
  , 
  {
    2010, 5, 5.25, 1
  }
  , 
  {
    2001, 9, 13.25, 1
  }
  , 
  {
    2110, 7, 9.25, 1
  }
  , 
  {
    2101, 11, 25, 1
  }
  , 
  {
    2011, 12, 0, 4
  }
  , 
  {
    2111, 13, 0, 3
  }
  , 

  {
    3000, 0, 2, 1
  }
  , 
  {
    3100, 2, 4, 0
  }
  , 
  {
    3010, 4, 7, 0
  }
  , 
  {
    3001, 8, 14, 0
  }
  , 
  {
    3110, 6, 10, 0
  }
  , 
  {
    3101, 10, 18, 1
  }
  , 
  {
    3011, 14, 7, 1
  }
  , 
  {
    3111, 15, 2, 0
  }
};

//0 - White
//1 - Black
//2 - Yellow
//3 - Red

