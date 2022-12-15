int dimensionActive = 0;

class Terrain {

  int x, y;
  String terre, herbe, roche;
  String[][] Grille;
  int compteurGrille = 0;
  int noDim;
  int distAffichage = 20;

  Terrain(int nnodim) {
    noDim = nnodim;
  }

  void InitGrille(int newx, int newy) {
    x = newx;
    y = newy;
    Grille = new String [newx][newy];

    for (int x1 = 0; x1<x; x1++) {
      for (int y1 = 0; y1 < y; y1++) {
        Grille[x1][y1] = "herbe";
        //println("herbe");

        //compteurGrille++;
        //println(compteurGrille);
      }
    }
  }

  void Affichage() { 
    for (int x1 = joueur1.x-distAffichage; x1 < joueur1.x+distAffichage; x1++) {
      for (int y1 = joueur1.y-distAffichage; y1 < joueur1.y+distAffichage; y1++) {
        push();

        fill(125);
        TranslateArPl();  

        if (x1 >=0 && y1 >=0 && x1 < x && y1 < y) {

          try {

            switch(Grille[x1][y1]) {
            case "herbe":
              image(imHerbe, x1*50, y1*50);
              break;
            case "sol":
              image(imSol, x1*50, y1*50);
              break;
            case "roche":
              image(imRoche, x1*50, y1*50);
              //Bam3D(x1, y1);
              break;
            case "arbre":
              image(imArbre, x1*50, y1*50);
              break;
            case "eau":
              image(imEau, x1*50, y1*50);
              break;
            }
          }
          catch(Exception e) {
            switch(Grille[x1][y1]) {
            case "herbe":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "sol":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "roche":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "arbre":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "eau":
              rect(x1*50, y1*50, 50, 50);
              break;
            }
          }
        }
        pop();
      }
    }
  }
}

//---------------------------------------------------------------------------------

Terrain DimensionActuelle() {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  return dimension;
}

String[][] GrilleDimensionActuelle() {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  return dimension.Grille;
}

float ValDimensionActuelle(String val) {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  switch (val) {
  case "x" :
    return dimension.x;

  case "y" :
    return dimension.y;
  }

  return 0;
}

void DimensionsAffichage() {
  switch (dimensionActive) {
  case 0 :
    Dim0.Affichage();
    break;

  case 1 :
    Dim1.Affichage();
    break;
  }
}

void ChangementDim(int dimension) {

  joueur1.ResetPos();

  switch (dimension) {

  case 0 :
    dimensionActive = 0;
    break;

  case 1 :
    dimensionActive = 1;
    break;

  case 2 :
    dimensionActive = 2;
    break;

  case 3 :
    dimensionActive = 3;
    break;
  }
}
