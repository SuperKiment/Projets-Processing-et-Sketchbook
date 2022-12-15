class Terrain {

  int x, y;
  String terre, herbe, roche;
  String[][] Grille;
  int compteurGrille = 0;

  Terrain() {
  }

  void InitGrille(int newx, int newy) {
    x = newx;
    y = newy;
    Grille = new String [newx][newy];

    for (int x1 = 0; x1<x; x1++) {
      for (int y1 = 0; y1 < y; y1++) {
        Grille[x1][y1] = "herbe";
        println("herbe");
        
        compteurGrille++;
        println(compteurGrille);
        
      }
    }
  }

  void Affichage() { 
    for (int x1 = 0; x1 < x; x1++) {
      for (int y1 = 0; y1 < y; y1++) {
        push();
        
        fill(125);

        switch(Grille[x1][y1]) {
        case "herbe":
          fill(0, 255, 0);
          break;
        case "sol":
          fill(#C1A30C);
          break;
        }

        translate(-joueur1.xSui+475, -joueur1.ySui+475);
        strokeWeight(2);
        stroke(0);
        rect(x1*50, y1*50, 50, 50);
        pop();
      }
    }
  }
}
