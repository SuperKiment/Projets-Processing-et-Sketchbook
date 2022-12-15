boolean moletteH = false;
boolean moletteB = false;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  println(e);

  if (e > 0) {
    moletteH = false;   //Molette vers nous
    moletteB = true;
    
    echelle /= 1.1;
    camX /= 1.05;
    camY /= 1.05;
  }

  if (e < 0) {
    moletteH = true;   //Molette pas vers nous
    moletteB = false;
    
    echelle /= 0.9;
    camX /= 0.95;
    camY /= 0.95;
  }
}
