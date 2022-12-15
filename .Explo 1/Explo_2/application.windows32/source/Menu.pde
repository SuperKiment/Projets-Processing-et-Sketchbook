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
