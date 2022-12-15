void setup() {
  size(640, 360, P3D);
}

void draw() {
  stroke(255);
  background(0);
  fill(255);
  camera(-mouseX+width/2, -mouseY+height/2, (height/2) / tan(PI/6), -mouseX+width/2, -mouseY+height/2, 0, 0, 1, 0);
  for (int i = -10; i<=10; i++) {
    rect(i*100, 0, 90, 90);
  }
  translate(0, 0, 100);
  noFill();
  stroke(125);
  fill(50, 50, 50, 125);
  for (int i = -10; i<=10; i++) {
    rect(i*100, 0, 90, 90);
  }
}
