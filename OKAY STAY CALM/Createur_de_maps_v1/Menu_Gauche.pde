int largMenu = 300;

void MenuAffichage() {
  push();

  fill(200);
  rect(0, 0, largMenu, height);

  GrilleAffichage((largMenu/7)*5/nbCasesX, largMenu/7, 476);

  fill(150);
  rect(0, 0, largMenu, 400);  //partie sombre haute

  push();
  rectMode(CENTER);
  stroke(0);

  fill(0, 180, 68);
  rect(largMenu/2, 50, 40, 40);

  fill(167, 143, 102);
  rect(largMenu/2 - 70, 50, 40, 40);   //Cases de selection à améliorer

  fill(140, 157, 154);
  rect(largMenu/2 + 70, 50, 40, 40);

  fill(123, 63, 4);
  rect(largMenu/2, 50 + 70, 40, 40);

  fill(89, 168, 242);
  rect(largMenu/2 - 70, 50 + 70, 40, 40);
  pop();
  pop();
  
  
}
