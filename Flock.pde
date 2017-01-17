// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock 
{
  ArrayList<Boid> boids; // An ArrayList for all the boids
  Flock() 
  {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() 
  {
    for (Boid b : boids) {    b.run(boids);  // Passing the entire list of boids to each boid individually
      }
  }
  void runWithLimit(int max) {
    int   i=0;
    for (Boid b : boids) {   
      if(i<max)
      {
        float limit = maxspeed*3/8 + maxspeed*5/8 * ( (i+1)/ (boids.size()+10));
        b.vel.limit(limit);
        b.run(boids); // Passing the entire list of boids to each boid individually
        i++;
      }
      else
        break;
    }
  }
  void addBoid(Boid b) {
    boids.add(b);
  }

}