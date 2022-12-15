class Raquette {
  int x;
  int y;
  int vitesse;
  boolean haut = false;
  boolean bas = false;
  int taille = 50;
  boolean prise = false;
  float ID;

  Raquette(int nouvx, int nouvy, int nouvvitesse, int nouvtaille) {
    x = nouvx;
    y = nouvy;
    vitesse = nouvvitesse;
    taille = nouvtaille;
  }

  void Deplacement() {
    if (haut == true) y = y-vitesse;
    if (bas == true) y = y+vitesse;
  }
}


void Deplacement_Raquettes() {
  raquette1.Deplacement();
  raquette2.Deplacement();
}


void Traitement_Donnees() {

  if (raquette1.ID == 0) {  //Integre l'ID du joueur à la raquette si elle est libre
    raquette1.ID = DataIn[2];         //Pour ID1
    raquette1.prise = true;
  }
  if (raquette2.ID == 0 && raquette1.ID != DataIn[2]) {
    raquette2.ID = DataIn[2];         //Pour ID2
    raquette2.prise = true;
  }


  if (raquette1.ID == DataIn[2]) {
    if (DataIn[0] == 0) raquette1.haut = false;   // Si l'ID du joueur est la meme que celui de DataIn alors ça bouge
    if (DataIn[0] == 1) raquette1.haut = true;
    if (DataIn[1] == 0) raquette1.bas  = false;
    if (DataIn[1] == 1) raquette1.bas  = true;
  }
  if (raquette2.ID == DataIn[2]) {
    if (DataIn[0] == 0) raquette2.haut = false;
    if (DataIn[0] == 1) raquette2.haut = true;
    if (DataIn[1] == 0) raquette2.bas  = false;
    if (DataIn[1] == 1) raquette2.bas  = true;
  }
  
  if (DataIn[3] == 1) start = true;
}
