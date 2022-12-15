MapDimension mapDim0 = new MapDimension("Plan_Dimension0.txt", Dim0);
MapDimension mapDim1 = new MapDimension("Plan_Dimension1.txt", Dim1);

class MapDimension {

  MapDimension(String newdimension, Terrain newdimensionBase) {
    dimension = newdimension;
    dimensionBase = newdimensionBase;
  }


  String dimension;
  String[] lines;
  String linesZero;
  Terrain dimensionBase;

  void GrilleRecup() {        //Load la map

    lines = loadStrings(dimension);     //dimension0 dans lines
    linesZero = lines[0];               //linesZero est la 1ere ligne de lines
    println("LineZero : " + linesZero.length()/2);               //Print la taille du doc X
    println(lines.length);                       //Print la taille du doc Y

    dimensionBase.x = linesZero.length()/2; //Rentre les tailles du doc dans le programme
    dimensionBase.y = lines.length;

    dimensionBase.InitGrille(linesZero.length()/2, lines.length);


    println("Plan_Dimension"+dimensionBase.noDim+".txt :");

    //for (int i = 0; i < lines.length; i++) {  //Affiche dans la console le Plan_Dimension0.txt
    //  println(lines[i]);
    //}
    println("there are " + lines.length + " lines");
    println("Lu !  :  " + int(random(0, 500)));



    for (int y = 0; y<dimensionBase.y; y++) {
      String[] ligneSimple = split(lines[y], " ");         //Split la ligne y dans ligneSimple pour passer par toutes les cases individuellement

      for (int x = 0; x<dimensionBase.x; x++) {

        //println(ligneSimple[x]);

        if (int(ligneSimple[x]) == 0) dimensionBase.Grille[x][y] = "herbe";
        if (int(ligneSimple[x]) == 1) dimensionBase.Grille[x][y] = "sol";
        if (int(ligneSimple[x]) == 2) dimensionBase.Grille[x][y] = "roche";       //Change les cases par rapport à Plan_Dimension0.txt
        if (int(ligneSimple[x]) == 3) dimensionBase.Grille[x][y] = "arbre";
        if (int(ligneSimple[x]) == 4) dimensionBase.Grille[x][y] = "eau";
      }
    }
  }
}
/*
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
 }*/
