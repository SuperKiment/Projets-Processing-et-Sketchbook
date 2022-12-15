void Debug() {
  fill(0, 0, 0, 100);
  stroke(0, 255, 0);
  rectMode(CORNER);
  rect(0, 0, 200, 200);
  fill(0, 255, 0, 255);
  
  text(joueur.x + "  " + joueur.y, 20, 20);
  text(joueur.orientation, 20, 40);
}
