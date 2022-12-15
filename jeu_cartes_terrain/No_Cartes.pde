int NoCartesX = 0;
int NoCartesY = 0;
float MouseXCartes = mouseX-57;


void Numero_Cartes () { 
  if (mouseY <= 860 || mouseY >= 1030) {
    NoCartesY = 0;
  } else { 
    NoCartesY = 1;
  }
  if (mouseX >= 187 && mouseX <= 241 || mouseX >= 371 && mouseX <= 425 || mouseX >= 555 && mouseX <= 609 
    || mouseX >= 739 && mouseX <= 793 || mouseX >= 923 && mouseX <= 977
    || mouseX >= 1107 && mouseX <= 1161 || mouseX >= 1291 && mouseX <= 1345 
    || mouseX >= 1475 && mouseX <= 1529 || mouseX >= 1659 && mouseX <= 1713 || mouseX >= 1843 || NoCartesY == 0) {
    NoCartesX = 0;
  } else {
    NoCartesX = int ((MouseXCartes/1843+0.1)*10);
  }
}


int Selec_Cartes_T_R;   //Variables qui prennent les valeurs des cartes si on est dessus
int Selec_Cartes_T_B;
int Selec_Carte;

void Selection_Cartes() {
  if (NoCartesX != 0) {                                //Permet de prendre la valeur de la carte dans une variable temporairement
    Selec_Cartes_T_B = Tabl_Cartes_J_B[NoCartesX];
    Selec_Cartes_T_R = Tabl_Cartes_J_R[NoCartesX];
    
    
  } else {Selec_Cartes_T_B = 0; Selec_Cartes_T_R = 0;}
}
