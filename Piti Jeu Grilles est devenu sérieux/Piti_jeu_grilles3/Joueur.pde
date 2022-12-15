class Joueur {
  float x, y, ID = int(random(100, 999)), taille = 0.4;
  int posx, posy;
  float speed = 0.1;
  float mvtx, mvty;
  float xScreen, yScreen;

  Joueur(float newx, float newy) {
    x = newx;
    y = newy;
  }

  void Affichage() {
    xScreen = x*grilleActive.tailleRect;
    yScreen = y*grilleActive.tailleRect;
    push();
    rectMode(CENTER);                    //Afficher le carré noir
    fill(0);
    rect(xScreen, yScreen, ConvGrillePixel(taille), ConvGrillePixel(taille));
    pop();

    arme.Affichage();                     //Afficher l'arme
  }

  void Deplacement() {
    //if (CollisionXOk() && CollisionBlocXOk()) {  
      x += mvtx;           //Si les collisions sont Ok, bouger
    //}

    //if (CollisionYOk() && CollisionBlocYOk()) {
      y += mvty;
    //}

    posx = Arrondir(x);
    posy = Arrondir(y); //Positions de grille du joueur
  }

  void ResetPos() {
    x = 1;
    y = 1;
  }

  boolean CollisionXOk() {
    if (x+mvtx < grilleActive.taillex-1 && //Collision en X
      x+mvtx > 0) {
      return true;
    } else return false;
  }

  boolean CollisionYOk() {
    if (y+mvty < grilleActive.tailley-1 && //Collision en Y
      y+mvty > 0) {
      return true;
    } else return false;
  }

  boolean CollisionBlocXOk() {
    boolean noCollision = true;
    for (Bloc bloc : TousBlocs) {
      if (posy == bloc.y) {
        int distX = posx - bloc.x;   //Collision avec les blocs en X
        int aDroite = 0;

        if (distX >  0) aDroite = 1;
        if (distX == 0) aDroite = 0;
        if (distX <  0) aDroite = -1;
        
        switch(aDroite) {
         case 1 :
         if (x+mvtx < bloc.x + 0.5 + taille/2) noCollision = false;
         break;
         case -1 :
         if (x+mvtx > bloc.x - 0.4 - taille/2) noCollision = false;
         break;
         }
      }
    }

    return noCollision;
  }

  boolean CollisionBlocYOk() {
    boolean noCollision = true;
    for (Bloc bloc : TousBlocs) {
      if (posx == bloc.x) {
        int distY = posy - bloc.y;   //Collision avec les blocs en Y
        int enBas = 0;

        if (distY >  0) enBas = 1;
        if (distY == 0) enBas = 0;
        if (distY <  0) enBas = -1;

        
        switch(enBas) {
         case 1:      
         if (y+mvty < bloc.y + 0.4 + taille/2) noCollision = false;
         break;
         case -1:
         if (y+mvty > bloc.y - 0.5 - taille/2) noCollision = false;
         break;
         }
      }
    }

    return noCollision;
  }

  void Debug() {
    println("Debug Joueur :   ----------------------------");
    println("posx : " + posx + " ; posy : " + posy);
    println("x : " + x + " ; y : " + y);
    println("Fin Debug Joueur :   ------------------------");
  }

  //---------------------------------------------------------------ARME---DEBUT

  class Arme {
    ArrayList<Munition> AllMunitions = new ArrayList<Munition>();
    float rotation = 0;
    boolean active = true;
    String armeEquipee = "classique";
    boolean tir = false;
    float intervalleTir = 100, timerTir = 0;

    Arme() {
    }

    void Affichage() {
      if (active) {
        push();

        float distX, distY;  //Variables
        float inversion = 1;

        distX = mouseX - (xScreen+translateX);  //Récupération de la distance entre mouseX et le centre
        distY = mouseY - (yScreen+translateY);

        if (distX > 0) inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
        if (distX < 0) inversion = PI;

        rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

        translate(xScreen, yScreen);
        rotate(rotation);
        fill(rouge_pointe);
        strokeWeight(1);           //Affichage en fonction de tout
        rectMode(CENTER);
        rect(grilleActive.tailleRect/5, 0, grilleActive.tailleRect, grilleActive.tailleRect/5);
        pop();
      }

      for (int i = 0; i<AllMunitions.size(); i++) {
        Munition munition = AllMunitions.get(i);
        munition.Fonctions();                 //Fonctions des munitions
        if (munition.timer >= munition.portee ||
          munition.CollisionBloc() ||
          munition.CollisionPantin()) {    //Collisions des munitions
          AllMunitions.remove(i);
        }
      }
    }

    void Changer() {
      switch(armeEquipee) {
      case "classique":
        armeEquipee = "batteuse";
        intervalleTir = 10;
        break;              //Changer d'arme
      case "batteuse":
        armeEquipee = "mortier";
        intervalleTir = 500;
        break;
      case "mortier":
        armeEquipee = "destructeur";
        intervalleTir = 5;
        break;
      case "destructeur":
        armeEquipee = "classique";
        intervalleTir = 100;
        break;
      }
    }

    void Tir() {
      if (active) {
        //println("Le Joueur tire !");

        if (!tir) timerTir = millis() - intervalleTir;

        if (millis() - timerTir >= intervalleTir) {
          timerTir = millis();
          if (tir) {                              //boum !   
            switch (armeEquipee) {           //Puissance / Vitesse / Angle / Précision Depart / Précision Vol
            case "classique" :
              AllMunitions.add(new Munition(30, 40, rotation, 0, PI/8));
              break;
            case "batteuse" :
              AllMunitions.add(new Munition(8, 20, rotation, PI/16, 0));
              break;
            case "destructeur" :
              AllMunitions.add(new Munition(100, 30, rotation, 0, 0));
              break;
            case "mortier" :
              AllMunitions.add(new Munition(80, 50, rotation, 0, 0));
              break;
            }
          }
        }
      }
    }

    void TirOn() {
      tir = true;
    }              //Fonctions des inputs

    void TirOff() {
      tir = false;
    }

    class Munition {            //------------------------------------MUNITIONS

      float xMun, yMun, puissance, speed;
      float mvtxMun, mvtyMun, angle, tailleMun = 0.4;
      int timer = 0, portee = 200;
      float precisionEnVol = 0;
      float precisionDepart = 0;
      float OffSpeed;

      Munition(float npuissance, float nspeed, float nangle, float precisionD, float precisionV) {
        precisionEnVol = precisionV;
        precisionDepart = precisionD;
        puissance = npuissance;          //Thicc contructeur
        OffSpeed = nspeed/3;
        speed = (nspeed+random(-OffSpeed, OffSpeed)) * grilleActive.tailleRect/50;
        angle = -nangle + PI/2 + random(-precisionDepart, precisionDepart);
        xMun = xScreen;
        yMun = yScreen;
        timer = 0;
      }

      void Deplacement() {
        timer++;

        mvtxMun = sin(angle+random(-precisionEnVol, precisionEnVol))*speed;
        mvtyMun = cos(angle+random(-precisionEnVol, precisionEnVol))*speed;

        xMun+=mvtxMun;      //Deplacement en fonction de l'angle
        yMun+=mvtyMun;
      }

      void Affichage() {
        ellipse(xMun, yMun, ConvGrillePixel(tailleMun), ConvGrillePixel(tailleMun));
      }

      void Fonctions() {
        Deplacement();
        Affichage();
      }

      boolean CollisionBloc() {
        boolean collision = false;

        for (int i = 0; i<TousBlocs.size(); i++) {   //Collision avec un bloc
          Bloc bloc = TousBlocs.get(i);
          if (Arrondir(ConvPixelGrille(xMun)) == bloc.x && Arrondir(ConvPixelGrille(yMun)) == bloc.y) {
            Explosion(xMun, yMun, 20);
            TousBlocs.get(i).PerdHP(int(puissance));
            collision = true;
          }
        }

        return collision;
      }

      boolean CollisionPantin() {
        boolean collision = false;

        for (int i = 0; i<AllPantins.size(); i++) { //Collision avec un pantin
          Pantin pantin = AllPantins.get(i);
          if (pantin.Contact(xMun, yMun)) {
            Explosion(xMun, yMun, 20);
            AllPantins.get(i).PerdHP(int(puissance));
            collision = true;
          }
        }

        return collision;
      }
    }//FIN MUNITIONS
  }//-------------------------ARME------FIN-------------------------------


  Arme arme = new Arme();// Arme du joueur
}

void JoueurFonctions() {
  joueur.Deplacement();   //Fonctions du joueur
  joueur.Affichage();
  joueur.arme.Tir();
}
