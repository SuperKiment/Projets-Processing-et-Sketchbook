void keyPressed() {
  joueur1.LezGoDepl();
  joueur1.DeplacementOn(key);


  if (key == 'g' && dimensionActive == 0) ChangementDim(1);
  if (key == 't' && dimensionActive == 1) ChangementDim(0);

  if (key == ' ') jeuActif = true;

  if (key == 'x') joueur1.SprintOn();

  if (key == 'e') stockTest.ActifInactif();
}

void keyReleased() {
  joueur1.DeplacementOff(key);
  if (key == 'x') joueur1.SprintOff();
}

void mousePressed() {
  BoutonsDetection();
  barreInventaire.SelectSlot();
  MenuStart.Souris();
  joueur1.PoseBloc();
}

void mouseDragged() {
  joueur1.PoseBloc();
}

void mouseReleased() {
  BoutonsDetection();
  MenuStart.Souris();
}
