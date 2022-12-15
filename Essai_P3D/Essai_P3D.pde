float x, y, z;

void setup() {
  size(1000, 1000, P3D);
  background(0);
  ortho(-width/2, width/2, -height/2, height/2);
}

void draw() {
  background(0);

  camera(mouseX, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);

  fill(255);
  rectMode(CENTER);
  stroke(125);
  noFill();
  translate(width/2, height/2, -100);
  rect(width/2, height/2, 100, 100);
  translate(width/2, height/2, 0);
  translate(0, 0, -100);
  rect(width/2, height/2, 100, 100);

  //translate(x+1000, y+1000, 0);
  rect(width/2+1000, height/2+1000, 100, 100);
  //translate(x+1000, y+1000, -100);
  translate(0, 0, -100);
  rect(width/2+1000, height/2+1000, 100, 100);

  x = mouseX-width/2;
  y = mouseY-height/2;
}

void keyPressed() {
  if (key == 'd') x+=10;
  if (key == 'q') x-=10;
  if (key == 'z') y-=10;
  if (key == 's') y+=10;
}
