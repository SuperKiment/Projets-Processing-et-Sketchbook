void Debug() {
  if (Debug_actif == true) {
    fill (0, 0, 0, 50);
    noStroke();
    rect(1550, 50, 300, 800);
    fill (0, 255, 0);
    textSize(50);
    text(String.valueOf(mouseX)+" "+String.valueOf(mouseY), 1600, 100);
    text("Case " + String.valueOf(NoCaseX)+" "+String.valueOf(NoCaseY), 1560, 150);
    text("Emp " + String.valueOf(NoCartesX)+" "+String.valueOf(NoCartesY), 1600, 200);
    text("B:" + String.valueOf(Selec_Cartes_T_B)+", R:"+String.valueOf(Selec_Cartes_T_R), 1600, 250);
    text(String.valueOf(Selec_Carte), 1600, 300);
    text(String.valueOf(Selec_CarteTemp), 1700, 300);
    text(String.valueOf(Tour), 1600, 350);
    if (NoCaseX!=99) {
      text(String.valueOf(Tabl_General[NoCaseY][NoCaseX]), 1600, 400);
    }
    if (NoCaseX!=99) {
      text(String.valueOf(Tabl_RougeBleu[NoCaseY][NoCaseX]), 1700, 400);
    }
    if (NoCaseX!=99) {
      text(String.valueOf(Tabl_PreSelection[NoCaseY][NoCaseX]), 1600, 450);
    }
    if (NoCaseX!=99) {
      text(String.valueOf(Tabl_GDejaJoue[NoCaseY][NoCaseX]), 1700, 450);
    }
    if (NoCaseX!=99) {
      text(String.valueOf(Tabl_CartesEffetsPos[NoCaseY][NoCaseX]), 1600, 500);
    }
    text(String.valueOf(Tabl_Cartes_J_R[NoCartesX]), 1600, 600);
    text(String.valueOf(ComptNbPerso), 1600, 650);
    text(String.valueOf(CompteTour), 1600, 700);
    text(String.valueOf(NoCaseXTemp), 1600, 750);
    text(String.valueOf(NoCaseYTemp), 1700, 750);


    if (SelecCarteGrille == true) text("CarteGrille Vrai", 1500, 850);
    if (SelecCarteGrille == false) text("CarteGrille Faux", 1500, 850);
    if (DejaClique == true) text("DejaCliqué Vrai", 1500, 800);
    if (DejaClique == false) text("DejaCliqué Faux", 1500, 800);
  }
}
