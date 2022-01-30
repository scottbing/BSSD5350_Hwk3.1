// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

class Circle {
  float x;
  float y;
  //defaults
  float r;  //radius
  color sColor = color(255);
  color fColor = color(255);
  int sWeight = 1;
  float growthRate = 0.5;
  boolean filled = false;
  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  Circle(float x_, float y_, float r_, color skC_, int skW_, float growth_, boolean fill_, color fC_) {
    x = x_;
    y = y_;
    r = r_;
    sColor = skC_;
    sWeight = skW_;
    growthRate = growth_;
    filled = fill_;
    fColor = fC_;
  }

  void grow() {
    if (growing) {
      r = r + growthRate;  // change 0.5 to a smaller or larger number to change the growth rate
    }
  }
  
  boolean edges() {
    return (x + r > width || x -  r < 0 || y + r > height || y -r < 0);
  }

  // if a class updates itself, you usually make a show function that draw calls
  // each froma to update the screen with htis instance of the class
  void show() {
    //we wil change these three lines to be passed in
    stroke(sColor);
    strokeWeight(sWeight);
    if(filled){
      fill(fColor);
    } else {
      noFill();
    }
    //draw the circle
    ellipse(x, y, r*2, r*2);
  }
}
