void TranslateArPl(boolean mob) {
  if (!mob) {
    translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25);
  }

  if (mob) {
    translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25, 1);
  }
}

void TitePhrases() {
  String[] PhrasesDebut = loadStrings("Random Titres.txt");
  int noRand = int(random(0, PhrasesDebut.length-1));

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
  }

  void HeureChange() {
    xHeure += vitesseAstre;
    xheure = (cos(xHeure)+1)*12;
    xHeure += vitesseAstre;
    yheure = (sin(xHeure)+1)*12;

    if (xHeure == 2*PI) xHeure = 0;

    xPos = xheure/12-1;
    yPos = xheure/12-1;
    zPos = yheure/12-1;
  }

  void Lumiere() {
    directionalLight(r, g, b, xPos, yPos, zPos);
  }
}

int luminosite = 100;

Astre Soleil = new Astre(10000, 255-luminosite, 248-luminosite, 222-luminosite, PI);
Astre Soleil2 = new Astre(10000, 255-luminosite, 248-luminosite, 222-luminosite, PI+PI/6);
Astre Lune = new Astre(10000, 159-luminosite, 155-luminosite, 216-luminosite, 0);
Astre Lune2 = new Astre(10000, 159-luminosite, 155-luminosite, 216-luminosite, PI/6);
