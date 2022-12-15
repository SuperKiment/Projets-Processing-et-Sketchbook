void keyPressed() {
  joueur1.LezGoDepl();
  joueur1.DeplacementOn(key);


  if (key == 'g' && dimensionActive == 0) ChangementDim(1);
  if (key == 't' && dimensionActive == 1) ChangementDim(0);

  if (key == ' ') jeuActif = true;
}

void keyReleased() {
  joueur1.DeplacementOff(key);
}

void mousePressed() {
  BoutonsDetection();
  joueur1.PoseBloc();
  barreInventaire.SelectSlot();
}

void mouseReleased() {
  BoutonsDetection();
}
