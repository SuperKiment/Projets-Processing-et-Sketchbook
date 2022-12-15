String fichier = "map.txt";
String[] lines;
String linesZero;


void GrilleRecup() {        //Load la map

  lines = loadStrings(fichier);     //Fichier dans lines
  linesZero = lines[0];               //linesZero est la 1ere ligne de lines
  println(linesZero.length()/2);               //Print la taille du doc X
  println(lines.length);                       //Print la taille du doc Y     

  nbCasesX = linesZero.length()/2; //Rentre les tailles du doc dans le programme
  nbCasesY = lines.length;



  println("map.txt :");
  
  for (int i = 0; i < lines.length; i++) {  //Affiche dans la console le map.txt
    println(lines[i]);
  }
  println("there are " + lines.length + " lines");
  println("Lu !  :  " + int(random(0, 500)));



  for (int y = 0; y<nbCasesY; y++) {
    String[] ligneSimple = split(lines[y], " ");         //Split la ligne y dans ligneSimple pour passer par toutes les cases individuellement

    for (int x = 0; x<nbCasesX; x++) {

      //println(ligneSimple[x]);

      if (int(ligneSimple[x]) == 0) Grille[x][y] = herbe;
      if (int(ligneSimple[x]) == 1) Grille[x][y] = terre;
      if (int(ligneSimple[x]) == 2) Grille[x][y] = roche;       //Change les cases par rapport à map.txt
      if (int(ligneSimple[x]) == 3) Grille[x][y] = arbre;
      if (int(ligneSimple[x]) == 4) Grille[x][y] = eau;
    }
  }
}

void GrilleSave() {

  String ajouter[] = new String[nbCasesX];         //Tableau de ligneX-s
  String ligneX = "10000000200000000003";           //Valeur par défaut

  for (int y = 0; y<nbCasesY; y++) {
    ligneX = "";                        //Reset de ligneX
    for (int x = 0; x<nbCasesX; x++) {


      if (Grille[x][y] == "herbe") ligneX += "0 "; 
      if (Grille[x][y] == "terre") ligneX += "1 ";     //Passe par toutes les cases et les ajoute en chaine dans ligneX
      if (Grille[x][y] == "roche") ligneX += "2 ";
      if (Grille[x][y] == "arbre") ligneX += "3 ";
      if (Grille[x][y] == "eau") ligneX += "4 ";
    }

    ajouter[y] = ligneX;   //Ajoute ligneX à la case suivante de ajouter
    ligneX = "";           //Reset au cas où
  }


  saveStrings(fichier, ajouter);        //remplacement de map.txt par ajouter

  String[] lines = loadStrings(fichier);     //recupere le fichier remplacé

  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);                                  //Affiche dans la console le fichier remplcé pour verif
  }

  println("there are " + lines.length + " lines");
  println("Sauvegardé !  :  " + int(random(0, 500)));
}
