String ecran = "Ecran Titre";
int difficulte = 1;
color gris_fonce = #222222;

void Interface() {
  if (ecran == "Ecran Titre") {
    push();
    background(noir);
    stroke(blanc);
    fill(noir);
    rectMode(CENTER);
    rect(translateX, translateY, 600, 400);
    fill(blanc);
    textSize(50);
    text("JEU RAGEANT", translateX-155, translateY+17);
    textSize(20);
    text("SPACE pour commencer", translateX-113, translateY+185);

    fill(noir);
    rect(translateX, translateY-500+794, 329, 160);
    fill(blanc);
    textSize(40);
    text("DIFFICULTE", translateX-500+387, translateY-500+765);
    for (int i = 1; i<=3; i++) {
      int tremblement = 0;

      fill(noir);
      if (difficulte == i) {
        fill(gris_fonce);
        tremblement = 2;
      }
      float offsetX = random(-tremblement, tremblement), 
        offsetY = random(-tremblement, tremblement);
      rect(translateX-500+i*100+300+offsetX, translateY-500+828+offsetY, 50, 50);
      fill(blanc);
      text(i, translateX-500+i*100+288+offsetX, translateY-500+842+offsetY);
    }
    pop();
  }

  if (ecran == "Mort") {
    push();
    int tremblement = 7;
    float offsetX = random(-tremblement, tremblement), 
      offsetY = random(-tremblement, tremblement);

    background(noir);
    stroke(blanc);
    fill(noir);
    rectMode(CENTER);
    rect(translateX, translateY, 600, 400);
    fill(blanc);
    textSize(80);
    text("MORT", translateX-500+389+offsetX, translateY-500+532+offsetY);
    textSize(20);
    text("SPACE pour aller à l'écran titre", translateX-500+355, translateY-500+685);
    pop();
  }
}
