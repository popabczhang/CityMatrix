import javax.swing.JFrame;
import deadpixel.keystone.*;

int projector_width = 1280;
int projector_height = 800;

projApplet projA;

// defines Keystone settings from xml file in parent folder
Keystone ks1; 
// defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface surface1;

PGraphics buffer1; 
PImage imgCapture;


boolean drawReady = false;


void setup_ImageProj() {

  // Window # 1
  PFrameE projFrame = new PFrameE();
  projFrame.setTitle("East Window");
  projFrame.setLocation(1440, 0);
  //projFrame.setLocation(0, 0);

}

public class PFrameE extends JFrame {
  public PFrameE() {
    setBounds(0, 0, projector_width, projector_height);
    projA = new projApplet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(projA); 
    projA.init(); 
    show();
    setTitle("East Window");
  }
}


public class projApplet extends PApplet {
  public void setup() {
    size(projector_width, projector_height, P2D);

    // set up and open Keystone window with xml file
    ks1 = new Keystone(this);  
    buffer1 = createGraphics(imageCapture_width, imageCapture_height);

    // creates the projection surfaces, to be manipulated in draw()
    surface1 = ks1.createCornerPinSurface(400, 400, 20);
    //ks1.load();
    //ks1.save();
  }
  public void draw() {
    if (!rendering) {
      background(0);
      //image(imgCapture, 0, 0);
      //println("Drawing");

      buffer1.beginDraw();
      buffer1.background(200);
      //buffer1.blendMode(MULTIPLY);
      buffer1.image(imgCapture, -96, -118);
      buffer1.endDraw();
      surface1.render(buffer1, 0, 0, imageCapture_width-190, imageCapture_height-240);
    }
  }

  void keyPressed() {
    switch(key) {
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved
      ks1.toggleCalibration();
      break;

    case 'l':
      // loads the saved layout
      ks1.load();
      break;

    case 's':
      // saves the layout
      ks1.save();
      break;
    }
  }
}

