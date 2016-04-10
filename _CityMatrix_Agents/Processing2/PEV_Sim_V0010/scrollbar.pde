// Code based on "Scrollbar" by Casey Reas
// Editted by Yan Zhang (Ryan) <ryanz@mit.edu>
// Log:
// 160118 - add screenScale factor

HScrollbar[] hs = new HScrollbar[2];//
String[] labels =  {"SCORE_1", "SCORE_2"};

int x = 10;
int y = 30;
int w = 102;
int h = 14;
int l = 2;
int spacing = 4;

void setupScrollbars() {
  //for (int i = 0; i < hs.length; i++) {
  //  hs[i] = new HScrollbar(x, y + i*(h+spacing), w, h, l);
  //}
  hs[0] = new HScrollbar(156, 708, w, h, l);
  hs[1] = new HScrollbar(156, 732, w, h, l);

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
      newspos = constrain(int(mouseX/screenScale)-sheight/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 0) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX/screenScale > xpos && mouseX/screenScale < xpos+swidth &&
      mouseY/screenScale > ypos && mouseY/screenScale < ypos+sheight) {
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