void Interface() {
  push();
  rectMode(CENTER);
  fill(pointeurDev.couleurPointeur);
  rect(width/2, height*7/8, 100, 20);
  fill(0);                               //Couleur du pointeur
  rect(0, 0, 100, 50);
  fill(255);
  text(joueur.arme.armeEquipee, 0, 20);
  pop();

  inventaire.Fonctions();              //Inventaire
}

Inventaire inventaire = new Inventaire();

class Inventaire {

  int xScreen, yScreen;
  String[] Cases = new String[9];
  int tailleCase = 40, noCase;

  Inventaire() {

    for (int i = 0; i < Cases.length; i++) {
      Cases[i] = "";          //Remplit de rien l'inventaire entier
    }                         //Pour éviter les null pointer

    Cases[0] = "Pant";
    Cases[1] = "Bloc";
    Cases[2] = "Pant IN";       //Remplit l'inventaire
    Cases[3] = "Bloc IN";
  }

  void Affichage() {
    xScreen = width/2;
    yScreen = height*15/16; //Position de l'inventaire

    push();
    fill(50, 50, 50, 125);
    rectMode(CENTER);
    strokeWeight(2);                        //Support de cases
    for (int i = 0; i<Cases.length; i++) { 
      rect(xScreen+(tailleCase*(i-Cases.length/2)), yScreen, tailleCase, tailleCase);
    }

    strokeWeight(4);
    stroke(125);                            //Selecteur d'inventaire 
    rect(xScreen+(tailleCase*(noCase-Cases.length/2)), yScreen, tailleCase, tailleCase);

    fill(255);
    textSize(10);                           //Remplit les cases d'inventaire
    for (int i = 0; i<Cases.length; i++) {
      text(Cases[i], xScreen+(tailleCase*(i-Cases.length/2))-17, yScreen);
    }
    pop();
  }

  void ChangerCase() {
    switch (key) {
    case '&' :
      noCase = 0;
      break;
    case 'é' :
      noCase = 1;
      break;
    case '"' :
      noCase = 2;
      break;
    case '\'' :
      noCase = 3;     //   &é"'(-è_çà
      break;
    case '(' :
      noCase = 4;
      break;
    case '-' :
      noCase = 5;
      break;
    case 'è' :
      noCase = 6;
      break;
    case '_' :
      noCase = 7;
      break;
    case 'ç' :
      noCase = 8;
      break;
    }
  }

  void PoseObjet() {
    switch(Cases[noCase]) {   //En fonction de l'objet d'inventaire, pose l'objet :
    case "Pant":
      AjouterPantin(ConvPixelGrille(pointeurDev.x), ConvPixelGrille(pointeurDev.y), 100);      
      break;
    case "Pant IN":
      AjouterPantinIndest(ConvPixelGrille(pointeurDev.x), ConvPixelGrille(pointeurDev.y));      
      break;
    case "Bloc":
      AjouterBloc(pointeurDev.posx, pointeurDev.posy, int(random(1, 1000)));      
      break;
    case "Bloc IN":
      AjouterBlocIndest(pointeurDev.posx, pointeurDev.posy);      
      break;
    }
  }

  void Fonctions() {
    Affichage();
  }
}
