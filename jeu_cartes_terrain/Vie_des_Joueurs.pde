int Vie_B = 40;
int Vie_R = 40;

void Vie_Des_Joueurs() {

  stroke(200, 0, 0);
  fill(255, 0, 0);                //Affiche un carré rouge pour le Joueur Rouge
  rect(1550, 525, 150, 75);

  fill(0, 0, 255);
  stroke(0, 0, 200);              //Affiche un carré bleu pour le Joueur Bleu
  rect(1700, 525, 150, 75);


  fill(0);
  textSize(45);
  text(String.valueOf(Vie_R) + " HP", 1560, 575);
  text(String.valueOf(Vie_B) + " HP", 1710, 575);           //Affiche les vies des joueurs

  stroke(0);
  line(1500, 500, 1920, 500);    //Fait une ligne au dessus

  //******************************************************************************************************************************************************************************************************

  for (int i = 0; i<=3; i++) {
    if (Tabl_RougeBleu[i][0] == 2) {
      Vie_R = Vie_R - Tabl_General[i][0];
      Tabl_General[i][0] = 0;
      Tabl_RougeBleu[i][0] = 0;
    }
  }
  for (int i = 0; i<=3; i++) {
    if (Tabl_RougeBleu[i][9] == 1) {
      Vie_B = Vie_B - Tabl_General[i][9];
      Tabl_General[i][9] = 0;
      Tabl_RougeBleu[i][9] = 0;
    }
  }
}
