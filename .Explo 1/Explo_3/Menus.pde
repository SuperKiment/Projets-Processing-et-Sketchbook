class Menu {

  int x, y, tx, ty;

  Menu() {
  }

  void Affichage() {
    push();
    strokeWeight(5);
    stroke(190);
    fill(100);
    rectMode(CENTER);
    rect(x, y, tx, ty, 30);

    pop();
  }

  void PlacementMenu(int newx, int newy, int newtaillex, int newtailley) {
    x = newx;
    y = newy;
    tx = newtaillex;
    ty = newtailley;
  }
}

Menu MenuStart = new Menu();

//----------------------------------------------------------BARRE INVENTAIRE-------------

class BarreInventaire {

  int x, y, xtaille, ytaille, nbSlots;
  int noSlotSelect = 0;
  
  String objSelect = "herbe";

  BarreInventaire(int nx, int ny, int nxtaille, int nytaille) {
    x = nx;
    y = ny;
    xtaille = nxtaille;
    ytaille = nytaille;
  }

  void Affichage() {
    push();
    fill(125, 125, 125, 100);
    strokeWeight(5);
    stroke(200);
    rectMode(CENTER);
    rect(x, y, xtaille, ytaille);
    pop();

    for (int i = 0; i < Slots.length; i++) {
      Slots[i].Affichage();
    }
  }

  void SelectBarreInv() {
    if (mouseY > y-ytaille/2 && mouseY < y+ytaille/2 && mouseX > x-xtaille/2 && mouseX < x+xtaille/2) {
      cursor(HAND);
    }
  }

  void SelectSlot() {
    if (mouseY > y-ytaille/2 && mouseY < y+ytaille/2 && mouseX > x-xtaille/2 && mouseX < x+xtaille/2) {
      int pos = 0;
      for (int i = 0; i<Slots.length; i++) {
        Slots[i].select = false;
        if (mouseX<x-xtaille/2+60+i*60 && mouseX > x-xtaille/2+i*60) pos = i;
      }

      Slots[pos].Select();
    }
  }

  //----------------------------------------SLOT-------------------------------------------
  class Slot {

    int noSlot;
    String objet = "";
    boolean select = false;

    Slot(int nnoSlot, String nobjet) {
      noSlot = nnoSlot;
      objet = nobjet;
    }

    void Affichage() {
      push();
      stroke(220);
      strokeWeight(2);
      fill(50, 50, 50, 150);

      switch(objet) {
      case "herbe" :
        image(imHerbe, x-540/2+noSlot*60+7.5, y-30+7.5, 47, 47);
        break;
      case "sol" :
        image(imSol, x-540/2+noSlot*60+7.5, y-30+7.5, 47, 47);
        break;
      case "roche" :
        image(imRoche, x-540/2+noSlot*60+7.5, y-30+7.5, 47, 47);
        break;
      case "eau" :
        image(imEau, x-540/2+noSlot*60+7.5, y-30+7.5, 47, 47);
        break;
      }

      if (select) {
        fill(255, 255, 255, 50);
        stroke(255);
        strokeWeight(7);
        
        objSelect = objet;
        
      }
      rectMode(CORNER);
      rect(x-540/2+noSlot*60+2.5, y-30+2.5, 55, 55);
      pop();
    }

    void Select() {
      select = true;
    }
  }
  //-------------------------

  void SlotsIni() {

    for (int i = 0; i < Slots.length; i++) {
      Slot temp = new Slot(i, "");

      switch (i) {
      case 0:
        temp.objet = "herbe";
        break;
      case 1:
        temp.objet = "sol";
        break;
      case 2:
        temp.objet = "roche";
        break;
      case 3:
        temp.objet = "arbre";
        break;
      }

      Slots[i] = temp;
    }

    Slots[0].select = true;
  }

  Slot[] Slots = new Slot[9];

  //---------------------------------------------------------------------------------------------------------------
}

BarreInventaire barreInventaire;


void BarreInventaireAffichage() {
  barreInventaire.Affichage();
}

void BarreInventaireIni() {
  barreInventaire = new BarreInventaire(width/2, height*7/8, 540, 60);
  barreInventaire.SlotsIni();
}
