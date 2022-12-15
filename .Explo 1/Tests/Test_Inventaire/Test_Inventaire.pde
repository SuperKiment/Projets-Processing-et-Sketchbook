/*Inventaire inventaire = new Inventaire();;
 
 class Inventaire {
 String[] Interieur = {"rouge", "rouge", "bleu", "rouge", "rouge", "vert", "rouge", "rouge", "bleu", };
 
 Inventaire() {
 }
 
 void Aff() {
 for (int i = 0; i < 9; i++) {
 
 Case(Interieur[i]);
 
 if (i<3) rect(i*100+100, 100, 90, 90);
 if (i<6 && i>=3) rect(i*100-300+100, 200, 90, 90);
 if (i<=8 && i>=6) rect(i*100-600+100, 300, 90, 90);
 }
 }
 
 void Case(String truc) {
 switch (truc) {
 case "rouge":
 fill(255, 0, 0);
 break;
 
 case "bleu":
 fill(0, 0, 255);
 break;
 
 case "vert":
 fill(0, 255, 0);
 break;
 }
 }
 
 void Rect() {
 rect(100, 100, 100, 100);
 }
 }*/


void setup() {
  size(500, 500);
  background(0);
  stockTest.IniCases();
}

void draw() {
  background(0);
  StockageInterfaces();
}

void keyPressed() {
  if (key == ' ') stockTest.ActifInactif();
  if (key == 'e') {
    stockTest.Ajouter("epee", 3);
    println("e");
  }
  if (key == 'f') {
    stockTest.Ajouter("bouclier", 4);
    println("f");
  }
}
