color noir = #000000;
color blanc = #FFFFFF;
float translateX, translateY;
int intervalleEnnemi = 100, timerEnnemi;

void setup() {
  fullScreen();
  //size(1000, 1000);
}

void draw() {
  background(noir);
  translateX = width/2;
  translateY = height/2;

  if (ecran == "Jeu") {
    push();
    translate(translateX, translateY);
    push();
    stroke(blanc);
    line(-translateX, 0, translateX, 0);
    line(0, -translateY, 0, translateY);
    pop();
    joueur.Fonctions();
    VieFonctions();
    EnnemiFonctions();
    timer.Time();
    pop();
  }

  Interface();
}
