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
  rect(largMenu/2, 50, 40, 40); //herbe

  fill(167, 143, 102);
  rect(largMenu/2 - 70, 50, 40, 40);   //Cases de selection à améliorer   terre

  fill(140, 157, 154);
  rect(largMenu/2 + 70, 50, 40, 40);//rocher

  fill(123, 63, 4);
  rect(largMenu/2, 50 + 70, 40, 40);//arbre

  fill(89, 168, 242);
  rect(largMenu/2 - 70, 50 + 70, 40, 40);//eau
  pop();
  
  push();
  strokeWeight(2);
  stroke(0);
  if (couleurSelect == herbe) fill(0, 180, 68);
  if (couleurSelect == terre ) fill(167, 143, 102);
  if (couleurSelect == roche ) fill(140, 157, 154);
  if (couleurSelect == arbre ) fill(123, 63, 4);
  if (couleurSelect == eau ) fill(89, 168, 242);
  
  rectMode(CENTER);
  rect(largMenu/2, 296, 50, 50);
  pop();
  
  
  pop();
  
  if (mousePressed == true && mouseButton == LEFT && mouseX > largMenu/2 -20 && mouseX < largMenu/2 +20 && mouseY > 50-20 && mouseY < 50+20) {  //Tout ça pour selectionner le vert mdr
    couleurSelect = herbe;
  }
}
