float yRaqu1       ;
float yRaqu2       ;
float xBalle1      ;
float yBalle1      ;
float xBalle2      ;
float yBalle2      ;
float tailleBalle1 ;
float tailleBalle2 ;
float tailleRaqu1  ;
float tailleRaqu2  ;
int scoreG         ;
int scoreD         ;

void Affichage() {


  if (dataIn != null) {
    xBalle1 =      DataIn[0];
    yBalle1 =      DataIn[1];
    xBalle2 =      DataIn[2];
    yBalle2 =      DataIn[3];
    tailleBalle1 = DataIn[4];
    tailleBalle2 = DataIn[5];
    yRaqu1 =       DataIn[6];
    yRaqu2 =       DataIn[7];
    tailleRaqu1 =  DataIn[8];
    tailleRaqu2 =  DataIn[9];
    scoreG =   int(DataIn[10]);
    scoreD =   int(DataIn[11]);
  }

  fill(255);
  noStroke();
  ellipse(xBalle1, yBalle1, tailleBalle1, tailleBalle1);
  ellipse(xBalle2, yBalle2, tailleBalle2, tailleBalle2);   //Balles

  fill(0, 0, 255);
  stroke(255);
  strokeWeight(3);
  rect(20, yRaqu1, 30, tailleRaqu1);
  fill(255, 0, 0);
  rect(1500-20-30, yRaqu2, 30, tailleRaqu2);

  fill(255);
  textSize(50);
  text(scoreG, width/4, 400);
  text(scoreD, width*3/4, 400);
}
