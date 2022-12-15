boolean SelecCarteGrille;
boolean DejaCliqueTableau;
int T_MouvInfini;


void Prendre_et_Poser() {

  for (int x = 0; x<13; x++) {
    if (Tour == 1 && DejaClique == false && SelecCarteGrille == false) {            //Prendre la carte de la main     pour Rouge
      if (NoCartesY == 1 && NoCartesX != 0) {
        if (Selec_Cartes_T_R == x+1 && Tabl_Rouge_DejaJoue[x] == 0) {  
          Selec_Carte = Selec_Cartes_T_R;
          Tabl_Cartes_J_R[NoCartesX] = 0;                   
          DejaClique = true;
          DejaPasse = true;
        }
      }
    }
  }
  for (int x = 0; x<13; x++) {
    if (Tour == 2 && DejaClique == false && SelecCarteGrille == false) {            //Prendre la carte de la main     pour Bleu
      if (NoCartesY == 1 && NoCartesX != 0) {
        if (Selec_Cartes_T_B == x+1 && Tabl_Bleu_DejaJoue[x] == 0) {  
          Selec_Carte = Selec_Cartes_T_B;
          Tabl_Cartes_J_B[NoCartesX] = 0;                   
          DejaClique = true;
          DejaPasse = true;
        }
      }
    }
  }

  //*****************************************************************************************************************************************************************************************************


  for (int x= 1; x<=10; x++) {
    if ((Selec_Carte !=0) && (Tabl_Cartes_J_R[x] == 0) && (Tour == 1) && (NoCartesY == 1) && (NoCartesX == x) && (DejaClique == true) && (DejaPasse == false) ) {
      Tabl_Cartes_J_R[x] = Selec_Carte;
      Selec_Cartes_T_R = Selec_Carte;                   //Reposer la carte  ROUGE dans la main
      Selec_Carte=0;
      DejaClique = false;
      DejaPasse = true;
    }
  }
  for (int x= 1; x<=10; x++) {
    if ((Selec_Carte !=0) && (Tabl_Cartes_J_B[x] == 0) && (Tour == 2) && (NoCartesY == 1) && (NoCartesX == x) && (DejaClique == true) && (DejaPasse == false) ) {
      Tabl_Cartes_J_B[x] = Selec_Carte;
      Selec_Cartes_T_B = Selec_Carte;                   //Reposer la carte  BLEU dans la main
      Selec_Carte=0;
      DejaClique = false;
      DejaPasse = true;
    }
  }

  //*****************************************************************************************************************************************************************************************************

  if (NoCaseX < 99 && NoCaseY < 99 && NoCaseX < 9 && Tabl_General[NoCaseY][NoCaseX] != 0 && Tour == 1 && Tabl_RougeBleu[NoCaseY][NoCaseX] == 1 && (DejaPasse == false) && (DejaCliqueTableau == false) && Tabl_GDejaJoue[NoCaseY][NoCaseX] != 2) {
    SelecCarteGrille = true;
    Selec_CarteTemp = Tabl_General[NoCaseY][NoCaseX];                         //Permet de sélectionner une carte dans la Grille pour le Rouge
    DejaCliqueTableau = true;
    DejaPasse = true;
  }
  if (NoCaseX < 99 && NoCaseY < 99 && NoCaseX > 0 && Tabl_General[NoCaseY][NoCaseX] != 0 && Tour == 2 && Tabl_RougeBleu[NoCaseY][NoCaseX] == 2 && (DejaPasse == false) && (DejaCliqueTableau == false)  && Tabl_GDejaJoue[NoCaseY][NoCaseX] != 2) {
    SelecCarteGrille = true;
    Selec_CarteTemp = Tabl_General[NoCaseY][NoCaseX];                                   //Permet de sélectionner une carte dans la Grille pour le Bleu
    DejaCliqueTableau = true;
    DejaPasse = true;
  }

  //*****************************************************************************************************************************************************************************************************

  if (AvancerLaCarte == true && Tour == 1 && NoCaseX != 99) {
    if (Tabl_RougeBleu[NoCaseY][NoCaseX] == 2 && Tabl_PreSelection[NoCaseY][NoCaseX] == 3) {
      Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
      if (Selec_CarteTemp > Tabl_General[NoCaseY][NoCaseX]) {
        Tabl_General[NoCaseY][NoCaseX] = Selec_CarteTemp - Tabl_General[NoCaseY][NoCaseX];               //permet de combattre une carte ennemie pour le rouge
        Tabl_RougeBleu[NoCaseY][NoCaseX] = 1;
        Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
      } else {
        if (Selec_CarteTemp < Tabl_General[NoCaseY][NoCaseX]) {
          Tabl_General[NoCaseY][NoCaseX] = Tabl_General[NoCaseY][NoCaseX] - Selec_CarteTemp;
        } else {
          if (Selec_CarteTemp == Tabl_General[NoCaseY][NoCaseX]) {
            Tabl_General[NoCaseY][NoCaseX] = 0;
            Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
          }
        }
      }
      Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
      Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;

      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    } else 

    if (Tabl_RougeBleu[NoCaseY][NoCaseX] == 1 && Tabl_PreSelection[NoCaseY][NoCaseX] == 2) {
      Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
      Tabl_General[NoCaseY][NoCaseX] = Tabl_General[NoCaseY][NoCaseX] + Selec_CarteTemp;               //permet d'additionner deux cartes alliées pour le rouge
      if (Tabl_General[NoCaseY][NoCaseX] >13) {
        Tabl_General[NoCaseY][NoCaseX] = 13;
      }
      Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
      Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
      Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;

      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    } else { 
      if (Tabl_PreSelection[NoCaseY][NoCaseX] == 1) {

        Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
        Tabl_General[NoCaseY][NoCaseX] = Selec_CarteTemp;
        Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
        Tabl_RougeBleu[NoCaseY][NoCaseX] = 1;                                     //Fait avancer les cartes posées Rouge
        Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;
        if (Tabl_General[NoCaseY][NoCaseX] != 5) {
          Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
        }
        if (Tabl_General[NoCaseY][NoCaseX] == 5 && Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] < 2) {
          Tabl_GDejaJoue[NoCaseY][NoCaseX] = Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] + 1;
          Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] = 0;
        }
      }
    }


    Selec_CarteTemp = 0;
    NoCaseYTemp = 0; 
    NoCaseXTemp = 0;
    AvancerLaCarte = false;
    SelecCarteGrille = false;
  }
  if (AvancerLaCarte == true && Tour == 2 && NoCaseX != 99) {
    if (Tabl_RougeBleu[NoCaseY][NoCaseX] == 1 && Tabl_PreSelection[NoCaseY][NoCaseX] == 3) {
      Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
      if (Selec_CarteTemp > Tabl_General[NoCaseY][NoCaseX]) {
        Tabl_General[NoCaseY][NoCaseX] = Selec_CarteTemp - Tabl_General[NoCaseY][NoCaseX];               //permet de combattre une carte ennemie pour le bleu
        Tabl_RougeBleu[NoCaseY][NoCaseX] = 2;
        Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
      } else {
        if (Selec_CarteTemp < Tabl_General[NoCaseY][NoCaseX]) {
          Tabl_General[NoCaseY][NoCaseX] = Tabl_General[NoCaseY][NoCaseX] - Selec_CarteTemp;
        } else {
          if (Selec_CarteTemp == Tabl_General[NoCaseY][NoCaseX]) {
            Tabl_General[NoCaseY][NoCaseX] = 0;
            Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
          }
        }
      }
      Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
      Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;

      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    } else 
    if (Tabl_RougeBleu[NoCaseY][NoCaseX] == 2 && Tabl_PreSelection[NoCaseY][NoCaseX] == 2) {
      Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
      Tabl_General[NoCaseY][NoCaseX] = Tabl_General[NoCaseY][NoCaseX] + Selec_CarteTemp;                //permet d'additionner deux cartes alliées pour le bleu
      if (Tabl_General[NoCaseY][NoCaseX] > 13) {
        Tabl_General[NoCaseY][NoCaseX] = 13;
      }
      Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
      Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
      Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;

      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    } else { 
      if (Tabl_PreSelection[NoCaseY][NoCaseX] == 1) {
        Tabl_PreSelection[NoCaseY][NoCaseX] = 0;
        Tabl_General[NoCaseY][NoCaseX] = Selec_CarteTemp;
        Tabl_General[NoCaseYTemp][NoCaseXTemp] = 0;
        Tabl_RougeBleu[NoCaseY][NoCaseX] = 2;                                     //Fait avancer les cartes posées Bleu
        Tabl_RougeBleu[NoCaseYTemp][NoCaseXTemp] = 0;
        if (Tabl_General[NoCaseY][NoCaseX] != 5) {
          Tabl_GDejaJoue[NoCaseY][NoCaseX] = 2;
        }
        if (Tabl_General[NoCaseY][NoCaseX] == 5 && Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] < 2) {
          Tabl_GDejaJoue[NoCaseY][NoCaseX] = Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] + 1;
          Tabl_GDejaJoue[NoCaseYTemp][NoCaseXTemp] = 0;
        }
      }
    }
    Selec_CarteTemp = 0;
    NoCaseYTemp = 0; 
    NoCaseXTemp = 0;
    AvancerLaCarte = false;
    SelecCarteGrille = false;
  }

  //*****************************************************************************************************************************************************************************************************

  if (NoCaseX != 99 && Tabl_PreSelection[NoCaseY][NoCaseX] == 0 && DejaPasse == false && DejaCliqueTableau == true) {
    for (int XGrille = 0; XGrille<10; XGrille++) {
      for (int YGrille = 0; YGrille<4; YGrille++) {
        Tabl_PreSelection[YGrille][XGrille] = 0;
        SelecCarteGrille = false;
        DejaCliqueTableau = false;                            //Deselectionne les cartes sélectionnées dans la grille si on click sur la grille
        AvancerLaCarte = false;
        DejaPasse = true;
      }
    }
  }
  if (NoCaseX == 99 && (DejaPasse == false) && (DejaCliqueTableau == true) ) {
    for (int XGrille = 0; XGrille<10; XGrille++) {
      for (int YGrille = 0; YGrille<4; YGrille++) {
        Tabl_PreSelection[YGrille][XGrille] = 0;
        SelecCarteGrille = false;
        DejaCliqueTableau = false;                            //Deselectionne les cartes sélectionnées dans la grille si on click en dehors du jeu
        AvancerLaCarte = false;
        DejaPasse = true;
      }
    }
  }

  //******************************************************************************************************************************************************************************************************

  if (T_MouvInfini == 1) {
    for (int XGrille = 0; XGrille<10; XGrille++) {
      for (int YGrille = 0; YGrille<4; YGrille++) {
        Tabl_GDejaJoue[YGrille][XGrille] = 0;
      }
    }
  }


  DejaPasse = false;
}



void Poser_les_cartes_sur_le_Terrain() {

  for (int x = 0; x < 4; x++) {
    if ((Tour == 1) && (NoCaseX == 0) && (NoCaseY == x) && (Selec_Carte !=0) && ((ComptNbPerso + Selec_Carte)<=13) && (Tabl_General[x][0] == 0)) {
      Tabl_General[x][0] = Selec_Carte; 
      Tabl_RougeBleu[x][0] = 1;
      for (int xDejaJoue = 0; xDejaJoue< 13; xDejaJoue++) {
        if (Selec_Carte == xDejaJoue + 1) {
          Tabl_Rouge_DejaJoue[xDejaJoue] = 1;
        }
      }
      ComptNbPerso = ComptNbPerso + Selec_Carte;     //Poser la carte sur le jeu             Rouge
      Selec_Carte = 0;
      DejaClique = false;
      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    }
  }

  for (int x = 0; x < 4; x++) {
    if ((Tour == 2) && (NoCaseX == 9) && (NoCaseY == x) && (Selec_Carte !=0) && ((ComptNbPerso + Selec_Carte)<=13) && (Tabl_General[x][9] == 0)) {
      Tabl_General[x][9] = Selec_Carte; 
      Tabl_RougeBleu[x][9] = 2;
      for (int xDejaJoue = 0; xDejaJoue< 13; xDejaJoue++) {
        if (Selec_Carte == xDejaJoue + 1) {
          Tabl_Bleu_DejaJoue[xDejaJoue] = 1;
        }
      }
      ComptNbPerso = ComptNbPerso + Selec_Carte;     //Poser la carte sur le jeu          Bleu
      Selec_Carte = 0;
      DejaClique = false;
      Tabl_CartesEffetsPos[NoCaseY][NoCaseX] = 1;
    }
  }
}
