final int Bloc_hpBase = 100;
final color noir = #000000;
final color rouge = #FF0000;
final color gris = #6A6A6A;
final color gris_fonce = #4D4D4D;
final color Bloc_PaliersCouleurs[] = {#C1943E, #CB7533, #B6C4C6, #8E6666, 
  #554EB4, #FF15F4}; 
final float Bloc_ecartBarreVie = 0.7;
final int Bloc_hauteurBarreVie = 10;
final int Bloc_PaliersHp[] = {0, 50, 100, 200, 400, 800};

class Bloc {
  int x, y, hp = Bloc_hpBase, hpMax = Bloc_hpBase;
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
      fill(noir);
      rectMode(CENTER);       //Barre de vie
      rect(xScreen, yScreen - grilleActive.tailleRect*Bloc_ecartBarreVie, hpMax*grilleActive.tailleRect/Bloc_hpBase, Bloc_hauteurBarreVie);
      fill(rouge);
      rect(xScreen, yScreen - grilleActive.tailleRect*Bloc_ecartBarreVie, hp*grilleActive.tailleRect/Bloc_hpBase, Bloc_hauteurBarreVie-deux);
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
    if (hp <= zero) {
      Explosion(xScreen, yScreen, hpMax/trois);

      grilleActive.grille[x][y] = gris_fonce;
      try {
        grilleActive.grille[x+un][y] = gris;
      } 
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x-un][y] = gris;   //Mettre le tour en noir
      }                                          //sans prendre e compte la grille
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x][y+un] = gris;
      } 
      catch(Exception e) {
      }
      try {
        grilleActive.grille[x][y-un] = gris;
      } 
      catch(Exception e) {
      }

      return true;
    } else return false;
  }

  color Couleur() {
    color couleur = zero;
    if (hpMax <= Bloc_PaliersHp[1]) couleur = Bloc_PaliersCouleurs[0];                //bois
    if (hpMax > Bloc_PaliersHp[1] && hpMax <= Bloc_PaliersHp[2]) couleur = Bloc_PaliersCouleurs[1];    //bois beau
    if (hpMax > Bloc_PaliersHp[2] && hpMax <= Bloc_PaliersHp[3]) couleur = Bloc_PaliersCouleurs[2];   //fer
    if (hpMax > Bloc_PaliersHp[3] && hpMax <= Bloc_PaliersHp[4]) couleur = Bloc_PaliersCouleurs[3];   //acier
    if (hpMax > Bloc_PaliersHp[4] && hpMax <= Bloc_PaliersHp[5]) couleur = Bloc_PaliersCouleurs[4];   //bleu
    if (hpMax > Bloc_PaliersHp[5]) couleur = Bloc_PaliersCouleurs[5];                //super rose
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
  int compteur = zero;
  for (Bloc bloc : TousBlocs) {
    println("Bloc n°" + compteur + " : x :" + bloc.x + " / y :" + bloc.y);
    compteur++;
  }
}

void BlocFonctions() {

  for (int i = zero; i<TousBlocs.size(); i++) {
    Bloc bloc = TousBlocs.get(i);                //Verif des blocs morts
    if (bloc.Mort()) TousBlocs.remove(i);
  }

  AffichageBloc();
}
