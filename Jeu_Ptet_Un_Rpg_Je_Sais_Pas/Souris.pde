boolean sourisLeft = false;

void mousePressed() {
  if (mouseButton == LEFT) {
    xsouris = mouseX;
    ysouris = mouseY;
    sourisLeft = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    sourisLeft = false;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  float changementEchelle = 0.75;

  if (e ==  1) echelle = echelle * changementEchelle;
  if (e == -1) echelle = echelle / changementEchelle;
}
