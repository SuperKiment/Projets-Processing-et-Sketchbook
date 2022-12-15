class Entite {

  PVector position, deplacement;
  float hp = 100, stamina = 100, taille = 20, speed = 2;
  float dir, rangeCollision = 200;
  boolean focus = false;
  boolean controllable = false;
  boolean collisionDetection = false;

  String mondeParent;

  int delayEntitesProches = 16, 
    delayLateSetup = 1000;

  ThreadCollisionsEntitiesProches threadCollisionEntPr;
  ThreadLateSetup threadLateSetup;
  float timeBetFramesEntPr = 0;




  String name = "noName";

  ArrayList<Entite> EntitesProches = new ArrayList<Entite>();
  ArrayList<Entite> EntitesCollision = new ArrayList<Entite>();

  //Constructeur Position X Y
  Entite(float nx, float ny, String nom) {
    position = new PVector(nx, ny);
    ConstucteurBase(nom);
  }

  //Constructeur Position Vector
  Entite(PVector pos, String nom) {
    position = pos;
    ConstucteurBase(nom);
  }

  Entite() {
    position = new PVector();
  }

  //Constructeur Base
  void ConstucteurBase(String nom) {
    deplacement = new PVector();
    name = nom;

    threadCollisionEntPr = new ThreadCollisionsEntitiesProches();


    threadLateSetup = new ThreadLateSetup();
    threadLateSetup.start();
  }

  void Display() {

    AffichageEntitesProches();  //Line entre les entites proches
    
    push();
    translate(position.x, position.y);
    rotate(dir);
    DisplayEntite();           //Display de l'entite


    fill(0, 0, 0, 0);
    stroke(125);                     //Range Collision
    ellipse(0, 0, 2*rangeCollision, 2*rangeCollision);
    pop();
  }

  void DisplayEntite() {
    rectMode(CENTER);               //Corps
    rect(0, 0, taille, taille);
  }

  void Deplacement() {
    deplacement = new PVector(0, 0);

    //Controle si controllable
    if (controllable) {
      if (input.z.pressed) deplacement.y--;
      if (input.q.pressed) deplacement.x--;
      if (input.s.pressed) deplacement.y++;
      if (input.d.pressed) deplacement.x++;
    } else {
    }

    deplacement.setMag(speed);

    position.add(deplacement);
  }

  void FocusCamera() {
    if (focus) {           //Mets le focus sur this
      camera.focus = this;
    }
  }

  void Update() {
    Deplacement();
    //FocusCamera();
    Display();
  }




  boolean IsClicked() {
    if (mouseX > position.x-taille/2+camera.translX && mouseX < position.x+taille/2+camera.translX &&
      mouseY > position.y-taille/2+camera.translY && mouseY < position.y+taille/2+camera.translY) {
      return true;
    } else return false;  //Si il est clické par rapport à Taille alors return true else false
  }

  boolean isCollisionEntite(Entite entite) {
    boolean collision = false;               //Collisions entite - provisoire

    if (position.x + taille/2 >= entite.position.x - entite.taille/2 && position.x - taille/2 <= entite.position.x + entite.taille/2 &&
      position.y + taille/2 >= entite.position.y - entite.taille/2 && position.y - taille/2 <= entite.position.y + entite.taille/2) {
      collision = true;
    }

    return collision;
  }




  //-----------                       -SET

  void SetControllable(boolean bool) {
    controllable = bool;
  }

  void SetName(String nom) {
    name = nom;
  }

  void SetPosition(float x, float y) {
    position = new PVector(x, y);
  }

  void SetPosition(PVector pos) {
    position = pos;
  }

  void SetMondeParent(String monde) {
    mondeParent = monde;
  }

  void SetTaille(float t) {
    taille = t;
  }

  void SetSpeed(float s) {
    speed = s;
  }




  String InfosBase() {
    return "x : "+position.x+" / y : "+position.y+" / taille : "+taille+" / controllable : "+controllable+" / Monde : "+mondeParent;
  }

  String InfosPosition() {
    return "("+name+" "+position.x+";"+position.y+")";           //Return Strings des infos
  }

  String InfosEntitesProches() {
    String infos = "Entites Proches : ";
    try {
      if (!EntitesProches.isEmpty()) {
        for (Entite entite : EntitesProches) {
          infos += entite.InfosPosition() + "/";
        }
      } else infos = "Pas d'entites proches";

      return infos;
    }
    catch(Exception e) {
      return "";
    }
  }

  String InfosCollisions() {
    String infos = "Collisions : ";

    if (!EntitesCollision.isEmpty()) {
      for (Entite entite : EntitesCollision) {
        infos += entite.InfosPosition() + "/";
      }
    } else infos = "Pas de collisions";

    return infos;
  }

  String InfosThreads() {
    String infos = "";

    if (threadCollisionEntPr != null) {
      //infos += "TimeBetFrames Collisions : " + timeBetFramesEntPr;
    }

    return infos;
  }




  public void DetectionEntitesProches() {
    try {
      EntitesProches.clear();
      for (Entite entite : mondeActif.AllEntites) {        
        if (entite != this && dist(position.x, position.y, entite.position.x, entite.position.y) <= rangeCollision) {
          EntitesProches.add(entite);
        }
      }
    } 
    catch(Exception e) {
    }
  }

  void AffichageEntitesProches() {
    try {
      for (Entite entite : EntitesProches) {              //Detections de collisions et d'entites proches
        stroke(255);
        line(position.x, position.y, entite.position.x, entite.position.y);
      }
    } 
    catch(Exception e) {
    }
  }

  void DetectionCollisions() {
    try {
      EntitesCollision.clear();
      for (Entite entite : EntitesProches) {
        if (isCollisionEntite(entite)) {
          EntitesCollision.add(entite);
        }
      }
    } 
    catch(Exception e) {
    }
  }

  void ReactionCollision() {
    if (!EntitesCollision.isEmpty()) {           //Reaction à la collision
      for (Entite entite : EntitesCollision) {

        Wall wall = new Wall();
        Mob mob = new Mob();

        //Réaction au mob
        if (entite.getClass() == mob.getClass()) {
          PVector dirReact = new PVector(position.x - entite.position.x, position.y - entite.position.y);
          dirReact.setMag(speed);

          position.add(dirReact);


          //Réaction au wall
        } else if (entite.getClass() == wall.getClass()) {
          //Si à gauche alors on speed à gauche

          //if (position.x <= entite.position.x &&
          //  position.y <= entite.position.y + entite.taille/2 && position.y >= entite.position.y - entite.taille/2 ) {
          //  PVector react = new PVector(position.x-entite.position.x, 0);
          //  react.setMag(taille/2-(position.x+taille/2-(entite.position.x-entite.taille/2)));
          //  position.add(react);
          //}
        }
      }
    }
  }


  //-----------------------------------                    THREADS

  //Detect Entites Proches
  class ThreadCollisionsEntitiesProches extends Thread {

    boolean exit = false;
    float timeBetFrames = 0;

    ThreadCollisionsEntitiesProches() {
    }

    void start() {
      super.start();
      exit = false;
    }

    void run() {
      while (!exit) {

        float timer = millis();

        if (mondeActif.name.equals(mondeParent)) {
          DetectionEntitesProches();

          DetectionCollisions();

          ReactionCollision();
        }

        timeBetFrames = millis() - timer;

        timeBetFramesEntPr = timeBetFrames;

        delay(delayEntitesProches);
      }
    }

    void Exit() {
      exit = true;
    }
  }

  //Late Setup
  class ThreadLateSetup extends Thread {


    ThreadLateSetup() {
    }

    void run() {
      delay(delayLateSetup);

      threadCollisionEntPr.start();
    }
  }

  //-----------------------------------   On verra
  class Corps {

    Corps() {
    }
  }
  //------------------------------------
}

//============================================================================================
