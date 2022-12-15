int xOri;
int yOri;

int xSouris;
int ySouris;

int echelle = 1;

boolean souris = false;

void setup() {
  size(500, 500);
}

void draw() {
  background(50);
  text(xSouris + " , " + ySouris, 10, 200);
  text(xOri + " , " + yOri, 10, 220);
  text(echelle, 10, 240);

  if (souris == true) {
    xOri = xOri + (mouseX-xSouris);
    yOri = yOri + (mouseY-ySouris);
    xSouris = mouseX;
    ySouris = mouseY;
  }

  rect(300, 300, 40, 40);

  pushMatrix();
  translate(xOri, yOri);
  scale(echelle);
  rect(0, 0, 50, 50);
  rect(100, 0, 50, 50);
  popMatrix();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    souris = true;

    xSouris = mouseX;
    ySouris = mouseY;
  }

  if (mouseButton == RIGHT) {
    echelle ++;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    souris = false;
  }

  if (mouseButton == CENTER) {
    echelle --;
  }
}
