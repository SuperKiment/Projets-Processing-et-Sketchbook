void keyPressed() {
  if (key == 'd') joueur.D();
  if (key == 'q') joueur.G();
  if (key == 'z') joueur.H();
  if (key == 's') joueur.B();

  /*
  if (key == 't') Verif(joueur.couleur, color(1), color(2), color(3));
   if (key == 'y') Verif(joueur.couleur, color(1), color(2), color(3));*/
  if (key == 'g') background(0, 255, 0);

  if (key == ' ' && start == false) {
    start = true;
    tempsgo = millis();
  }

  if (key == 'h') triche += 10;
  if (key == 'k') gagne = true;
}
