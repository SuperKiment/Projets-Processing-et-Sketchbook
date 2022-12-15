void AfficherTableau(String Tableau[]) {
  push();
  fill(20, 20, 20, 150);
  rect(100, 750, 200, 500);
  pop();
  for (int i = 0; i<4; i++) {
    push();
    fill(#00FFF9);
    textSize(10);
    text("Tableau demandé : " + i + " : " + Tableau[i], 20, 550 + i*10);
    pop();
  }

  text("DataIn 3 : \"" + DataIn[3] + "\"", 20, 700);
}
