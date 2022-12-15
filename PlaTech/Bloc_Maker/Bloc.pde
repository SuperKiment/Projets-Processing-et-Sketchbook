
enum BlocType {
  Hull, Turret, Prop;
}

HashMap <String, Bloc> AllTypeBlocs;

class Bloc {

  PVector taille; 
  BlocType blocType;
  PImage []textures;
  String name = "NoName";

  int HP;

  Bloc() {
    Constructor();
  }

  Bloc(BlocType b) {
    Constructor(); 
    blocType = b;
  }

  void Constructor() {
    taille = new PVector(1, 1); 
    blocType = BlocType.Hull;
  }

  void Update() {
  }

  void Display(float x, float y) {
    push();
    try {
      image(textures[0], x, y, map.tailleBlocs, map.tailleBlocs);
    } 
    catch (Exception e) {
      fill(125); 
      rect(x, y, map.tailleBlocs, map.tailleBlocs);
      println("Pas réussi à charger le basic shit lmao");
    }
    pop();
  }

  void LoadBlocImage(String path) {
    ArrayList<PImage> images = new ArrayList<PImage>();
    int i = 0;

    while (true) {
      //           Hull_4.png
      String no = name + "_" + i + ".png";

      if (loadImage(path + no) == null) {
        break;
      }

      println("Image " + no + " collected");
      images.add(loadImage(path + no));
      i++;
    }

    textures = new PImage[images.size()];

    images.toArray(textures);
    println("ArraList size : " + images.size());
  }
}

//----------------------------SETUPS

String[] BlocsData;

void SetupBlocs() {
  String blocPath = "Blocs/";
  AllTypeBlocs = new HashMap <String, Bloc>();
  BlocsData = loadStrings(blocPath+"BlocsData.txt");

  println();
  println("---> Loading Blocs :");

  for (int i = 0; i < BlocsData.length; i++) {

    Bloc bloc = new Bloc();
    bloc.name = BlocsData[i];
    println(BlocsData[i]);
    //------------------------------IMAGES
    println("Images :");
    bloc.LoadBlocImage(blocPath + bloc.name + "/");
    println("Loaded " + bloc.textures.length + " textures");

    //------------------------------JSON

    println("JSONs :");

    JSONObject json = new JSONObject();

    json.setString("name", bloc.name);
    json.setInt("HP", bloc.HP);

    saveJSONObject(json, blocPath + bloc.name + "/" + bloc.name + ".json");

    //json = loadJSONObject(blocPath + bloc.name + "/" + bloc.name + ".json");

    AllTypeBlocs.put(BlocsData[i], bloc);
    println("Loaded : " + BlocsData[i]);
    println();
  }
}
