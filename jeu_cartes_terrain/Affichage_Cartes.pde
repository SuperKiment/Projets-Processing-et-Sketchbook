void Affichage_Cartes() {
  for (int i = 0; i<=10; i++) {  

    if (Tour == 2) {
      if (Tabl_Cartes_J_B[i] == 1) image(No_1, (i-1)*184+57, 860, 130, 170); //1
      if (Tabl_Cartes_J_B[i] == 2) image(No_2, (i-1)*184+57, 860, 130, 170); //2
      if (Tabl_Cartes_J_B[i] == 3) image(No_3, (i-1)*184+57, 860, 130, 170); //3
      if (Tabl_Cartes_J_B[i] == 4) image(No_4, (i-1)*184+57, 860, 130, 170); //4
      if (Tabl_Cartes_J_B[i] == 5) image(No_5, (i-1)*184+57, 860, 130, 170); //5
      if (Tabl_Cartes_J_B[i] == 6) image(No_6, (i-1)*184+57, 860, 130, 170); //6
      if (Tabl_Cartes_J_B[i] == 7) image(No_7, (i-1)*184+57, 860, 130, 170); //7
      if (Tabl_Cartes_J_B[i] == 8) image(No_8, (i-1)*184+57, 860, 130, 170); //8
      if (Tabl_Cartes_J_B[i] == 9) image(No_9, (i-1)*184+57, 860, 130, 170); //9
      if (Tabl_Cartes_J_B[i] == 10) image(No_10, (i-1)*184+57, 860, 130, 170); //10
      if (Tabl_Cartes_J_B[i] == 11) image(No_11, (i-1)*184+57, 860, 130, 170); //11
      if (Tabl_Cartes_J_B[i] == 12) image(No_12, (i-1)*184+57, 860, 130, 170); //12
      if (Tabl_Cartes_J_B[i] == 13) image(No_13, (i-1)*184+57, 860, 130, 170); //13
    }


    if (Tour == 1) {
      if (Tabl_Cartes_J_R[i] == 1) image(No_1, (i-1)*184+57, 860, 130, 170); //1
      if (Tabl_Cartes_J_R[i] == 2) image(No_2, (i-1)*184+57, 860, 130, 170); //2
      if (Tabl_Cartes_J_R[i] == 3) image(No_3, (i-1)*184+57, 860, 130, 170); //3
      if (Tabl_Cartes_J_R[i] == 4) image(No_4, (i-1)*184+57, 860, 130, 170); //4
      if (Tabl_Cartes_J_R[i] == 5) image(No_5, (i-1)*184+57, 860, 130, 170); //5
      if (Tabl_Cartes_J_R[i] == 6) image(No_6, (i-1)*184+57, 860, 130, 170); //6
      if (Tabl_Cartes_J_R[i] == 7) image(No_7, (i-1)*184+57, 860, 130, 170); //7
      if (Tabl_Cartes_J_R[i] == 8) image(No_8, (i-1)*184+57, 860, 130, 170); //8
      if (Tabl_Cartes_J_R[i] == 9) image(No_9, (i-1)*184+57, 860, 130, 170); //9
      if (Tabl_Cartes_J_R[i] == 10) image(No_10, (i-1)*184+57, 860, 130, 170); //10
      if (Tabl_Cartes_J_R[i] == 11) image(No_11, (i-1)*184+57, 860, 130, 170); //11
      if (Tabl_Cartes_J_R[i] == 12) image(No_12, (i-1)*184+57, 860, 130, 170); //12
      if (Tabl_Cartes_J_R[i] == 13) image(No_13, (i-1)*184+57, 860, 130, 170); //13
    }
  }
}




void Emplacement_Cartes() {
  for (int DeplX = 0; DeplX<10; DeplX = DeplX +1) {

    strokeWeight(10);
    fill(0);
    stroke(255);
    rect(DeplX*184+57, 860, 130, 170);         //DeplX*184+57 = début de chaque emplacement de carte
  }
}
