class Bloc {
  int x, y, hp = 100, hpMax = 100;
  float xScreen, yScreen;
  boolean indestructible = false;

  Bloc(int nx, int ny, int nhp, boolean nindestructible) {
    x = nx;
    y = ny;
    hpMax = nhp;
    hp = nhp;
    indestructible = nindestructible;
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
      fill(0);
      rectMode(CENTER);       //Barre de vie
      rect(xScreen, yScreen - grilleActive.tailleRect*0.7, hpMax*grilleActive.tailleRect/100, 10);
      fill(255, 0, 0);
      rect(xScreen, yScreen - grilleActive.tailleRect*0.7, hp*grilleActive.tailleRect/100, 8);
      pop();
    }
  }

  void PerdHP(int hpPerdu) {
    if (!indestructible) {
      hp -= hpPerdu;
      println(hpPerdu + " dégats mis à Bloc en x : "+x+" / y : "+y);
    }
  }

  boolean Mort() {
    if (hp <= 0) {
      Explosion(xScreen, yScreen, hpMax/3);
      return true;
    } else return false;
  }

  color Couleur() {
    color couleur = 125;
    if (hpMax <= 50) couleur = #C1943E;                //bois
    if (hpMax > 50 && hpMax <= 100) couleur = #CB7533;    //bois beau
    if (hpMax > 100 && hpMax <= 200) couleur = #B6C4C6;   //fer
    if (hpMax > 200 && hpMax <= 400) couleur = #8E6666;   //acier
    if (hpMax > 400 && hpMax <= 800) couleur = #554EB4;   //bleu
    if (hpMax > 800) couleur = #FF15F4;                //super rose
    return couleur;
  }
}


//----------------------------------------------------------------------------------

void AjouterBloc(int x, int y, int hp, boolean ind) {
  TousBlocs.add(new Bloc(x, y, hp, ind));
  println("Bloc posé en x : "+x+" / y : "+y);
}

void AffichageBloc() {
  for (Bloc bloc : TousBlocs) {
    bloc.Affichage();
  }
}

void DebugBloc() {
  int compteur = 0;
  for (Bloc bloc : TousBlocs) {
    println("Bloc n°" + compteur + " : x :" + bloc.x + " / y :" + bloc.y);
    compteur++;
  }
}

void BlocFonctions() {

  for (int i = 0; i<TousBlocs.size(); i++) {
    Bloc bloc = TousBlocs.get(i);
    if (bloc.Mort()) TousBlocs.remove(i);
  }

  AffichageBloc();
}
