void Debug() {
  push();
  fill(0, 0, 0, 125);
  noStroke();
  rect(0, 0, 200, 500);

  fill(0, 255, 0);
  textSize(10);
  text(joueur1.recupDepl, 0, 10);
  text(joueur1.chronoDepl, 0, 20);
  text(joueur1.stopDepl, 0, 30);
  text(String.valueOf(bouton1.click), 0, 40);
  pop();
}
