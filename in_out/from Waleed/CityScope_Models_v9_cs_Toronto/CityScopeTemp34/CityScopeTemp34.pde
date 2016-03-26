// Software to translate webcam feeds into matrices of corresponding data.
//
// By Ira Winder, MIT Media Lab, April 2014
//
// Settings for ReConfigure Demo: mirror = true; gridU = gridV = 16; cellRes = 2; cellGap = 4; camWidth = 640; camHeight = 480;
//
// Updates for V22 (October 18, 2014):
//   - Adapt for use in Oct Member Week Demo
//
// Updates for V21 (July 25, 2014):
//   - (To Do) Allow Reference Colors to be directly referenced from webcam
//
//
// Updates for V20 (July 25, 2014)]:
//   - Allow clickable editing for togglesSettings (x,y,w,h)
//   - Allow editing for gridSettings (u,v,w,x,bitres,gaps,numcolors)
//
// Updates for V19 (July 24, 2014):
//   - Link Visualization to Corner Calibration
//   - Ensure app doesn't crash if no webcam found
//   - dynamic quantities of scan grids on a warped image
//   - Create ScanGrids nested within Image distortions
//   - Reorganize "scan" tab
//
// Updates for V18 (July 23, 2014):
//   - Rename and comment Tabs to be more helpful
//   - Create Unique HSBRGB Reference Color Tables
//
// Updates for V17 (July 22, 2014):
//   - Make option for multiple scanGrid Objects (unique corners, Ref Colors, #colors, bitres, cellGap, cellRes), cycle through them
//   - Edit ScanGrid to have quadGapRatio and rectangular grids
//
// Updates for V16 (July 21, 2014):
//   - Place Text Directions into UI Display
//   - Optimized GUI proportions
//   - Added grid cell outlines
//
// Updates for V15 (July 21, 2014):
//   - Cut out all tabs except for those related to scanning
//   - Set up scanGrid parameters (gridU, gridV, etc) to be editable while application is running
//   - Fix pixel blend error in "scanDisaply" image
//
// Updates for V13 (July 20, 2014):
//   - Placed "scanDisplay" UI Into its own applet frame
//
// Updates for V12 (July 18, 2014):
//   - Redesigned "scanDisplay" UI
//
// Updates for V11 (July 17, 2014):
//   - WebCam Dimensions no longer need to be defined in code
//   - Main tab's code cleaned
//   - Remaining tabs ready to be simplified into interchangeable "Scanning," "Database," "Analysis," and "Visualization" modules

// Position within array that describes available cameras

//int camera = 0; //1920x1080 res <- use this for MacBook

int camera = 0; //640x360res <- use this for PC
//int camera = 0; //640x480res
//int camera = 29; //1280x720 res
//int camera = 33; //1920x1080 res

//Number of scan grids to be created on each warped image
// For example:
// {1,1,1,1} creates 4 scan grids, each on their own, separately programmed, distorted image
// {4} creates 4 scan grids, all sharing the same distorted image
int[] numGridAreas = {1};

// Dimensions of surface being scanned
float vizRatio = float(16*20)/(16*20); //Must match measurements in reality, i.e. a table surface
int vizWidth = 16*20; //Resolution (in pixels)
int vizHeight = int(vizWidth/vizRatio);

void setup() {
  size(vizWidth*2+900, vizHeight*2, P2D);
  setupScan(); //Loads all Scan Objects (coordinates, reference colors, and configuration) into memory with initial conditions and starts camera
}

void draw() {
  background(0);
  runScan(vizWidth, vizHeight); //Updates and runs all scan objects
  //runViz();
  System.gc();
}
