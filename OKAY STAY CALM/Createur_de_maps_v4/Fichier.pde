String fichier = "map.txt";
String[] lines;
String linesZero;


void GrilleRecup() {

  lines = loadStrings(fichier);
  linesZero = lines[0];
  println(linesZero.length()/2);
  println(lines.length);

  nbCasesX = linesZero.length()/2;
  nbCasesY = lines.length;



  println("map.txt :");
  for (int i = 0; i < lines.length; i++) {  //Affiche dans la console le map.txt
    println(lines[i]);
  }
  println("there are " + lines.length + " lines");
  println("Lu !  :  " + int(random(0, 500)));



  for (int y = 0; y<nbCasesY; y++) {
    String[] ligneSimple = split(lines[y], " ");

    for (int x = 0; x<nbCasesX; x++) {

      //println(ligneSimple[x]);

      if (int(ligneSimple[x]) == 0) Grille[x][y] = herbe;
      if (int(ligneSimple[x]) == 1) Grille[x][y] = terre;
      if (int(ligneSimple[x]) == 2) Grille[x][y] = roche;
      if (int(ligneSimple[x]) == 3) Grille[x][y] = arbre;
      if (int(ligneSimple[x]) == 4) Grille[x][y] = eau;
    }
  }
}

void GrilleSave() {

  String ajouter[] = new String[nbCasesX];
  String ligneX = "10000000200000000003";

  for (int y = 0; y<nbCasesY; y++) {
    ligneX = "";
    for (int x = 0; x<nbCasesX; x++) {


      if (Grille[x][y] == "herbe") ligneX += "0 "; 
      if (Grille[x][y] == "terre") ligneX += "1 ";
      if (Grille[x][y] == "roche") ligneX += "2 ";
      if (Grille[x][y] == "arbre") ligneX += "3 ";
      if (Grille[x][y] == "eau") ligneX += "4 ";
    }

    ajouter[y] = ligneX;
    ligneX = "";
  }


  saveStrings(fichier, ajouter);

  String[] lines = loadStrings(fichier);

  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
  }

  println("there are " + lines.length + " lines");
  println("Sauvegardé !  :  " + int(random(0, 500)));
}
