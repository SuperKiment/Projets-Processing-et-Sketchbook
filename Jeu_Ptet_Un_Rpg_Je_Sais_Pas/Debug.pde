void Debug() {
  noStroke();
  fill(0, 0, 0, 100);
  rect(0, 0, 300, 500);


  fill(0, 255, 0);
  text(xsouris + " , " + ysouris, 20, 20);
  text(mouseX + " , " + mouseY, 20, 40);
  text(xOrigine + " , " + yOrigine, 20, 60);
  text(echelle, 20, 80);
}
