void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)    joueur.depHaut   = true;
    if (keyCode == DOWN)  joueur.depBas    = true;  //Deplacement true  j1
    if (keyCode == LEFT)  joueur.depGauche = true;
    if (keyCode == RIGHT) joueur.depDroite = true;
  }

  if (key == 'z') joueur2.depHaut =   true;
  if (key == 's') joueur2.depBas =    true;  //Deplacement true  j2
  if (key == 'q') joueur2.depGauche = true;
  if (key == 'd') joueur2.depDroite = true;
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)    joueur.depHaut   = false;
    if (keyCode == DOWN)  joueur.depBas    = false;  //Deplacement false j1
    if (keyCode == LEFT)  joueur.depGauche = false;
    if (keyCode == RIGHT) joueur.depDroite = false;
  }

  if (key == 'z') joueur2.depHaut =   false;
  if (key == 's') joueur2.depBas =    false;  //Deplacement false j2
  if (key == 'q') joueur2.depGauche = false;
  if (key == 'd') joueur2.depDroite = false;
}
