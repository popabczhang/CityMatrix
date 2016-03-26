
import controlP5.*;
ControlP5 cp5;
TheControlListener myListener;


void startSlider() {

  cp5 = new ControlP5(this);

  cp5.addSlider("Value")
    .setPosition(width/2 + 10 + 45, 15)
      .setSize(20, 230)
        .setRange(0, 100)
          //.setNumberOfTickMarks(21)
          ;

  cp5.addSlider("Density")
    .setPosition(width/2 + 10, 15 )
      .setSize(20, 230)
        .setRange(0, 100)
          .setNumberOfTickMarks(21)
            ;

  myListener = new TheControlListener();
  cp5.getController("Value").addListener(myListener);
  cp5.getController("Density").addListener(myListener);

  cp5.getController("Value").hide();
  cp5.getController("Density").hide();
}



class TheControlListener implements ControlListener {
  float col;
  public void controlEvent(ControlEvent theEvent) {
    col = (float)theEvent.getController().getValue();

    if ("Value" == theEvent.getController().getName()) {
      //println(structureArray.get(currentStructure).type[currentType]);

      float total = 0;

      for (int i = 0 ; i<structureArray.get(currentStructure).type.length-1; i++) {
        if (i != currentType) {
          total += structureArray.get(currentStructure).type[i];
        }
      }

      if ((total + (float)col/100) < 1) {

        structureArray.get(currentStructure).type[currentType] = (float)col/100;
        structureArray.get(currentStructure).type[7] = 1.0 - (total + (float)col/100);

        //println(col);
      }
    }//End if Value



    if ("Density" == theEvent.getController().getName()) {

      structureArray.get(currentStructure).typeDensity[currentType] = (float)col/100;

      //color tempC = structureArray.get(currentStructure).typeColors[currentType];
      //structureArray.get(currentStructure).typeColors[currentType] = color(red(tempC),blue(tempC),green(tempC),((float)col/100)*255);
    }
  }//End Event
}

void keyPressed() 
{
  if (key=='b') {
    if (baseOnly) {
      baseOnly=false;
    }
    else {
      baseOnly=true;
    }
  }


  if (key=='s') {
    if (staticOnly) {
      staticOnly=false;
    }
    else {
      staticOnly=true;
    }
  }

  if (key=='r') {
    if (realistic) {
      realistic=false;
    }
    else {
      realistic=true;
    }
  }

  if (key=='g') {
    if (gradientMap) {
      gradientMap=false;
      planImage.hint(ENABLE_DEPTH_TEST);
      planImage.blendMode(BLEND);
      perspectiveImage.hint(ENABLE_DEPTH_TEST);
      perspectiveImage.blendMode(BLEND);
    }
    else {
      gradientMap=true;
    }
  }

  if (key=='z') {
    if (closeRender) {
      closeRender=false;
    }
    else {
      closeRender=true;
    }
  }



  if (key=='n') {

    if (night) {
      night=false;
    }
    else {
      night=true;
    }
  }

  if (key=='c') {

    if (colorOver) {
      colorOver=false;
    }
    else {
      colorOver=true;
    }
  }

  if (key=='e') {

    if (editingStructure) {
      editingStructure=false;
      cp5.getController("Value").hide();
      cp5.getController("Density").hide();
    }
    else {
      editingStructure=true;
      cp5.getController("Value").setValue(structureArray.get(currentStructure).type[currentType]*100);
      cp5.getController("Density").setValue(structureArray.get(currentStructure).typeDensity[currentType]*100);
      cp5.getController("Value").show();
      cp5.getController("Density").show();
    }
    getStructureID();
  }


  if (keyCode == LEFT ) {

    if (currentStructure != 0) {
      currentStructure -= 1;
    }
    else {
      currentStructure = structureArray.size()-1;
    }

    getStructureID();
  }

  if (keyCode == RIGHT ) {

    if (currentStructure != structureArray.size()-1) {
      currentStructure += 1;
    }
    else {
      currentStructure = 0;
    }
    getStructureID();
  }

  if (key=='s') {
    //////SAVE stuff here//////
  }
}



void mousePressed() {
  int step = 0;


  for ( int i = structureArray.get(currentStructure).type.length-1 ; i >= 0 ; i--) {

    //ratioImage.rect(30, 15 + step, 20, 20);

    if (mouseX > width/2+105 && mouseX< width/2+105+20 && mouseY > 15 + step && mouseY < 15 + step + 20) {

      currentType = i;

      cp5.getController("Value").setValue(structureArray.get(currentStructure).type[i]*100);
      cp5.getController("Density").setValue(structureArray.get(currentStructure).typeDensity[i]*100);

      if (currentType !=7) {
        cp5.getController("Value").show();
        cp5.getController("Density").show();
      }
      else {

        cp5.getController("Value").hide();
        cp5.getController("Density").hide();
      }

      println(currentType);
    }
    step += 30;
  }
}

