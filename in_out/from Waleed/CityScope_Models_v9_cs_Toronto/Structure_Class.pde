

class Structure 
{
  ArrayList <PShape> models;
  color mColor;
  float[] def;

  float[] typeDensity = new float [] { 
    0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
  }; 

  float alphaV = 155;

  float[] type = new float [] { 
    0.1, 0.05, 0.15f, 0.15f, 0.15f, 0.1, 0.1, 0.1
  }; 

  color[] typeColors = new color [] { 
    color(255, 255, 255, 150), 
    color(0, 255, 0, 150), 
    color(255, 0, 0, 150), 
    color(203, 0, 54, 150), 
    color(255, 188, 0, 150), 
    color(255, 255, 0, 150), 
    color(255, 242, 167, 150), 
    color(50, 50, 50, 150)
  }; 

  /*
   0-  Built-Ground - White
   1-  Open-Recreational - Green
   2-  Commercial-Retail  - Red
   3-  Commercial-Office - Dark Red
   4-  Residential-Family - Orange Yellow
   5-  Residential-Single -  Yellow
   6-  Residential Upper - whiteYellow
   7-  Empty - Black
   */


  float fontSz = .45;
  float az = 0f;

  boolean pulse= true;

  Structure() {
    models = new ArrayList <PShape> ();  // Create an empty ArrayList
  }

  void addModel(String path) {

    PShape tempModel = loadShape(path);
    models.add(tempModel);
  }


  void drawStructure(PGraphics pg, boolean bOnly, boolean realistic, float rotation) {


    pg.translate((boxW/2), (boxW/2), 0);
    pg.rotateZ(radians(rotation));
    pg.translate(-(boxW/2), -(boxW/2), 0);

    if (bOnly) {
      pg.shape(models.get(0));
    }
    else {

      if (currentStructureID != def[1]) {

        render(pg);
      }
      else if (currentStructureID == def[1]) { //editingStructure

        if (editingStructure) {

          float totalHeight = (boxH*3) * def[2];

          if (def[2]==0) {
            pg.stroke(255, 255, 255);

            if (def[1]==13) {
              pg.fill(255, 255, 255);
            }
            if (def[1]==12) {
              pg.fill(0, 255, 0);
            }
            pg.translate(boxW/2, boxW/2, (boxH/2)/2);
            pg.box(boxW, boxW, boxH + (boxH/2));//flat surfaces
            pg.translate(-boxW/2, -boxW/2, -(boxH/2)/2);
          }
          else {
            //Build Blocks
            float baseheight = 0;

            float spacer = 0.1;

            //Built-Ground - White
            if (currentType == 0 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[0]);
            }
            pg.translate(boxW/2, boxW/2, (totalHeight * type[0])/2);
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[0]>0.01) {
              pg.box(boxW, boxW, (totalHeight * type[0])-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[0]);
                drawLeader(pg, "Open Ground", type[0], typeDensity[0], rotation);
              }
            }


            //Open-Recreational - Green
            if (currentType == 1 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[1]);
            }
            pg.translate(0, 0, ((totalHeight * type[0])/2) +(totalHeight * type[1]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[1]>0.01) {
              pg.box(boxW, boxW, (totalHeight * type[1])-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[1]);
                drawLeader(pg, "Recreation", type[1], typeDensity[1], rotation);
              }
            }

            //Commercial-Retail  - Red
            if (currentType == 2 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[2]);
            }
            pg.translate(0, 0, ((totalHeight * type[1])/2) +(totalHeight * type[2]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[2]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[2]-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[2]);
                drawLeader(pg, "Retail", type[2], typeDensity[2], rotation);
              }
            }

            //Commercial-Office - Dark Red
            if (currentType == 3 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[3]);
            }
            pg.translate(0, 0, ((totalHeight * type[2])/2) +(totalHeight * type[3]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[3]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[3]-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[3]);
                drawLeader(pg, "Office", type[3], typeDensity[3], rotation);
              }
            }

            // Residential-Family - Orange Yellow
            if (currentType == 4 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[4]);
            }
            pg.translate(0, 0, ((totalHeight * type[3])/2) +(totalHeight * type[4]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[4]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[4]-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[4]);
                drawLeader(pg, "Family", type[4], typeDensity[4], rotation);
              }
            }

            // Residential-Single -  Yellow
            if (currentType == 5 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[5]);
            }
            pg.translate(0, 0, ((totalHeight * type[4])/2) +(totalHeight * type[5]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[5]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[5]-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[5]);
                drawLeader(pg, "Single", type[5], typeDensity[5], rotation);
              }
            }
            // Residential Upper - whiteYellow
            if (currentType == 6 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[6]);
            }
            pg.translate(0, 0, ((totalHeight * type[5])/2) +(totalHeight * type[6]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[6]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[6]-spacer);//Percentage
              if (leader) {
                pg.stroke(typeColors[6]);
                drawLeader(pg, "Special", type[6], typeDensity[6], rotation);
              }
            }

            // None - black
            if (currentType == 7 && pulse) {
              pg.fill(color(red(typeColors[currentType]), green(typeColors[currentType]), blue(typeColors[currentType]), 255-alpha(typeColors[currentType]) + (abs(sin(frameCount/15.0))*alpha(typeColors[currentType]))));
            }
            else {
              pg.fill(typeColors[7]);
            }
            pg.translate(0, 0, ((totalHeight * type[6])/2) +(totalHeight * type[7]/2));
            pg.strokeWeight(0.5);
            pg.stroke(255, 255, 255);
            if (type[7]>0.01) {
              pg.box(boxW, boxW, totalHeight * type[7]-spacer);//Percentage
              if (leader) {
                pg.stroke(255);
                drawLeader(pg, "Void", type[7], typeDensity[7], rotation);
              }
            }

            pg.translate(-boxW/2, -boxW/2, -totalHeight);
          }



          /*
          pg.fill(255, 0, 0);
           
           if (def[2]==0) {
           pg.box(boxW, boxW, boxH + (boxH/2));//flat surfaces
           }
           else {
           pg.box(boxW, boxW, ((boxH*3) * def[2]));//Stories
           }
           */
        }
        else {//editingStructure
          render(pg);
        }
      }


      //Experiment with Coloring
      /*
        pg.hint(DISABLE_DEPTH_TEST);
       //pg.noLights();
       pg.pushMatrix();
       pg.blendMode(MULTIPLY);
       
       pg.translate((boxW/2)-0.1, (boxW/2)-0.1, (def[2]*(boxH*4))/2);
       pg.fill(mColor);
       pg.noStroke();
       pg.box(boxW+0.3, boxW+0.3, (def[2]*(boxH*4)));
       pg.translate(-((boxW/2)-0.1), -((boxW/2)-0.1), -(def[2]*(boxH*4))/2);
       pg.blendMode(NORMAL);
       pg.popMatrix();
       pg.hint(ENABLE_DEPTH_TEST);
       */
    }
  }//end void

  void drawLeader(PGraphics pg, String text, float value, float density, float rotation) {


    String tempS = text + ": " + String.format("%.1f", value*100) + "%   d=" + int(density * 100);

    if (closeRender) {
      pg.pushMatrix();
      pg.rotateZ(radians(-rotation));
      pg.strokeWeight(1.0);
      pg.line(0, 0, 0, -2.5, 2.5, 0);
      pg.textFont(font, fontSz);
      //pg.textAlign(RIGHT, TOP);
      pg.rotateZ(radians(135));
      pg.rotateX(radians(-100));
      pg.fill(255, 255, 255, 255);

      pg.text(tempS, 2+boxW/2, 0, 0);

      pg.popMatrix();
    }
  }





  void render(PGraphics pg) {
    if (realistic) {
      //models.get(2).disableStyle();
      if (!night) {
        //models.get(2).noTexture();
        pg.shape(models.get(2));
      }
      else {
        pg.shape(models.get(3));
      }
    }
    else {

      pg.shape(models.get(0));

      if (colorOver) {
        models.get(1).disableStyle();
        pg.fill(mColor);
      }
      else {
        pg.fill(240, 240, 240);
      }
      pg.shape(models.get(1));
    }
  }
}//end class

