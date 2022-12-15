void keyPressed() {

  switch(joueurNo) {
  case 2 :
    if (key == 'd') joueur2.D();
    if (key == 'q') joueur2.G();
    if (key == 'z') joueur2.H();
    if (key == 's') joueur2.B();
    break;
  case 3 :
    if (key == 'd') joueur3.D();
    if (key == 'q') joueur3.G();
    if (key == 'z') joueur3.H();
    if (key == 's') joueur3.B();
    break;
  }

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

  if (key == 'c') {
    client = new Client(this, ipClient, 5204);
    clientActif = true;
  }

  if (clientActif == false) {
    if (key == '&') ipClient += "1";
    if (key == 'é') ipClient += "2";
    if (key == '"') ipClient += "3";
    if (key == '\'') ipClient += "4";
    if (key == '(') ipClient += "5";
    if (key == '-') ipClient += "6";
    if (key == 'è') ipClient += "7";
    if (key == '_') ipClient += "8";
    if (key == 'ç') ipClient += "9";
    if (key == 'à') ipClient += "0";
    if (key == ';') ipClient += ".";
    if (key == CODED && keyCode == CONTROL) ipClient = "";
  }
}
