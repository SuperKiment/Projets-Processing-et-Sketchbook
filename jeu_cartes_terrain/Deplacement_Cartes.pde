int NoCaseXTemp;
int NoCaseYTemp;
int Selec_CarteTemp;

boolean AvancerLaCarte;


void Deplacement_Cartes() {

  if (NoCaseX < 99 && NoCaseY < 99 && Tabl_General[NoCaseY][NoCaseX] != 0 && SelecCarteGrille == true && Tabl_GDejaJoue[NoCaseY][NoCaseX] != 2 && Tabl_PreSelection[NoCaseY][NoCaseX] == 0) {
    NoCaseXTemp = NoCaseX;
    NoCaseYTemp = NoCaseY;

    int ValTempRB = 1;

    if (Tour == 1) {
      ValTempRB = 1;
    }
    if (Tour == 2) {
      ValTempRB = -1;
    }
    if (Tabl_RougeBleu[NoCaseY][NoCaseX + ValTempRB] == 0) {                     //Deplacements basiques
      Tabl_PreSelection[NoCaseY][NoCaseX + ValTempRB] = 1;
    } else {
      if (Tabl_RougeBleu[NoCaseY][NoCaseX + ValTempRB] == Tour) {
        Tabl_PreSelection[NoCaseY][NoCaseX + ValTempRB] = 2;
      } else {
        if (Tabl_RougeBleu[NoCaseY][NoCaseX + ValTempRB] != Tour) {
          Tabl_PreSelection[NoCaseY][NoCaseX + ValTempRB] = 3;
        }
      }
    }


    if (NoCaseX != 99 && NoCaseX < 8 && Tabl_General[NoCaseY][NoCaseX] == 3 && Tour == 1) {         //Deplacements spéciaux pour le 3 Rouge
      if (Tabl_RougeBleu[NoCaseY][NoCaseX+2] == 1) {
        Tabl_PreSelection[NoCaseY][NoCaseX+2] = 2;                            //Permet de voir si on peut aider un allié
      } else {
        if (Tabl_RougeBleu[NoCaseY][NoCaseX+2] == 2) {
          Tabl_PreSelection[NoCaseY][NoCaseX+2] = 3;                          //Permet de voir si on peut attaquer un ennemi
        }
      }
    }


    if (NoCaseX != 99 && NoCaseX > 1 && Tabl_General[NoCaseY][NoCaseX] == 3 && Tour == 2) {         //Deplacements spéciaux pour le 3 Bleu
      if (Tabl_RougeBleu[NoCaseY][NoCaseX-2] == 2) {
        Tabl_PreSelection[NoCaseY][NoCaseX-2] = 2;                            //Permet de voir si on peut aider un allié
      } else {
        if (Tabl_RougeBleu[NoCaseY][NoCaseX-2] == 1) {
          Tabl_PreSelection[NoCaseY][NoCaseX-2] = 3;                          //Permet de voir si on peut attaquer un ennemi
        }
      }
    }

    if (Tabl_General[NoCaseYTemp][NoCaseXTemp] == 6) {
      if (NoCaseYTemp > 0) {
        if (Tabl_RougeBleu[NoCaseY-1][NoCaseX] == 0) {                         //Deplacements spéciaux pour le 6
          Tabl_PreSelection[NoCaseY-1][NoCaseX] = 1;
        } else {
          if (Tabl_RougeBleu[NoCaseY-1][NoCaseX] == Tour) {
            Tabl_PreSelection[NoCaseY-1][NoCaseX] = 2;
          }
          if (Tabl_RougeBleu[NoCaseY-1][NoCaseX] != Tour) {
            Tabl_PreSelection[NoCaseY-1][NoCaseX] = 3;
          }
        }
      }
      if (NoCaseYTemp < 3) {
        if (Tabl_RougeBleu[NoCaseY+1][NoCaseX] == 0) {   
          Tabl_PreSelection[NoCaseY+1][NoCaseX] = 1;
        } else {
          if (Tabl_RougeBleu[NoCaseY+1][NoCaseX] == Tour) {
            Tabl_PreSelection[NoCaseY+1][NoCaseX] = 2;
          }
          if (Tabl_RougeBleu[NoCaseY+1][NoCaseX] != Tour) {
            Tabl_PreSelection[NoCaseY+1][NoCaseX] = 3;
          }
        }
      }
    }

    AvancerLaCarte = true;
  }


  //********************************************************************************************************************************************************************************************************

  //Effets spéciaux d'arrivée en jeu

  if  (NoCaseX != 99 && NoCaseX < 7 && Tour == 1 && Tabl_General[NoCaseY][NoCaseX]== 1 && Tabl_RougeBleu[NoCaseY][NoCaseX] == Tour && Tabl_CartesEffetsPos[NoCaseY][NoCaseX] == 1) {
    if (Tabl_General[NoCaseY][NoCaseX + 3]== 0) {
      Tabl_General[NoCaseY][NoCaseX + 3] = 1;            //conditions pour la carte 1 pour le rouge
      Tabl_RougeBleu[NoCaseY][NoCaseX + 3] = 1;
    } else {
      if (Tabl_RougeBleu[NoCaseY][NoCaseX + 3]== 1) {
        Tabl_General[NoCaseY][NoCaseX + 3] = Tabl_General[NoCaseY][NoCaseX + 3] + 1;
        if (Tabl_General[NoCaseY][NoCaseX + 3] > 13) {
          Tabl_General[NoCaseY][NoCaseX + 3] = 13;
        }
      } else {
        if (Tabl_RougeBleu[NoCaseY][NoCaseX + 3]== 2) {
          if (Tabl_General[NoCaseY][NoCaseX + 3] == 1) {
            Tabl_General[NoCaseY][NoCaseX + 3] = 0;
            Tabl_RougeBleu[NoCaseY][NoCaseX + 3] = 0;
          }
          if (Tabl_General[NoCaseY][NoCaseX + 3] > 1) {
            Tabl_General[NoCaseY][NoCaseX + 3] = Tabl_General[NoCaseY][NoCaseX + 3] - 1;
          }
        }
      }
    }

    Tabl_General[NoCaseY][NoCaseX] = 0;
    Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
  }




  if  (NoCaseX != 99 && NoCaseX > 2 && Tour == 2 && Tabl_General[NoCaseY][NoCaseX]== 1 && Tabl_RougeBleu[NoCaseY][NoCaseX] == Tour && Tabl_CartesEffetsPos[NoCaseY][NoCaseX] == 1) {
    if (Tabl_General[NoCaseY][NoCaseX - 3]== 0) {
      Tabl_General[NoCaseY][NoCaseX - 3] = 1;           //conditions pour la carte 1 pour le bleu  
      Tabl_RougeBleu[NoCaseY][NoCaseX - 3] = 2;
    } else {
      if (Tabl_RougeBleu[NoCaseY][NoCaseX - 3]== 2) {
        Tabl_General[NoCaseY][NoCaseX - 3] = Tabl_General[NoCaseY][NoCaseX - 3] + 1;
        if (Tabl_General[NoCaseY][NoCaseX - 3] > 13) {
          Tabl_General[NoCaseY][NoCaseX - 3] = 13;
        }
      } else {
        if (Tabl_RougeBleu[NoCaseY][NoCaseX - 3]== 1) {
          if (Tabl_General[NoCaseY][NoCaseX - 3] == 1) {
            Tabl_General[NoCaseY][NoCaseX - 3] = 0;
            Tabl_RougeBleu[NoCaseY][NoCaseX - 3] = 0;
          }
          if (Tabl_General[NoCaseY][NoCaseX - 3] > 1) {
            Tabl_General[NoCaseY][NoCaseX - 3] = Tabl_General[NoCaseY][NoCaseX - 3] - 1;
          }
        }
      }
    }

    Tabl_General[NoCaseY][NoCaseX] = 0;
    Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
  }


  //************************************************************************************************************************************************************************************


  int XAvancementR = NoCaseX+1;                              //Effets spéciaux cartes 4 Rouge
  boolean XASup9 = false;

  if (NoCaseX < 9 && Tabl_General[NoCaseY][NoCaseX] == 4 && Tabl_RougeBleu[NoCaseY][NoCaseX] == 1 && Tabl_General[NoCaseY][NoCaseX+1] == 0 && Tabl_CartesEffetsPos[NoCaseY][NoCaseX] == 1) {
    while (Tabl_General[NoCaseY][XAvancementR] == 0 && XASup9 == false) {
      XAvancementR ++;
      if (XAvancementR > 9) {
        XASup9 = true;
        XAvancementR = NoCaseX + 2;
      }
    }
    Tabl_General[NoCaseY][NoCaseX] = 0;
    Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
    Tabl_General[NoCaseY][XAvancementR-2] = 4;
    Tabl_RougeBleu[NoCaseY][XAvancementR-2] = 1;
  }



  int XAvancementB = NoCaseX-1;                              //Effets spéciaux cartes 4 Bleu
  boolean XAInf0 = false;

  if (NoCaseX > 0 && NoCaseX < 99 && Tabl_General[NoCaseY][NoCaseX] == 4 && Tabl_RougeBleu[NoCaseY][NoCaseX] == 2 && Tabl_General[NoCaseY][NoCaseX-1] == 0 && Tabl_CartesEffetsPos[NoCaseY][NoCaseX] == 1) {
    while (Tabl_General[NoCaseY][XAvancementB] == 0 && XAInf0 == false) {
      XAvancementB --;
      if (XAvancementB < 0) {
        XAInf0 = true;
        XAvancementB = NoCaseX - 2;
      }
    }
    Tabl_General[NoCaseY][NoCaseX] = 0;
    Tabl_RougeBleu[NoCaseY][NoCaseX] = 0;
    Tabl_General[NoCaseY][XAvancementB+2] = 4;
    Tabl_RougeBleu[NoCaseY][XAvancementB+2] = 2;
  }
}
