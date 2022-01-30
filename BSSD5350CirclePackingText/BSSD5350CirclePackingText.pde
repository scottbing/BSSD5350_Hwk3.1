// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage img;

ColorPalette purple = new ColorPalette(color(79, 51, 122)); //higlands purple
HelperFunctions hf = new HelperFunctions();

int fontSize;
PFont f;
String textValue = "SSD"; //Text to display

void setup() {
  size(500, 500);
  frameRate(48);
  createText();  //this will flicker on screen so I made framerate fast
  frameRate(24);  //then I lowered framerate to watch circles grow
  loadTextPixels();
}  
  
void createText() {
  int chars = textValue.length()-1;
  fontSize = int(width/chars)-10;
  f = createFont("Arial", fontSize, true); //font type, size, anti-alias on.
  //print(PFont.list()); //show available fonts
  background(0);
  
  textAlign(LEFT, TOP);  //align the top let corner of the text bounding box
  textFont(f);  //set the font of the text
  float tw = textWidth(textValue);
  float th = fontSize; //height  is roughly font size. lowercas is exception
  fill(255);  //font color
  text(textValue, width/2-tw/2, (height/2-th/2)); //draw text at position
  saveFrame("text.jpg");
}
  
  

void loadTextPixels() {  
  spots = new ArrayList<PVector>();
  img = loadImage("text.jpg");
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
    hf.save("video");
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
