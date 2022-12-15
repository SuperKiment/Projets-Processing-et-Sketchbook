void Debug() {
  push();println("push");
  fill(0, 0, 0, 125);
  noStroke();
  rect(0, 0, 200, 500);

  fill(0, 255, 0);
  textFont(Paul);
  textSize(20);
  text(joueur1.recupDepl, 0, 10);
  text(joueur1.chronoDepl, 0, 20);
  text(joueur1.stopDepl, 0, 30);
  text(String.valueOf(bouton1.click), 0, 40);
  text(String.valueOf(MenuStart.Option.click), 0, 60);
  text(Soleil.xheure, 0, 70);
  text(Soleil.xPos, 0, 80);
  text(Soleil.yPos, 0, 90);
  text(Soleil.zPos, 0, 100);

  pop();
}
