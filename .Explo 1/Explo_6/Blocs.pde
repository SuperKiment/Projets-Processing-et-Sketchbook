String[] RecupFichierListe(String location) {
  String Liste[];
  Liste = loadStrings(location);

  for (int i = 0; i<Liste.length; i++) {//Récup la liste entiere des blocs
    print(Liste[i] + " / ");
  }

  return Liste;
}

String[] RecupFichierTextures(String location) {
  String Liste[];

  Liste = loadStrings(location);

  return Liste;//Récup la liste des textures (pas encore fait)
}

PImage RecupTexture(String nom) {
  PImage image;

  image = loadImage("Textures/"+ nom + ".png");  //Pour récup une texture dans le fichier de textures plus vite

  return image;
}

class Bloc {

  PImage texture;
  String nom;
  boolean collision, degats, ralenti;  //Classe du bloc - pas encore utile
  int degatsDelt;
  int ID;

  Bloc(String newnom, int id) {
    nom = newnom;

    ID = id;
  }
}

PImage imEau_claire;
PImage imHerbe;
PImage imSol;
PImage imRoche;  //Toutes les images
PImage imArbre;
PImage imEau;
PImage imEau_profonde;
PImage imFeuilles;
PImage imMur;
PImage imPiques;

PImage imFeuilles2;

void IniImages() {
  try {
    imHerbe = RecupTexture("herbe");
    imSol = RecupTexture("sol");
    imRoche = RecupTexture("roche");
    imArbre = RecupTexture("arbre");
    imEau = RecupTexture("eau");
    imEau_claire = RecupTexture("eau claire");
    imEau_profonde = RecupTexture("eau profonde");   //Ini de toutes les images (à changer et automatiser)
    imFeuilles = RecupTexture("feuilles");
    imMur = RecupTexture("mur");
    imPiques = RecupTexture("piques");
    loading = loadImage("Loading.png");
    icone = loadImage("icone.png");
    ImMob1 = RecupTexture("Mob1");

    imFeuilles2 = RecupTexture("feuilles2");
  } 
  catch(Exception e) {
    println("Pas réussi à charger les images");
  }
}
