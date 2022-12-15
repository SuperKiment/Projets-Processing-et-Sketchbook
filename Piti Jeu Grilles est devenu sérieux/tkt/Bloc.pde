class Bloc {
  int x, y, hp = tweakmode_int[4], hpMax = tweakmode_int[5];
  float xScreen, yScreen;
  boolean indest = false;

  Bloc(int nx, int ny, boolean nindest) {
    x = nx;
    y = ny;                  //Constructeur Indestructible
    indest = nindest;
  }

  Bloc(int nx, int ny, int nhp) {
    x = nx;
    y = ny;                  //Constructeur Destructible avec HP
    hp = nhp;
    hpMax = nhp;
  }

  Bloc(int nx, int ny) {
    x = nx;
    y = ny;                  //Constructeur Basique
  }

  void Affichage() {
    xScreen = x*grilleActive.tailleRect;
    yScreen = y*grilleActive.tailleRect;
    push();
    rectMode(CENTER);
    fill(Couleur());             //Affichage du Bloc
    noStroke();
    rect(xScreen, yScreen, grilleActive.tailleRect, grilleActive.tailleRect);
    pop();

    if (hp != hpMax) {
      push();
      fill(tweakmode_int[6]);
      rectMode(CENTER);       //Barre de vie
      rect(xScreen, yScreen - grilleActive.tailleRect*tweakmode_float[1], hpMax*grilleActive.tailleRect/tweakmode_int[7], tweakmode_int[8]);
      fill(tweakmode_int[9], tweakmode_int[10], tweakmode_int[11]);
      rect(xScreen, yScreen - grilleActive.tailleRect*tweakmode_float[2], hp*grilleActive.tailleRect/tweakmode_int[12], tweakmode_int[13]);
      pop();
    }
  }

  void PerdHP(int hpPerdu) {
    if (!indest) {
      hp -= hpPerdu;
      println(hpPerdu + " dégats mis à Bloc en x : "+x+" / y : "+y);
    }
  }

  boolean Mort() {
    if (hp <= tweakmode_int[14]) {
      Explosion(xScreen, yScreen, hpMax/tweakmode_int[15]);

      grilleActive.grille[x][y] = tweakmode_int[238];
      try {
        grilleActive.grille[x+tweakmode_int[16]][y] = tweakmode_int[239];
      } 
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x-tweakmode_int[17]][y] = tweakmode_int[240];   //Mettre le tour en noir
      }                                          //sans prendre e compte la grille
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x][y+tweakmode_int[18]] = tweakmode_int[241];
      } 
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x][y-tweakmode_int[19]] = tweakmode_int[242];
      } 
      catch(Exception e) {
      }

      return true;
    } else return false;
  }

  color Couleur() {
    color couleur = tweakmode_int[20];
    if (hpMax <= tweakmode_int[21]) couleur = tweakmode_int[243];                //bois
    if (hpMax > tweakmode_int[22] && hpMax <= tweakmode_int[23]) couleur = tweakmode_int[244];    //bois beau
    if (hpMax > tweakmode_int[24] && hpMax <= tweakmode_int[25]) couleur = tweakmode_int[245];   //fer
    if (hpMax > tweakmode_int[26] && hpMax <= tweakmode_int[27]) couleur = tweakmode_int[246];   //acier
    if (hpMax > tweakmode_int[28] && hpMax <= tweakmode_int[29]) couleur = tweakmode_int[247];   //bleu
    if (hpMax > tweakmode_int[30]) couleur = tweakmode_int[248];                //super rose
    return couleur;
  }
}


//----------------------------------------------------------------------------------

void AjouterBlocIndest(int x, int y) {
  TousBlocs.add(new Bloc(x, y, true));
  println("Bloc posé en x : "+x+" / y : "+y);
}
void AjouterBloc(int x, int y, int hp) {
  TousBlocs.add(new Bloc(x, y, hp));
  println("Bloc posé en x : "+x+" / y : "+y);
}

void AffichageBloc() {
  for (Bloc bloc : TousBlocs) {
    bloc.Affichage();           //Pour tous les blocs Afficher
  }
}

void DebugBloc() {
  int compteur = tweakmode_int[31];
  for (Bloc bloc : TousBlocs) {
    println("Bloc n°" + compteur + " : x :" + bloc.x + " / y :" + bloc.y);
    compteur++;
  }
}

void BlocFonctions() {

  for (int i = tweakmode_int[32]; i<TousBlocs.size(); i++) {
    Bloc bloc = TousBlocs.get(i);                //Verif des blocs morts
    if (bloc.Mort()) TousBlocs.remove(i);
  }

  AffichageBloc();
}
