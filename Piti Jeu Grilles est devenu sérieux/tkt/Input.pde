void keyPressed() {
  if (key == 'z') joueur.mvty = -joueur.speed;
  if (key == 'q') joueur.mvtx = -joueur.speed;    //Bouger
  if (key == 's') joueur.mvty = joueur.speed;
  if (key == 'd') joueur.mvtx = joueur.speed;

  if (key == 't') pointeurDev.ChangementPeinture();

  if (key == ' ') joueur.arme.TirOn();             //Tirer

  if (key == 'a') inventaire.PoseObjet();            //Poser un objet de l'inventaire

  if (key == 'w') joueur.arme.Changer();          //Changer d'arme

  ChangementGrille();                         //Changer de grille

  if (key == '&'   ||
    key ==   'é'   ||
    key ==   '"'   ||
    key ==   '\''  ||       //Changer d'objet
    key ==   '('   ||
    key ==   '-'   ||
    key ==   'è'   ||
    key ==   '_'   ||
    key ==   'ç'   ) {
    inventaire.ChangerCase();
  }
}

void keyReleased() {
  if (key == 'z') joueur.mvty = 0;
  if (key == 'q') joueur.mvtx = 0;
  if (key == 's') joueur.mvty = 0;      //Arreter de bouger
  if (key == 'd') joueur.mvtx = 0;
  if (key == ' ') joueur.arme.TirOff();  //Arreter de tirer
}
