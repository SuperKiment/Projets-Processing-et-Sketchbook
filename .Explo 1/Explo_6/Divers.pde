void TranslateArPl(boolean mob) {
  if (!mob) {
    translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25);
  }
  //Translate pour mettre à l'arriere plan
  if (mob) {
    translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25, 1);
  }
}

void TitePhrases() {
  String[] PhrasesDebut = loadStrings("Random Titres.txt");
  int noRand = int(random(0, PhrasesDebut.length-1));       //Random le titre de la fenetre

  surface.setTitle(PhrasesDebut[noRand]);
}

//----------Soleil------------

class Astre {

  float xheure, yheure;
  int r, g, b;  
  float vitesseAstre;
  float xPos, yPos, zPos;
  float xHeure = 0;

  Astre(float nvitesseAstre, int nr, int ng, int nb, float nxheure) {
    vitesseAstre = 2*PI/nvitesseAstre;
    r = nr;
    g = ng;
    b = nb;

    xHeure = nxheure;
    yheure = nxheure;

    println("créé : Astre");
  }

  void HeureChange() {
    xHeure += vitesseAstre;
    xheure = (cos(xHeure)+1)*12;               //XHeure va de 0 à 2PI
    xHeure += vitesseAstre;                    //xheure va donc de 1 à 1
    yheure = (sin(xHeure)+1)*12;               //yheure de 0 à 0

    if (xHeure == 2*PI) xHeure = 0;

    xPos = xheure/12-1;
    yPos = xheure/12-1;   //Récup de xyzPos de -1 à 1 (oui c'est con mais j'aime bien)
    zPos = yheure/12-1;
  }

  void Lumiere() {
    directionalLight(r, g, b, xPos, yPos, zPos);  //Affichage de la lumiere en focntion du reste
  }
}

int luminosite = 100;        // lumimosité monte = puissance du light diminue
int vitesseAstres = 20000;

//Deux astres de chaque pour avoir une transition fondue
Astre Soleil = new Astre(vitesseAstres, 255-luminosite, 248-luminosite, 222-luminosite, PI);
Astre Soleil2 = new Astre(vitesseAstres, 255-luminosite, 248-luminosite, 222-luminosite, PI+PI/6);  
Astre Lune = new Astre(vitesseAstres, 159-luminosite, 155-luminosite, 216-luminosite, 0);
Astre Lune2 = new Astre(vitesseAstres, 159-luminosite, 155-luminosite, 216-luminosite, PI/6);

//-------------------------CHRONO 5S------------------------------------------------------------

boolean chrono5s = false;
int chrono_rattrappeur;

void Chrono5s() {
  if (millis() - chrono_rattrappeur >= 5000) {
    chrono_rattrappeur = millis();
    chrono5s = true;
    println("5s !");
  } else chrono5s = false;
}

//------------------------------AFFICHAGE MOMENTANE----------------------------------

class MomentAffichage {

  int x, y;
}
