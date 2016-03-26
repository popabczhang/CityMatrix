import gab.opencv.*;
////// Gradient - Density Mapping using OpenCV///////////////
////// August 2014 - Carson Smuts////////


// Screen size
int ssize = 336;
PGraphics gradMap;

float stepSize = ssize/14;

// The index of the current heatmap
int index = 0;

// Array to store the heat values for each pixel
float heatmap[][][] = new float[2][ssize][ssize];

OpenCV opencvHeatM;
PImage src, dst;

PImage srcGrad;
PImage dstGrad;

void setUpGradientMap() {

  gradMap = createGraphics(ssize, ssize, P2D);

  // Initalize the heat map (make sure everything is 0.0)
  for (int i = 0; i < ssize; ++i)
    for (int j = 0; j < ssize; ++j)
      if (i%stepSize==(stepSize/2) && j%stepSize==(stepSize/2)) 
        heatmap[index][i][j] = random(140);
      else 
        heatmap[index][i][j] = 0;


  src = gradMap.get();
  opencvHeatM = new OpenCV(this, src);
}

void updateGradientMap() {
  // For each pixel, translate its heat to the appropriate color
  gradMap.beginDraw();
  gradMap.background(0);
  gradMap.blendMode(BLEND);

  for (int i = 0; i < ssize; ++i) {
    for (int j = 0; j < ssize; ++j) {
      float blocksize = stepSize;
      if (i%stepSize==(stepSize/2) && j%stepSize==(stepSize/2)) {
        gradMap.fill(heatmap[index][i][j]);
        gradMap.noStroke();
        gradMap.rect(i-(blocksize/2), j-(blocksize/2), blocksize, blocksize);
      }
    }
  }

  gradMap.endDraw();

  opencvHeatM.loadImage(gradMap.get());
  opencvHeatM.contrast(3);
  opencvHeatM.blur(30); 
  dstGrad = opencvHeatM.getOutput();



  // image(dstGrad, 0, 0);
}

