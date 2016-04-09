PGraphics pg;

void setup(){
  size(800,800);
  pg =  createGraphics(200,200);
  colorMode(RGB, 255);
  background(150,0,0);
}

void draw(){
  pg.beginDraw();
  pg.background(0,150,0);
  pg.stroke(255,255,255);
  pg.line(100, 100, mouseX, mouseY);
  pg.endDraw();
  image(pg, 100, 100); 
  image(pg, 400, 100);
}

void mousePressed(){
  image(pg, mouseX, mouseY);
}

void mouseReleased(){
  background(0,0,0);
}
