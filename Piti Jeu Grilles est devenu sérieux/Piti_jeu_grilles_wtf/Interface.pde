void Interface() {
  push();
  rectMode(CENTER);
  fill(pointeurDev.couleurPointeur);
  rect(width/2, height*7/8, 100, 20);
  fill(0);
  rect(0, 0, 100, 50);
  fill(255);
  text(joueur.arme.armeEquipee, 0, 20);
  pop();
}
