boolean clickG = false;
boolean clickD = false;
boolean clickM = false;

void mousePressed() {
  if (mouseButton == LEFT && mouseX > largMenu) {
    clickG = true;
  }
  if (mouseButton == RIGHT && mouseX > largMenu) {
    clickD = true;
  }
  if (mouseButton == CENTER && mouseX > largMenu) {

    inicamX = mouseX;   //Pour le deplacement de la cam
    inicamY = mouseY;

    clickM = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) clickG = false;
  if (mouseButton == RIGHT) clickD = false;
  if (mouseButton == CENTER) clickM = false;
}
