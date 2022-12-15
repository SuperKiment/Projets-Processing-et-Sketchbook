void setup() {
  PImage image = loadImage("blanc.png");
  size(500, 500);
  background(0);
  fill(255);
  rectMode(CENTER);
  imageMode(CENTER);
  for (int i=0; i<10000; i++) {
    image(image, 250, 250, 200, 200);
    //rect(250, 250, 200, 200);
  }
  println(millis());
}
