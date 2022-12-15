class Perso {
  int x;
  int y;
  boolean click = false;
  int no;
  color couleur;


  Perso(int newx, int newy, int newno, color newcouleur) {
    x = newx;
    y = newy;
    no = newno;
    couleur = newcouleur;
  }


  void Deplacement() {

    if (keyPressed == true && click == false && no == 1) {
      if (key == 'z' && y > 0 && Tableau[x][y-1] != 1) { 
        y = y - 1; 
        click = true;
      }
      if (key == 'q' && x > 0 && Tableau[x-1][y] != 1) {
        x = x - 1; 
        click = true;
      }
      if (key == 's' && Tableau[x][y+1] != 1) {
        y = y + 1; 
        click = true;
      }
      if (key == 'd' && Tableau[x+1][y] != 1) {
        x = x + 1; 
        click = true;
      }
    }
    
    if (keyPressed == true && click == false && no == 2) {
      if (key == 'o' && y > 0 && Tableau[x][y-1] != 1) { 
        y = y - 1; 
        click = true;
      }
      if (key == 'k' && x > 0 && Tableau[x-1][y] != 1) {
        x = x - 1; 
        click = true;
      }
      if (key == 'l' && Tableau[x][y+1] != 1) {
        y = y + 1; 
        click = true;
      }
      if (key == 'm' && Tableau[x+1][y] != 1) {
        x = x + 1; 
        click = true;
      }
    }

    if (Tableau[x][y] == 1) x = x+1;
  }

  void Affichage() {
    fill(couleur);
    rect(x*50-5, y*50-5, 60, 60);
  }
}

color or = color(253, 226, 0);
color rose = color(253, 226, 0);
Perso perso1 = new Perso(5, 5, 1, or);
Perso perso2 = new Perso(10, 10, 2, rose);

void Perso() {
  perso1.Deplacement();
  perso1.Affichage();

  perso2.Deplacement();
  perso2.Affichage();
}
