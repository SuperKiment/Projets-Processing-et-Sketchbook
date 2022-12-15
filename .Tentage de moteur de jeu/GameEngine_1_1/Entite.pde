class Entite {

  PVector position, deplacement;
  float hp = 100, stamina = 100, taille = 20;
  float dir, rangeCollision = 200;
  boolean focus = false;
  boolean controllable = false;

  String name = "noName";

  ArrayList<Entite> EntitesProches = new ArrayList<Entite>();

  Entite(float nx, float ny, String nom) {
    position = new PVector(nx, ny);
    deplacement = new PVector();
    name = nom;
  }

  Entite(PVector pos, String nom) {
    position = pos;
    deplacement = new PVector();
    name = nom;
  }

  void Affichage() {
    push();
    translate(position.x, position.y);
    rotate(dir);
    rectMode(CENTER);
    rect(0, 0, taille, taille);

    fill(0, 0, 0, 0);
    stroke(255);
    ellipse(0, 0, 2*rangeCollision, 2*rangeCollision);
    pop();
  }

  void Deplacement() {
    deplacement = new PVector(0, 0);

    EntitesProches.clear();
    for (Entite entite : mondeActif.AllEntites) {
      if (entite != this && dist(position.x, position.y, entite.position.x, entite.position.y) <= rangeCollision) {
        push();
        stroke(255);
        line(position.x, position.y, entite.position.x, entite.position.y);

        EntitesProches.add(entite);
        pop();
      }
    }

    if (controllable) {
      if (!isCollision(mondeActif.AllEntites.get(1)) && input.z.pressed) deplacement.y--;
      if (!isCollision(mondeActif.AllEntites.get(1)) && input.q.pressed) deplacement.x--;
      if (!isCollision(mondeActif.AllEntites.get(1)) && input.s.pressed) deplacement.y++;
      if (!isCollision(mondeActif.AllEntites.get(1)) && input.d.pressed) deplacement.x++;
    }

    position.add(deplacement);
  }

  void FocusCamera() {
    if (focus) {
      camera.focus = this;
    }
  }

  void Fonctions() {
    Deplacement();
    //FocusCamera();
    Affichage();
  }

  boolean IsClicked() {
    if (mouseX > position.x-taille/2+camera.translX && mouseX < position.x+taille/2+camera.translX &&
      mouseY > position.y-taille/2+camera.translY && mouseY < position.y+taille/2+camera.translY) {
      return true;
    } else return false;
  }

  void SetControllable(boolean contr) {
    controllable = contr;
  }

  void SetName(String nom) {
    name = nom;
  }

  boolean isCollision(Entite entite) {
    boolean collision = false;               //Collisions
    return collision;
  }

  String InfosBase() {
    return "x : "+position.x+" / y : "+position.y+" / taille : "+taille+" / controllable : "+controllable+" / deplacement : "+deplacement.x;
  }

  String InfosPosition() {
    return "("+name+" "+position.x+";"+position.y+")";
  }

  String InfosCollision() {
    String infos = "";

    if (EntitesProches.size() > 0) {
      for (Entite entite : EntitesProches) {
        infos += entite.InfosPosition() + "/";
      }
    } else infos = "Pas d'entites proches";

    return infos;
  }

  //-----------------------------------
  class Corps {

    Corps() {
    }
    
    
  }
  //------------------------------------
}
