void Fond() {
  for (int i = 0; i < 50; i++) {
    pushMatrix();
    translate(joueur.x, joueur.y);
    stroke(200);
    line(-1000, i*100, 5000, i*100);   //Grille pour voir le déplacement  
    line(i*100, -1000, i*100, 5000);
    fill(255);
    
    
    text(i*100, i*100 + 10, 10);       //Coordonnées des lignes
    text(i*100, 10, i*100 + 10);
    
    popMatrix();
  }
}
