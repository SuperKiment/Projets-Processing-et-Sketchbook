String fichier = "map.txt";
String[] lines;
String linesZero;

void GrilleRecup() {        //Load la map

  lines = loadStrings(fichier);     //Fichier dans lines
  linesZero = lines[0];               //linesZero est la 1ere ligne de lines
  println(linesZero.length()/2);               //Print la taille du doc X
  println(lines.length);                       //Print la taille du doc Y     

  Dim0.x = linesZero.length()/2; //Rentre les tailles du doc dans le programme
  Dim0.y = lines.length;



  println("map.txt :");

  for (int i = 0; i < lines.length; i++) {  //Affiche dans la console le map.txt
    println(lines[i]);
  }
  println("there are " + lines.length + " lines");
  println("Lu !  :  " + int(random(0, 500)));



  for (int y = 0; y<Dim0.y; y++) {
    String[] ligneSimple = split(lines[y], " ");         //Split la ligne y dans ligneSimple pour passer par toutes les cases individuellement

    for (int x = 0; x<Dim0.x; x++) {

      //println(ligneSimple[x]);
      /*
      if (int(ligneSimple[x]) == 0) Grille[x][y] = herbe;
       if (int(ligneSimple[x]) == 1) Grille[x][y] = terre;
       if (int(ligneSimple[x]) == 2) Grille[x][y] = roche;       //Change les cases par rapport à map.txt
       if (int(ligneSimple[x]) == 3) Grille[x][y] = arbre;
       if (int(ligneSimple[x]) == 4) Grille[x][y] = eau;
       }*/
    }
  }
}
