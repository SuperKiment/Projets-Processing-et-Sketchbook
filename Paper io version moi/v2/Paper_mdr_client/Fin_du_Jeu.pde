/*
color[][] Grille = new color [1000][1000];
 
 void InitGrille() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 Grille[x][y] = color(0, 0, 0);
 }
 }
 }
 
 void AffichageGrille() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 push();
 fill(Grille[x][y]);
 noStroke();      
 square(x, y, 1);
 pop();
 }
 }
 }
 */

color coulVerif = color(255, 0, 0);


int[] Verif (color coulJ1, color coulJ2, color coulJ3, color coulJ4) {
  int compteurVerif = 0;
  int [] Resultats = new int[5];

  for (int x = 0; x<1000; x++) {
    for (int y = 0; y<1000; y++) {
      color couleurloc = get(x, y);
      if (couleurloc == coulJ1) {
        Resultats[0] ++;
      }
      if (couleurloc == coulJ2) {
        Resultats[1] ++;
      }
      if (couleurloc == coulJ3) {
        Resultats[2] ++;
      }
      if (couleurloc == coulJ4) {
        Resultats[3] ++;
      }
    }
  }
  println("compteurVerif : " + compteurVerif); 
  //if (compteurVerif == 0) start = false;

  for (int i = 0; i<4; i++) {
    println("Pixels J" + (i+1) + " : " + Resultats[i]);
  }

  Resultats[4] = compteurVerif;
  return Resultats;
}

//-------------------------------------------------------------------------------------------

//Gagne

boolean verifie = false;

int[] ResultatsFin = new int [5];
int[] Proportion = new int [4];

void Gagne() {

  if (verifie == false) {
    verifie = true;
    ResultatsFin = Verif(joueur.couleurligne, color(10), color(20), color(30));
  }

  push();

  fill(50);
  noStroke();

  rect(500, 500, 530, 200, 50);

  fill(255);
  textSize(23);

  text("Nombre de pixels remplis : " + ResultatsFin[4], 341, 431);

  for (int i = 0; i<4; i++) {
    text("Joueur " + (i+1)  + " : " + ResultatsFin[i], 408, 470+i*20);
  }

  pop();
}




/*
void Remise() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 color couleurloc = get(x, y);
 if (couleurloc == color(coulVerif)) { 
 push();
 noStroke();
 fill(0, 0, 0);
 square(x, y, 1);
 println("Remis sûr mdr");
 pop();
 }
 }
 }
 }
 */
