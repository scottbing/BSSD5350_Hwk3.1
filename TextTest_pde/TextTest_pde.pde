int fontSize;
PFont f;
String textValue = "SSD";  //Text to display

void setup() {
  size(128, 128);
  int chars = textValue.length();
  fontSize = int(width/chars);
  f = createFont("Lucida Sans Typewriter Bold", fontSize, true); //font type, size, anti-alias on.
  //print(PFont.list()); //show available fonts
  background(0);
  noLoop();
}

void draw() {
  textAlign(LEFT, TOP);  //align the top let corner of the text bounding box
  textFont(f);  //set the font of the text
  float tw = textWidth(textValue);
  float th = fontSize; //height  is roughly font size. lowercas is exception
  fill(255);  //font color
  text(textValue, width/2-tw/2, height/2-th/2); //draw text at position
  saveFrame("text.jpg");
}
