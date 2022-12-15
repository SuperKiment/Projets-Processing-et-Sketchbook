ArrayList<Tank> AllTanks = new ArrayList<Tank>();

class Tank {

  float x = 100, y = 100, dir, dirSpeed = PI/50;
  float taille = 20, speed, speedMax = 5;
  int hp;

  boolean forw, back, left, right;

  Tank(float nx, float ny) {
    x = nx;
    y = ny;
  }

  void Affichage() {
    push();

    translate(x, y);
    rotate(dir);
    fill(255);

    rect(0, 0, taille, taille);

    canon.Affichage();

    pop();
  }

  void Deplacement() {

    if (Collision()) {
      if (AngleCollision() == "x") {
        dir += 2*((PI/2) - dir);
      }
      if (AngleCollision() == "y") {
        dir = -dir;
      }

      speed /= 4;
    }

    if (forw || back ||
      left || right) {
      speed = lerp(speed, speedMax, 0.01);
    }

    if (!forw && !back &&
      !left && !right) {
      speed = lerp(speed, 0, 0.05);
    }

    if (forw) {
      x += speed*cos(dir);
      y += speed*sin(dir);
    }
    if (back) {
      x -= speed*cos(dir);
      y -= speed*sin(dir);
    }

    if (left) {
      dir -= dirSpeed;
    }
    if (right) {
      dir += dirSpeed;
    }
  }

  Mur murCollision;

  boolean Collision() {
    boolean collision = false;

    float x1 = x+speed*cos(dir), 
      y1 = y+speed*sin(dir);
    float x2 = x-speed*cos(dir), 
      y2 = y-speed*sin(dir);

    for (int i = 0; i<AllMurs.size(); i++) {
      Mur mur = AllMurs.get(i);

      if (forw && mur.DansMur(x1, y1)) {
        collision = true;
        murCollision = mur;
      } else if (back && mur.DansMur(x2, y2)) {
        collision = true;
        murCollision = mur;
      }
    }

    return collision;
  }

  String AngleCollision() {
    String ret = "fail";
    String rapport = murCollision.PosParRapport(x, y);

    if (rapport == "haut" ||rapport ==  "bas") ret = "y";      
    if (rapport == "gauche" ||rapport ==  "droite") ret = "x";      

    return ret;
  }

  void Fonctions() {
    Deplacement();
    Affichage();
    canon.Fonctions_Munitions();
  }

  //------------------------CANON
  Canon canon = new Canon();

  class Canon {
    Canon() {
    }

    void Affichage() {
      fill(100);
      rect(taille/2, 0, taille*2, taille/2);
    }

    void Fonctions_Munitions() {
      for (int i = 0; i<AllMunitions.size(); i++) {
        Munition mun = AllMunitions.get(i);

        mun.Fonction();

        if (mun.Mort()) AllMunitions.remove(i);
      }
    }

    void Tir() {
      AllMunitions.add(new Munition());
    }


    //--------------------------
    ArrayList<Munition> AllMunitions = new ArrayList<Munition>();
    class Munition {
      float ori, xMun, yMun, speedMun = 10;
      float duree = 1000, timer;
      Munition() {
        xMun = x;
        yMun = y;
        ori = dir;
        timer = millis();
      }
      Munition(float nx, float ny) {
        xMun = nx;
        yMun = ny;
        ori = dir;
        timer = millis();
      }

      void Fonction() {        

        if (CollisionMun()) {
          if (AngleCollisionMun() == "x") {
            ori += 2*((PI/2) - ori);
          }
          if (AngleCollisionMun() == "y") {
            ori = -ori;
          }
          BoumParticules(xMun, yMun, 5, 20, 5);
          speedMun /= 1.5;
        }

        xMun += speedMun*cos(ori);
        yMun += speedMun*sin(ori);

        push();
        fill(255);
        translate(xMun, yMun);
        ellipse(0, 0, 10, 10);
        pop();
      }

      boolean Mort() {
        if (millis() - timer >= duree) {
          AllMunitions.add(new Munition(xMun, yMun));
          return true;
        } else return false;
      }

      boolean CollisionMun() {
        boolean collision = false;

        float x1 = xMun+speedMun*cos(ori), 
          y1 = yMun+speedMun*sin(ori);

        for (int i = 0; i<AllMurs.size(); i++) {
          Mur mur = AllMurs.get(i);

          if (mur.DansMur(x1, y1)) {
            collision = true;
            murCollisionMun = mur;
          }
        }

        return collision;
      }

      Mur murCollisionMun;

      String AngleCollisionMun() {
        String ret = "fail";
        String rapport = murCollisionMun.PosParRapport(xMun, yMun);

        if (rapport == "haut" ||rapport ==  "bas") ret = "y";      
        if (rapport == "gauche" ||rapport ==  "droite") ret = "x";      

        return ret;
      }
    }
    //------------------
  }
}

//==============================

void Setup_Tanks() {
  AllTanks.add(new Tank(200, 200));
  AllTanks.add(new Tank(400, 200));
}

void Fonctions_Tanks() {
  for (int i = 0; i<AllTanks.size(); i++) {
    Tank tank = AllTanks.get(i);

    tank.Fonctions();
  }
}
