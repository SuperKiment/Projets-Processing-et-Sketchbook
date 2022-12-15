void keyPressed() {
  joueur1.LezGoDepl();
  joueur1.DeplacementOn(key);
}

void keyReleased() {
  joueur1.DeplacementOff(key);
}

void mousePressed() {
  BoutonsDetection();
}

void mouseReleased() {
  BoutonsDetection();
}
