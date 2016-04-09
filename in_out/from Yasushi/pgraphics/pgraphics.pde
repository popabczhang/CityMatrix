PGraphics g;


void setup(){
  size(500,500);
  
  g =  createGraphics(width,height);
  
  g.beginDraw();
  g.background(255);
  g.endDraw();
  background(0);
}

void draw(){
  
}

void mousePressed(){
  image(g,0,0);
}

void mouseReleased(){
  background(0);
}
