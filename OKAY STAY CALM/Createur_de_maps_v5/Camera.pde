int camX;
int camY;
int inicamX;
int inicamY;
int deplcamX;
int deplcamY;


void Camera() {

  if (clickM == true) {
    deplcamX = inicamX - mouseX;
    deplcamY = inicamY - mouseY;
    
    camX -= deplcamX;
    camY -= deplcamY;            //Voilà bref ça marche hein
    
    inicamX = mouseX;
    inicamY = mouseY;
  }
}

void Zoom() {
  camX *= echelle;
  camY *= echelle;
}
