String fichier = "map.txt";


void GrilleRecup() {

  String[] lines = loadStrings(fichier);

  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
  }

  println("there are " + lines.length + " lines");
}

void GrilleSave() {

  String ajouter[] = new String[20];
  String ligneX = "00000000000000000000";
  /*
  for (int y = 0; y<nbCasesY; y++) {
   for (int x = 0; x<nbCasesX; x++) {
   
   if (Grille[x][y] == "herbe") ligneX += 0; 
   if (Grille[x][y] == "terre") ligneX += 1; 
   
   
   }
   
   ajouter[y] = ligneX;
   }
   */
  saveStrings(fichier, ajouter);

  String[] lines = loadStrings(fichier);

  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
  }

  println("there are " + lines.length + " lines");
}
