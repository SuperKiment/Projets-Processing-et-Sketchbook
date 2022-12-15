void Debug() {
  push();
  fill(0, 0, 0, 50);
  rect(0, 0, 200, 400);

  fill(255, 255, 255, 255);

  text(perso1.x + " / " + perso1.y, 10, 20);
  text(String.valueOf(-(perso1.x-11)*50) + " / " + String.valueOf(-(perso1.y-11)*50), 10, 40);
  text(String.valueOf(-(perso2.x-11)*50) + " / " + String.valueOf(-(perso2.y-11)*50), 10, 60);
  text(String.valueOf(loup1.timer), 10, 80);
  text(String.valueOf(loup1.temps), 10, 100);

  pop();
}
