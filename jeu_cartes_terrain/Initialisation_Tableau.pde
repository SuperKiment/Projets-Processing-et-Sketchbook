int Tabl_General[][] = new int [4][10];
int Tabl_RougeBleu[][] = new int [4][10];
int Tabl_Rouge_DejaJoue[] = new int [13];
int Tabl_Bleu_DejaJoue[] = new int [13];                      //permet de savoir si on a déjà joué un numéro de la main bleu et rouge
int Tabl_GDejaJoue[][]= new int [4][10];                      //permet de savoir si on a déjà avancé une carte sur le jeu
int Tabl_PreSelection[][] = new int [4][10];                  //Montre les possibilitées de mouvement
int Tabl_CartesEffetsPos[][] = new int [4][10];               //permet de faire les effets d'arrivées en jeu des cartes après un combat

void Init_Tabl_General() {
  for (int xTG = 0; xTG < 10; xTG++) {

    for (int yTG = 0; yTG < 4; yTG++) {

      Tabl_General[yTG][xTG] = 0;
    }
  }
}

void Init_Tabl_RougeBleu() {
  for (int xTR = 0; xTR < 10; xTR++) {

    for (int yTR = 0; yTR < 4; yTR++) {

      Tabl_RougeBleu[yTR][xTR] = 0;
    }
  }
}
