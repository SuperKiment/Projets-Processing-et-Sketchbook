class Bouton {//Classe du bouton

  int x, y, taille;
  boolean click = false;

  Bouton(int newx, int newy, int newtaille) {
    x = newx;
    y = newy;
    taille = newtaille;
    println("créé : Bouton");
  }

  void Affichage(color couleur) {
    push();
    fill(couleur);
    rectMode(CORNER);
    rect(x, y, taille, taille);
    pop();
  }

  void DetectionSourisP() {
    if (mousePressed == true && mouseButton == LEFT) {
      if (mouseX > x && mouseY > y && mouseX < x+taille && mouseY < y+taille) {  
        click = true; //                  //Detection de si le bouton est pressé ou pas
      }                                     //A mettre dans le pressed et le released
    } else click = false;
  }

  boolean Click() {
    return click;
  }

  void Curseur() {
    if (mouseX > x && mouseY > y && mouseX < x+taille && mouseY < y+taille) {
      cursor(HAND);    //Verif de si la souris est sur le bouton
    }
  }
}




Bouton bouton1 = new Bouton(200, 200, 50);

void BoutonsConstant() {
  //bouton1.Affichage(color(0, 255, 0));  //Fonctions des boutons
  //bouton1.Curseur();
}

void BoutonsDetection() {
  //bouton1.DetectionSourisP();     //Fonctions de détéction ponctuelles
}
