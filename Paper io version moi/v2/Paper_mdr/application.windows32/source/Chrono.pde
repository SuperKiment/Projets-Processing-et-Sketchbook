int tempsgo = 0;
int compteur = 10;
int secondes = 0;

int triche = 0;



void Chrono() {

  //int postsecondes = secondes;
  int limite = 180;

  secondes = int((millis() - tempsgo)/1000) + triche;

  push();
  noStroke();
  fill(255);
  rect(500, 50, 200, 50, 20);

  fill(2);
  textSize(40);
  text(secondes, 480, 64);
  pop();

  if (secondes >= limite) {
    start = false;
    gagne = true;
  }

  /*
  if (compteur == 200) {
   Verif(1000000);
   println("Verifié !");
   }
   
   if (compteur == 210) {
   println("Remis !");
   //Remise();
   compteur = 0;
   }
   
   if (postsecondes != secondes) {
   compteur++;
   println("compteur : " + compteur);
   postsecondes = secondes;
   }
   
   postsecondes = secondes;*/
}
