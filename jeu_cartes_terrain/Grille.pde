void Grille() {

  for (int XGrille = 0; XGrille<10; XGrille++) {

    for (int YGrille = 0; YGrille<4; YGrille++) {

      fill(0);

      if (XGrille == 0) fill ( 255, 0, 0);
      if (XGrille == 9) fill ( 0, 0, 255);

      strokeWeight (10);
      stroke(255);
      rect(XGrille*130+90, YGrille*170+50, 130, 170);


      if (Tabl_General[YGrille][XGrille] == 1) image(No_1, XGrille*130+90, YGrille*170+50, 130, 170); //1
      if (Tabl_General[YGrille][XGrille] == 2) image(No_2, XGrille*130+90, YGrille*170+50, 130, 170); //2
      if (Tabl_General[YGrille][XGrille] == 3) image(No_3, XGrille*130+90, YGrille*170+50, 130, 170); //3
      if (Tabl_General[YGrille][XGrille] == 4) image(No_4, XGrille*130+90, YGrille*170+50, 130, 170); //4
      if (Tabl_General[YGrille][XGrille] == 5) image(No_5, XGrille*130+90, YGrille*170+50, 130, 170); //5
      if (Tabl_General[YGrille][XGrille] == 6) image(No_6, XGrille*130+90, YGrille*170+50, 130, 170); //6
      if (Tabl_General[YGrille][XGrille] == 7) image(No_7, XGrille*130+90, YGrille*170+50, 130, 170); //7
      if (Tabl_General[YGrille][XGrille] == 8) image(No_8, XGrille*130+90, YGrille*170+50, 130, 170); //8
      if (Tabl_General[YGrille][XGrille] == 9) image(No_9, XGrille*130+90, YGrille*170+50, 130, 170); //9
      if (Tabl_General[YGrille][XGrille] == 10) image(No_10, XGrille*130+90, YGrille*170+50, 130, 170); //10
      if (Tabl_General[YGrille][XGrille] == 11) image(No_11, XGrille*130+90, YGrille*170+50, 130, 170); //11
      if (Tabl_General[YGrille][XGrille] == 12) image(No_12, XGrille*130+90, YGrille*170+50, 130, 170); //12
      if (Tabl_General[YGrille][XGrille] == 13) image(No_13, XGrille*130+90, YGrille*170+50, 130, 170); //13
      if (Tabl_PreSelection[YGrille][XGrille] == 1) image(Selection_Vert_1, XGrille*130+90, YGrille*170+50, 130, 170);
      if (Tabl_PreSelection[YGrille][XGrille] == 2) image(Selection_Bleu_2, XGrille*130+90, YGrille*170+50, 130, 170);
      if (Tabl_PreSelection[YGrille][XGrille] == 3) image(Selection_Rouge_3, XGrille*130+90, YGrille*170+50, 130, 170);
    }
  }
}
