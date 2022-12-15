Monde mondeActif;

HashMap<String, Monde> AllMondes = new HashMap<String, Monde>();


class Monde {

  String name;
  Grille grille;

  ArrayList<Entite> AllEntites = new ArrayList<Entite>();
  ArrayList<Sol> AllSols = new ArrayList<Sol>();



  Monde(String nom) {
    grille = new Grille();
    Constructeur(nom);
  }
  Monde(String nom, Grille g) {
    grille = g;
    Constructeur(nom);
  }

  void Constructeur(String nom) {    
    name = nom;
  }

  void Affichage_Entites() {
    for (Entite entite : AllEntites) {
      entite.Update();
    }
  }
  void Affichage_Sols() {
    for (Sol sol : AllSols) {
      sol.Affichage();
    }
  }

  void addEntite(Entite entite) {
    entite.SetMondeParent(name);
    AllEntites.add(entite);
  }

  void addSol(Sol sol) {
    AllSols.add(sol);
  }

  JSONObject getJSONEntites() {
    JSONObject json = new JSONObject();

    for (Entite entite : AllEntites) {
      JSONObject entJSON = new JSONObject();

      entJSON.setFloat("x", entite.position.x);
      entJSON.setFloat("y", entite.position.y);
      entJSON.setString("name", entite.name);
      entJSON.setString("class", entite.getClass().getName());

      json.setJSONObject(entite.name, entJSON);
    }

    return json;
  }
}




class Grille {

  Case grilleCases[][];
  int tailleCase;

  Grille() {
    ConstructeurBase(5, 5);
  }

  Grille(int x, int y) {
    ConstructeurBase(x, y);
  }

  void ConstructeurBase(int x, int y) {
    grilleCases = new Case [x][y];
  }

  void clearGrille() {
    for (int x = 0; x<grilleCases.length; x++) {
      for (int y = 0; y<grilleCases[0].length; y++) {
        grilleCases[x][y] = new Case();
      }
    }
  }

  JSONObject getJSONGrille() {
    JSONObject json = new JSONObject();

    for (int x=0; x<grilleCases.length; x++) {
      for (int y=0; y<grilleCases[0].length; y++) {
        Case c = grilleCases[x][y];
        JSONObject cJson = new JSONObject();

        cJson.setFloat("x", x);
        cJson.setFloat("y", y);

        json.setJSONObject(x+" "+y, cJson);
      }
    }

    return json;
  }

  //---------------------CASE

  Case getCase(int x, int y) {
    return grilleCases[x][y];
  }


  class Case {
    boolean destructible = false;

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
}
//================================================================

void Setup_Mondes() {
  Monde monde1 = new Monde("monde1");

  monde1.addEntite(new Mob(50, 50, "Player"));
  monde1.addEntite(new Mob(100, 50, "Mobtest")); //Entites test
  monde1.addEntite(new Mob(300, 50, "Mobtest2")); //Entites test
  monde1.AllEntites.get(0).SetControllable(true);

  Mob caillou = new Mob(100, 100, "Caillou");
  caillou.SetTaille(100);
  caillou.SetSpeed(0);
  monde1.addEntite(caillou);
  
  NuageEntites nuage = new NuageEntites(400, 300, "NuageTest");
  monde1.addEntite(nuage);

  Wall wallTest = new Wall(200, 200, "WallTest");
  wallTest.SetTaille(50);
  wallTest.SetSpeed(0);
  monde1.addEntite(wallTest);


  Monde monde2 = new Monde("monde2");

  monde2.addEntite(new Entite(100, 100, "Truc"));
  monde2.AllEntites.get(0).SetControllable(true);


  mondeActif = monde1;
  AllMondes.put(monde1.name, monde1);
  AllMondes.put(monde2.name, monde2);
}



void SwitchMonde(Monde monde) {
  if (monde != null) {
    AllMondes.replace(mondeActif.name, mondeActif);  //Sauvegarde du monde dans le hashmap

    Monde oldMonde = mondeActif;

    mondeActif = monde; //Replace le mondeActif par le nouveau monde

    println("Switch a monde "+mondeActif.name);
  } else {
    println("Monde null");
  }
}
