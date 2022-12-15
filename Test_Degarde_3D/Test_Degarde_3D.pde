PImage image;
color[][] Grille = new color[70][70];

void setup() {
  frameRate(5);
  size (1400, 1400, P3D);
  image = loadImage("image.png");

  rectMode(CORNER);
  image(image, 0, 0);

  for (int x = -((width/2)/2)/10; x < ((width/2)/2)/10; x++) {
    for (int y = -((width/2)/2)/10; y < ((width/2)/2)/10; y++) {
      color c = get(x, y);
      Grille[x+35][y+35] = c;
    }
  }
}

void draw() {
  background(0);
  stroke(255);
  fill(0);



  push();
  rectMode(CENTER);
  translate(height/2, width/2);
  rotateX(PI/6);
  rotateZ(-PI/6);

  strokeWeight(3);
  //rect(0, 0, width/2, width/2);



  strokeWeight(1);
  for (int x = -((width/2)/2)/10; x < ((width/2)/2)/10; x++) {
    for (int y = -((width/2)/2)/10; y < ((width/2)/2)/10; y++) {
      print(" x : " + x + " y : " + y + " ");
      color c = Grille[x+35][y+35];
      push();
      fill(c);
      rect(x*15+5, y*15+5, 10, 10);
      pop();
      
    }
    println(" <- ");
  }
  pop();

  println("Largeur/Hauteur : " + (((width/2)/2)/10)*2);
}
