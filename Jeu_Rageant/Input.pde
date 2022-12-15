void keyPressed() {
  if (key == ' ' && ecran == "Ecran Titre") {
    ecran = "Jeu";
    EnnemiReset();
    timer.Go();
  }

  if (key == ' ' && ecran == "Mort") {
    ecran = "Ecran Titre";
    joueur.Reset();
    EnnemiReset();
  }

  if (ecran == "Ecran Titre") {
    if (key == '&' || key == '1') difficulte = 1;
    if (key == 'é' || key == '2') difficulte = 2;
    if (key == '"' || key == '3') difficulte = 3;
  }
}
