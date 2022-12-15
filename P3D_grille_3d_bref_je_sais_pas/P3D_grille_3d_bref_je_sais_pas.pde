color Grille[][];
PImage image;

void setup() {
  size(1000, 1000, P3D);
  background(0);
  ortho();
  image = loadImage("image3.png");
  image(image, 0, 0);
  println(image.width + "  " + image.height);
  Grille = new color [image.width][image.height];
  for (int x = 0; x<image.width; x++) {
    for (int y = 0; y<image.height; y++) {
      Grille[x][y] = get(x, y);
    }
  }
}

float sinOff = 0;

void draw() {
  background(0);
  
  sinOff += 0.01;

  int xBox = width/image.width;
  int yBox = height/image.height;

  push();
  translate(height/2, height/2);
  rotateX(PI/4);
  rotateZ(PI/4);
  //rotateY(sinOff);
  fill(255);
  for (int x = 0; x < Grille.length; x++) {
    for (int y = 0; y < Grille.length; y++) {
      push();
      fill(Grille[x][y]);
      translate(x*xBox-(Grille.length/2)*xBox, y*yBox-(Grille.length/2)*yBox, 0);
      //noStroke();
      if (brightness(Grille[x][y]) != 0) {
        box(xBox, yBox, brightness(Grille[x][y]));
      }
      pop();
    }
  }
  pop();
}
