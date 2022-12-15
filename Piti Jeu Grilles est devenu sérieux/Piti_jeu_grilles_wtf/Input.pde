void keyPressed() {
  if (key == 'z') joueur.mvty = -joueur.speed;
  if (key == 'q') joueur.mvtx = -joueur.speed;
  if (key == 's') joueur.mvty = joueur.speed;
  if (key == 'd') joueur.mvtx = joueur.speed;

  if (key == 'r') pointeurDev.ChangementCouleur();

  if (key == ' ') joueur.arme.TirOn();

  if (key == 'a') AjouterBloc(pointeurDev.posx, pointeurDev.posy, int(random(1, 1000)), false);
  if (key == 'f') AjouterPantin(ConvPixelGrille(pointeurDev.x), ConvPixelGrille(pointeurDev.y), 50, false);

  if (key == 'w') joueur.arme.Changer();

  ChangementGrille();
}

void keyReleased() {
  if (key == 'z') joueur.mvty = 0;
  if (key == 'q') joueur.mvtx = 0;
  if (key == 's') joueur.mvty = 0;
  if (key == 'd') joueur.mvtx = 0;
  if (key == ' ') joueur.arme.TirOff();
}
