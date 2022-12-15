String[] RecupFichierListe(String location) {
  String Liste[];
  Liste = loadStrings(location);

  for (int i = 0; i<Liste.length; i++) {
    print(Liste[i] + " / ");
  }

  return Liste;
}

String[] RecupFichierTextures(String location) {
  String Liste[];

  Liste = loadStrings(location);

  return Liste;
}

PImage RecupTexture(String nom) {
  PImage image;

  image = loadImage("Textures/"+ nom + ".png");

  return image;
}

class Bloc {

  PImage texture;
  String nom;
  boolean collision, degats, ralenti;
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
PImage imRoche;
PImage imArbre;
PImage imEau;
PImage imEau_profonde;
PImage imFeuilles;
PImage imMur;
PImage imPiques;

void IniImages() {
  try {
    imHerbe = RecupTexture("herbe");
    imSol = RecupTexture("sol");
    imRoche = RecupTexture("roche");
    imArbre = RecupTexture("arbre");
    imEau = RecupTexture("eau");
    imEau_claire = RecupTexture("eau claire");
    imEau_profonde = RecupTexture("eau profonde");
    imFeuilles = RecupTexture("feuilles");
    imMur = RecupTexture("mur");
    imPiques = RecupTexture("piques");
    loading = loadImage("Loading.png");
    icone = loadImage("icone.png");
    ImMob1 = RecupTexture("Mob1");
  } 
  catch(Exception e) {
    println("Pas réussi à charger les images");
  }
}
