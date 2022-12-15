Monde mondeActif;

HashMap<String, Monde> AllMondes = new HashMap<String, Monde>();


class Monde {

  String name;
  float tailleX, tailleY;
  Map map;

  ArrayList<Entite> AllEntites = new ArrayList<Entite>();
  ArrayList<Sol> AllSols = new ArrayList<Sol>();          

  Case GrilleCases[][];

  Monde(String nom) {
    tailleX = 50;
    tailleY = 50;
    GrilleCases = new Case[int(tailleX)][int(tailleY)];
    name = nom;
  }

  Monde(String nom, Map m) {
    map = m;
    tailleX = m.tX;       //Un jour j'aurai une map et tout
    tailleY = m.tY;
    GrilleCases = new Case[m.tX][m.tY];
    name = nom;
  }

  void Affichage_Entites() {
    for (Entite entite : AllEntites) {
      entite.Fonctions();
    }
  }
  void Affichage_Sols() {
    for (Sol sol : AllSols) {
      sol.Affichage();
    }
  }

  void addEntite(Entite entite) {
    AllEntites.add(entite);
  }

  void addSol(Sol sol) {
    AllSols.add(sol);
  }
}

class Map {

  int tX, tY;   //A voir comment je fais
  //Image, vectoriel ou 1 1 1 2 2 4 5 ??????????
  Map() {
  }
}

class Case {
  boolean destrucible = false;

  Case() {
  }

  void Affichage(float tx, float ty) {
    push(); 
    fill(125);            //A voir aussi
    stroke(0);
    rect(0, 0, tx, ty);
    pop();
  }
}
//================================================================

void Setup_Mondes() {
  Monde monde1 = new Monde("monde1");

  monde1.addEntite(new Entite(50, 50, "Player", "Corps/test2.json"));
  monde1.addEntite(new Entite(250, 250, "Mobtest", "Corps/test2.json")); //Entites test
  //monde1.addEntite(new Entite(300, 50, "Mobtest2")); //Entites test
  
  monde1.AllEntites.get(0).SetControllable(true);


  Monde monde2 = new Monde("monde2");

  monde2.addEntite(new Entite(100, 100, "Truc"));
  monde2.AllEntites.get(0).SetControllable(true);


  mondeActif = monde1;
  AllMondes.put(monde1.name, monde1);
  AllMondes.put(monde2.name, monde2);
}



void SwitchMonde(Monde monde) {
  if (monde != null) {
    AllMondes.replace(mondeActif.name, mondeActif);
    mondeActif = monde;
    println("Switch a monde "+mondeActif.name);
  } else {
    println("Monde null");
  }
}
