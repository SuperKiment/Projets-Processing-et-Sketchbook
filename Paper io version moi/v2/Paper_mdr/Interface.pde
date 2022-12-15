void Interface() {

  push();

  stroke(200, 200, 200, 125);
  textSize(12);

  if (ID1 != 0) fill(0, 255, 0, 255);
  else fill(255, 0, 0, 125);
  text("Joueur 1 : ", 906, 24);
  ellipse(980, 20, 20, 20);
  
  if (ID2 != 0) fill(0, 255, 0, 255);
  else fill(255, 0, 0, 125);
  text("Joueur 2 : ", 906, 24+27);
  ellipse(980, 020+30, 20, 20);

  pop();
}
