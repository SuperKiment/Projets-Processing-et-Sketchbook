void Informations_Pour_Le_Joueur_Visuelles() {
  strokeWeight(5);
  stroke(#2CB773);
  fill(#38E894);
  ellipse(1700, 725, 200, 100);
  textSize(50);
  fill(255);
  if (ComptNbPerso <= 9) text(String.valueOf(ComptNbPerso), 1685, 745);
  if (ComptNbPerso >  9) text(String.valueOf(ComptNbPerso), 1672, 745);
  
  textSize(35);
  text ("Somme des cartes", 1562, 650);
}
