class Ensemble {

  PVector pos, vel, dirCible, dir, acc, taille;
  boolean controllable = false;
  float speed = 0.1, rotSpeed = 0.1;
  String name = "";
  float rot;


  Grille grille;

  Ensemble() {
    Constructor();
  }

  Ensemble(float x, float y) {
    Constructor();
    pos = new PVector(x, y);
  }

  void Constructor() {
    pos = new PVector();
    vel = new PVector();
    dirCible = new PVector();
    dir = new PVector();
    acc = new PVector();
    taille = new PVector(50, 50);
    grille = new Grille();
  }

  void Display() {
    push();
    translate(pos.x*map.tailleCase, pos.y*map.tailleCase);

    dir.lerp(dirCible, rotSpeed);


    if (dir.y > 0) rot = PVector.angleBetween(dir, new PVector(1, 0));
    else rot = -PVector.angleBetween(dir, new PVector(1, 0));

    rotate(rot);

    rect(0, 0, taille.x, taille.y);
    rect(20, 0, taille.x*2, taille.y/2);

    grille.Display();

    pop();
  }

  void Update() {
    Deplacement();
  }

  void Deplacement() {
    dirCible = inputControl.keyDir; 

    vel = dirCible; 
    vel.setMag(speed); 

    pos.add(vel);
  }

  boolean IsOnThis(float x, float y) {
    float tailleCase = map.tailleCase; 
    if (x >= pos.x * tailleCase - taille.x/2 &&
      x <= pos.x * tailleCase + taille.x/2 &&
      y >= pos.y * tailleCase - taille.y/2 &&
      y <= pos.y * tailleCase + taille.y/2) {
      return true;
    } else return false;
  }

  String Print() {
    String pr = name; 
    if (pr.equals("")) pr = "NoName"; 

    return "Ensemble " + pr + " / Position " + pos;
  }


  //------------------------------------------------------GRILLE


  class Grille {

    Bloc [][] grilleBlocs; 
    boolean isDisplay = true;
    color colGrilleStroke = color(#4BFAFF);
    color colGrilleFond = color(#2A8B74);
    PVector tailleGrille;

    Grille() {
      grilleBlocs = new Bloc[25][25];

      grilleBlocs[12][13] = new Bloc();      
      grilleBlocs[13][13] = new Bloc();      
      grilleBlocs[12][11] = new Bloc();      
      grilleBlocs[13][11] = new Bloc();      
      grilleBlocs[11][12] = new Bloc();      
      grilleBlocs[10][12] = new Bloc();      
      grilleBlocs [9][12] = new Bloc();

      tailleGrille = new PVector();
    }

    void Display() {
      tailleGrille = new PVector(grilleBlocs.length*map.tailleBlocs, grilleBlocs[0].length*map.tailleBlocs);

      push();
      float tailleX = map.tailleBlocs * grilleBlocs.length;
      float tailleY = map.tailleBlocs * grilleBlocs[0].length;
      translate(-tailleX/2, -tailleY/2);
      translate(map.tailleBlocs/2, map.tailleBlocs/2);

      //---------------------------------------------------------GRILLE
      if (inputControl.b) {
        push();
        stroke(colGrilleStroke);        
        strokeWeight(0.5);

        translate(-map.tailleBlocs/2, -map.tailleBlocs/2);

        rectMode(CORNER);
        strokeWeight(2);
        fill(colGrilleFond, 200);
        rect(0, 0, tailleX, tailleY);
        strokeWeight(0.5);
        rectMode(CENTER);

        for (int x=0; x<=grilleBlocs.length*map.tailleBlocs; x+=map.tailleBlocs) {
          line(x, 0, x, tailleY);
        }
        for (int y=0; y<=grilleBlocs[0].length*map.tailleBlocs; y+=map.tailleBlocs) {        
          line(0, y, tailleX, y);
        }

        pop();
      }
      //-------------------------------------------------------------------

      for (int x=0; x<grilleBlocs.length; x++) {
        for (int y=0; y<grilleBlocs[0].length; y++) {
          if (grilleBlocs[x][y] != null) {
            PVector posBloc = new PVector(x*map.tailleBlocs, y*map.tailleBlocs); 
            grilleBlocs[x][y].Display(posBloc.x, posBloc.y);
          }
        }
      }
      pop();
    }
  }

  public PVector getPosBlocInMap(int x, int y) {
    PVector blocPos = new PVector();

    //Position dans le monde
    blocPos.add(new PVector(pos.x*map.tailleCase, pos.y*map.tailleCase));
    blocPos.sub(new PVector(grille.tailleGrille.x/2, grille.tailleGrille.y/2));

    //Position sur la grille
    PVector posLoc = new PVector(x*map.tailleBlocs, y*map.tailleBlocs);
    blocPos.add(posLoc);

    return blocPos;
  }
}
