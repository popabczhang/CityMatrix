boolean busyImporting = false;

void ImportData(String inputStr[]) {

  //println(lines);

  codeArray.clear();

  //println(inputStr.length);

  for (int i =0 ; i<inputStr.length;i++) {

    String tempS = inputStr[i];
    String[] split = split(tempS, "\t");

    if (split.length==5) {
      codeArray.add(split);
    }

    if (split.length==4) {
      overallDensity = float(split[0]);
      liveWorkRatio = float(split[1]);


      if (int(split[3]) != -1) {
        editingStructure=true;
        closeRender = true;
        currentStructureID = int(split[3]);
        getStructure();
        cp5.getController("Value").show();
        cp5.getController("Density").show();
        cp5.getController("Value").setValue(structureArray.get(currentStructure).type[currentType]*100);
        cp5.getController("Density").setValue(structureArray.get(currentStructure).typeDensity[currentType]*100);
        topPerspective=true; 
      } 
      else {
        closeRender = false;
        cp5.getController("Value").hide();
        cp5.getController("Density").hide();
        topPerspective=false; 
      }
      /*
        println("Editing Structure");
       currentStructureID = int(split[3]);
       getStructure();
       currentType = int(split[2]);
       float col1 = float(split[0]);
       structureArray.get(currentStructure).typeDensity[currentType] = (float)col1;
       
       
       float col2 = float(split[1]);
       float total = 0;
       for (int j = 0 ; j<structureArray.get(currentStructure).type.length-1; j++) {
       if (j != currentType) {
       total += structureArray.get(currentStructure).type[j];
       }
       }
       if ((total + (float)col2) < 1) {
       structureArray.get(currentStructure).type[currentType] = (float)col2;
       structureArray.get(currentStructure).type[7] = 1.0 - (total + (float)col2);
       //println(col);
       }
       
       
       cp5.getController("Value").setValue(structureArray.get(currentStructure).type[currentType]*100);
       cp5.getController("Density").setValue(structureArray.get(currentStructure).typeDensity[currentType]*100);
       cp5.getController("Value").show();
       cp5.getController("Density").show();
       }
       else {
       editingStructure=false;
       cp5.getController("Value").hide();
       cp5.getController("Density").hide();
       }
       */
    }

    //print("Array with:");
    //  println(split.length);
    //   println(split);
  }

  busyImporting = false;
}


void receive( byte[] data, String ip, int port ) {  // <-- extended handler

  // get the "real" message =
  String message = new String( data ); 
  String[] split = split(message, "\n");

  if (!busyImporting && split.length==(gridU*gridV) && !rendering) {
    busyImporting = true;
    ImportData(split);
  }
  // print the result
  //println(split[0]);
//  println("Length" + split.length);
}


/*
red =2
black=1
yellow=3
white=0

building codes: count clockwise facing code

2001 = Red-Stripe
2010 = Black-Stripe
2100 = Blue - Stripe
2101 = Beige - Stripe
2110 = Undefined


3001 = Darkgrey - Stripe
3010 = Yellow - Stripe
3100 = Green - Stripe
3000 = Brown - Stripe
3110 = Undefined


Special

2000 = Roads

Special - no rotation

13335 - Water
8891 - CrossRoad
4447 - EmptyLand

*/


