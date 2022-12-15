void Affichage_des_valeurs() {
  textSize(15);

  stroke(255);
  line(250, 0, 250, 240);
  line(250, 270, 250, 500);

  text("Balle1 x : " + balle1.x, 20, 20);
  text("Balle1 y : " + balle1.y, 20, 40);
  text("Balle1 mouvx : " + balle1.mouvx, 20, 60);
  text("Balle1 mouvy : " + balle1.mouvy, 20, 80);

  text("Balle2 x : " + balle2.x, 20, 120);
  text("Balle2 y : " + balle2.y, 20, 140);
  text("Balle2 mouvx : " + balle2.mouvx, 20, 160);
  text("Balle2 mouvy : " + balle2.mouvy, 20, 180);

  text("test : " + test, 20, 220);

  text("dataOut : " + dataOut, 20, 260);
  text("dataIn : " + dataIn, 20, 280);


  text("Raquette1 y : " + raquette1.y, 270, 20);
  text("Raquette2 y : " + raquette2.y, 270, 40);

  text("Raquette1 taille : " + raquette1.taille, 270, 80);
  text("Raquette2 taille : " + raquette2.taille, 270, 100);
  text("Balle1 taille : " + balle1.taille, 270, 120);
  text("Balle2 taille : " + balle2.taille, 270, 140);

  text("Raquette1 ID : " + raquette1.ID, 270, 180);
  text("Raquette2 ID : " + raquette2.ID, 270, 200);

  text("Score G : " + scoreG, 270, 400);
  text("Score D : " + scoreD, 270, 420);
}
