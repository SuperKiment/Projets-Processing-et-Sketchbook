int Tabl_Cartes_J_R[] = new int [11];
int Tabl_Cartes_J_B[] = new int [11];
int Carte_Deja_Distribuer = 0;

void Randomisation_des_Cartes_Au_Debut() {
  for (int i = 1; i<=10; i++) {
    Tabl_Cartes_J_R[i] = int(random(1, 13.4));                 //Randomise la main du joueur Rouge
    //Tabl_Cartes_J_R[i] = int(round(random(4.9, 5.1)));
    Tabl_Cartes_J_B[i] = int(random(1, 13.4));                 //Randomise la main du joueur Bleu
  }
}
void Redistribution_De_Cartes () {

  if (Tour == 1)
  {
    for (int i = 1; i<=10; i++) {
      if (Tabl_Cartes_J_R[i] == 0 && Carte_Deja_Distribuer == 0) {
        Tabl_Cartes_J_R[i] = int(random(1, 13.4));
        Carte_Deja_Distribuer = 1;
      }
    }
    Carte_Deja_Distribuer = 0;
  }
  if (Tour == 2)
  {
    for (int i = 1; i<=10; i++) {
      if (Tabl_Cartes_J_B[i] == 0 && Carte_Deja_Distribuer == 0) {
        Tabl_Cartes_J_B[i] = int(random(1, 13.4));
        Carte_Deja_Distribuer = 1;
      }
    }
    Carte_Deja_Distribuer = 0;
  }
}
