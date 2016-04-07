color[] pix;
int hey= 0;
int pix2= 0;
ArrayList<Agent> agent;

void setup(){
  size(2179,2179);
  PImage img = loadImage("sidewalk_buffer.png");
  img.loadPixels();
  pix = img.pixels;
  agent = new ArrayList<Agent>();
  for (int i = 0; i < 300; i++) {
    newAgent(193,932);
    newAgent(404,833);
    newAgent(553,834);
    newAgent(553,932);
  }
}

void draw(){
  background(255);
  for (Agent a : agent) {
  a.applyBehaviors(agent);
  a.run();
  }
}

void newAgent( int x,int y) {
  float maxspeed = random(2,5);
  float maxforce = .3;
  agent.add(new Agent(new PVector(x,y), maxspeed, maxforce));
}

