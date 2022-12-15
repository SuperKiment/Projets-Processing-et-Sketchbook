
enum BlocType {
  Classic, Hard, Turret;
}

HashMap <String, Bloc> AllTypeBlocs;

class Bloc {

  PVector taille; 
  BlocType blocType = BlocType.Classic; 
  PImage texture;

  Bloc() {
    Constructor();
  }

  Bloc(BlocType b) {
    Constructor(); 
    blocType = b;
  }

  void Constructor() {
    taille = new PVector(1, 1); 
    blocType = BlocType.Classic;
  }

  void Update() {
  }

  void Display(float x, float y) {
    push(); 
    try {
      image(basicHull[5], x, y, map.tailleBlocs, map.tailleBlocs);
    } 
    catch (Exception e) {
      fill(125); 
      rect(x, y, map.tailleBlocs, map.tailleBlocs);
      println("Pas réussi à charger le basic shit lmao");
    }
    pop();
  }
}

void SetupBlocs() {
  AllTypeBlocs = new HashMap <String, Bloc>();
}
