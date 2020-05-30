// Flocking and Worley Noise by Daniel Shiffman, Combining of both ideas by Susul

Boid[] flock;

//These numbers need to be changed a bit, I cant get it to look right
float alignValue = .5;
float cohesionValue = 1;
float seperationValue = 1.2;

void setup() {
  size(640, 360);
  int n = 15; //The more boids, the slower it gets. This is the best my System could do.
  flock = new Boid[n];
  for (int i = 0; i < n; i++) {
    flock[i] = new Boid();
  }
}

void draw() {
  for (Boid boid: flock) {
    boid.edges();
    boid.flock(flock);
    boid.update();
  }
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float[] distances = new float[flock.length];
      for (int i = 0; i < flock.length; i++) {
        PVector v = flock[i].position;
        float z = frameCount % width;
        float d = dist(x, y, z, v.x, v.y, v.z);
        distances[i] = d;
      }
      float[] sorted = sort(distances);
      float r = map(sorted[0], 0, 200, 0, 255);
      int index = x + y * width;
      pixels[index] = color(r);
    }
  }
  updatePixels();
}
