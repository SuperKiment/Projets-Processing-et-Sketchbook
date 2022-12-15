Timer timer = new Timer();

class Timer {
  int temps;
  int antimillis;
  int highscore1 = 0;
  int highscore2 = 0;
  int highscore3 = 0;

  Timer() {
  }

  void Go() {
    antimillis = millis();
  }

  void Time() {
    temps = millis() - antimillis;
    push();
    fill(blanc);
    textSize(20);
    text("Temps en vie : "+temps/1000+"s", 50, 110);
    text("Highscore (difficulté 1) : "+highscore1/1000+"s", 50, 140);
    text("Highscore (difficulté 2) : "+highscore2/1000+"s", 50, 170);
    text("Highscore (difficulté 3) : "+highscore3/1000+"s", 50, 200);
    pop();
  }


  void Stop() {
    if (difficulte == 1 && temps > highscore1) highscore1 = temps;
    if (difficulte == 2 && temps > highscore2) highscore2 = temps;
    if (difficulte == 3 && temps > highscore3) highscore3 = temps;
  }
}
