float echelle = 1; //<>//

float xOrigine;
float yOrigine;

float xsouris;
float ysouris;

void Camera() {

  if (sourisLeft == true) {
    xOrigine = xOrigine + (mouseX - xsouris)/echelle;
    xsouris = mouseX;

    yOrigine = yOrigine + (mouseY - ysouris)/echelle;
    ysouris = mouseY;
  }
}
