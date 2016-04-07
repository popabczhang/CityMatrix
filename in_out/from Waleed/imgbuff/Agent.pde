class Agent{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float wdelta;
  float maxforce;
  float maxspeed;
  int agentLoc;
  
  Agent( PVector l, float ms, float mf) {
    location = l.get();
    r = 1.5;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(maxspeed, 0);
  }
  
  void applyBehaviors(ArrayList agents) {
    PVector wand = new PVector();
    wand= wander();
    wand.mult(1);
    acceleration.add(wand);
    PVector s = separate(agents);
    s.mult(1);
    applyForce(s);
    try{
      agentLoc = pix[(int)abs(location.y%height)*height + (int)location.x];
      if (agentLoc == -16777216){ //-16777216
        PVector a = avoid(location);  
        a.mult(10);
        applyForce(a);
        acceleration.add(a);
      } 
    }catch(ArrayIndexOutOfBoundsException e){
    }
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  public void run() {
    update();
    borders();
    render();
  }

  PVector separate (ArrayList boids) {
    float desiredseparation = r*5;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Agent other = (Agent) boids.get(i);
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d); 
        steer.add(diff);
        count++;            
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }
    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce/2);
    }
    return steer;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  PVector wander() {
    wdelta += random(-1, 1);
    PVector center = velocity.get();
    center.mult(200000000.0);
    center.add(location); 
    PVector offset = new PVector(random(1,1000)*(wdelta), random(1,1000)*(wdelta));
    PVector target = PVector.add(center, offset);
    PVector steer = seek(target);   
    return steer;
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); 

    return steer;
  }
  
  PVector avoid(PVector target) {
    PVector steer; 
    PVector desired = PVector.sub(velocity, target); 
    float distance = mag2(desired); 
    if (distance > 0 && distance < (10000)*(10000)) {
      desired.mult(0);
      steer = PVector.sub(desired, velocity);
    }
    else {
      steer = PVector.sub(velocity,desired);
      steer.mult(maxspeed);//*100
    }
    return steer;
  }

  void render() {
    fill(75);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0, 0, r, r);
    popMatrix();
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}

  float mag2(PVector v) {
    return (v.x*v.x + v.y*v.y + v.z*v.z);
  }
