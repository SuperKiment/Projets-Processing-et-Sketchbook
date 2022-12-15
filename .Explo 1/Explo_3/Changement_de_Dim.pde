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
