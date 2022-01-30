// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage img;
ColorPalette purple = new ColorPalette(color(79, 51, 122)); //higlands purple

void setup() {
  size(900, 400);
  spots = new ArrayList<PVector>();
  img = loadImage("2017.png");
  img.loadPixels();
  //load an image and go to each pixel x, y for the full width and height
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      color c = img.pixels[index];  //everthing is black or white
      float b = brightness(c);  //get the brightness vlaue from the color
      if (b > 1) {
        spots.add(new PVector(x,y)); //if it is a white pixel save it
      }
      
    } 
  }
  circles = new ArrayList<Circle>();
}

void draw() {
  background(0);

  int total = 10;
  int count = 0;
  int attempts = 0;

  while (count <  total) {
    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }
    attempts++;
    if (attempts > max(width,height) * 0.109375) {
      noLoop();
      println("FINISHED");
      break;
    } 
  }


  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d - c.sWeight < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}

Circle newCircle() {
  
  int r = int(random(0,spots.size()));
  PVector spot = spots.get(r);
  float x = spot.x;  //put a circle at that pixel's position
  float y = spot.y;

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    //Circle(float x_, float y_, float r_, color skC_, int skW_, float growth_, boolean fill_, color fC_)
    return new Circle(x, y, 1.0, color(0,0,0,0), 0, 0.5, true,
                      purple.getTint(purple. getBaseColor(), int(random(-10,10))));
  } else {
    return null;
  }
}
