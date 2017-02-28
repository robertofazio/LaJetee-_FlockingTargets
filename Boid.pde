// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

float swt = 25.0;     //sep.mult(25.0f);
float awt = 4.0;      //ali.mult(4.0f);
float cwt = 5.0;      //coh.mult(5.0f);
float maxspeed = 1;
float maxforce = 0.125;


// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2009

// Boid class
// Methods for Separation, Cohesion, Alignment added

class Boid 
{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector tgt;
  float r;
  float rp;
  //IL MIO PUNTATORE AL TARGET
  ptrMyTarget tgtSwarmingPtr;
  PtrBool bTgt;

  Boid(float x, float y, PtrBool _bTgt, ptrMyTarget _tgtSwarmingPtr) 
  {
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    pos = new PVector(x,y);
    tgt = new PVector(0,0);
    r= 2.0;
    rp = 2.0 + random(-0.5,0.5)*r;

    bTgt = _bTgt;
    //PASSO IL PUNTATORE DEL TARGET ALL'INSTANZA DELL'OGGETTO BOID
    tgtSwarmingPtr = _tgtSwarmingPtr;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acc.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
   
    // Arbitrarily weight these forces
    sep.mult(swt);
    ali.mult(awt);
    coh.mult(cwt);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    
    //SE NON E' IN FUNZIONE L'ATTRATTORE DEL RETTANGOLO EFFETTUO UNO STEERING SUL TARGET
     if(!bTgt.b)
     {
         //ESEMPIO MOUSE
        //PVector cohTgt = cohesionTarget(new PVector(mouseX,mouseY));
         //ESEMPIO TARGET
        PVector cohTgt = cohesionTargetSuper(tgtSwarmingPtr.myTgt);
        //APPLICO LA FORZA
        applyForce(cohTgt);
     }

  }
  
  void goTarget(){
    if(pos.dist(tgt)<100){
      vel.set(0,0);
      
      //SETTO ANCHE L'ACCELERAZIONE A 0 IN MODO DA DARE LA STESSA DIREZIONE E NON CREARE DISTURBO DI MOVIMENTO AI BOID
      acc.set(0,0);
      
      pos.x = 0.95*pos.x+0.05*tgt.x;
      pos.y = 0.95*pos.y+0.05*tgt.y;


    }
    else
    {
      applyForce(superSeek(tgt));
    }
  }
  
  // Method to update position
  void update() {
    if(bTgt.b){
      goTarget();
    }
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    pos.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,pos);  // A vector pointing from the position to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }
  
  PVector superSeek(PVector target){
    PVector desired = PVector.sub(target,pos);  // A vector pointing from the position to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce*3);  // Limit to maximum steering force

    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(pos.x,pos.y);
    if(bTgt.b)
      rotate(0);
    else
      rotate(theta);
    beginShape(TRIANGLES);
    if(!bTgt.b)
    {
      vertex(0, -rp*2);
      vertex(-rp, rp*2);
      vertex(rp, rp*2);
    }
    else
    {
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
    }
    endShape();
    popMatrix();
    
    if(bTgt.b){
      pushStyle();
      noFill();
      stroke(255,0,0);
     // ellipse(tgt.x,tgt.y,10,10);
      popStyle();
    }
  }

  // Wraparound
  void borders() {
    //if (pos.x < -r) pos.x = width+r;
    //if (pos.y < -r) pos.y = height+r;
    //if (pos.x > width+r) pos.x = -r;
    //if (pos.y > height+r) pos.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0;
    PVector steer = new PVector(0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(pos,other.pos);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(pos,other.pos);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50.0;
    PVector steer = new PVector();
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos,other.pos);
      if ((d > 0) && (d < neighbordist)) {
        steer.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50.0;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos,other.pos);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.pos); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return seek(sum);  // Steer towards the position
    }
    return sum;
  }
  //FUNZIONE DI ATTRAZIONE AL TARGET
  PVector cohesionTargetSuper (PVector boidTarget) {
    return superSeek(boidTarget);  // Steer towards the position 
  }
  PVector cohesionTarget (PVector boidTarget) {
    return seek(boidTarget);  // Steer towards the position 
  }
}