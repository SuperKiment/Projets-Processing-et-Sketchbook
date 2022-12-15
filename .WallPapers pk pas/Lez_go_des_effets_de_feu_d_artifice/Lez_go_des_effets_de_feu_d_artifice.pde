void setup() {
  size(600, 600);
  background(0);
  rectMode(CENTER);
  noStroke();
}

float timerOpac = 0, timeToOpac = 100, vitesseOpac = 20;
float timerBlack = 0, timeToBlack = 5000;

void draw() {

  TimerOpac();

  for (int i = 0; i<Feux.size(); i++) {
    FeuArtifice feu = Feux.get(i);

    feu.Update();

    if (feu.Mort()) Feux.remove(i);
  }
}

void TimerOpac() {
  if (millis() - timerOpac > timeToOpac) {
    timerOpac = millis();
    push();
    fill(0, 0, 0, vitesseOpac);
    rectMode(CORNER);
    rect(0, 0, width, height);
    pop();
  }
  
  if (millis() - timerBlack > timeToBlack) {
    timerBlack = millis();
    BackgroundBlack();
  }
}

void BackgroundBlack() {
  if (Feux.size() == 0) {
    background(0);
    println("Reset fond");
  }
}

ArrayList<FeuArtifice> Feux = new ArrayList<FeuArtifice>();

public class FeuArtifice {

  PVector pos;
  float puis, nombre = 20;
  ArrayList<Particule> Particules = new ArrayList<Particule>();
  boolean mort;

  FeuArtifice(float x, float y) {
    pos = new PVector(x, y);
    nombre = int(random(nombre/2, nombre*2));
    puis = 10;

    for (int i = 0; i<nombre; i++) {
      Particules.add(new Particule());
    }

    println("feu");
  }

  public void Update() {
    push();
    translate(pos.x, pos.y);

    for (int i = 0; i<Particules.size(); i++) {
      Particule part = Particules.get(i);

      part.Update();

      if (part.Mort()) Particules.remove(i);
    }

    if (Particules.size() == 0) {
      mort = true;
      BackgroundBlack();
      println("a plus feu");
    }

    pop();
  }

  boolean Mort() {
    return mort;
  }
}

public class Particule {

  private PVector pos, dir, vel, apos;
  private float speed, angleN, timer, timeLimit, timeStart, taille, fluctuation = 2;
  private float maxTime = 3, maxTaille = 5, maxSpeed = 5;
  private color couleur;
  private boolean mort;

  Particule() {
    speed = random(maxSpeed/3, maxSpeed*2);

    pos = new PVector(0, 0);
    apos = new PVector(0, 0);
    dir = PVector.random2D();
    vel = dir.setMag(speed);
    couleur = color(int(random(50, 255)), int(random(50, 255)), int(random(50, 255)));
    taille = random(maxTaille/1.5, maxTaille*1.5);
    timeLimit = random(maxTime/2, maxTime*2);
    fluctuation = random(fluctuation/1.5, fluctuation*1.5);

    timeStart = millis();
  }

  public void Update() {
    Timer();
    Deplacement();
    Display();
  }

  public boolean Mort() {
    return mort;
  }

  private void Timer() {
    timer = (millis() - timeStart)/1000;
    if (timer > timeLimit) mort = true;
  }

  private void Deplacement() {
    apos = pos;

    float angleRange = timer*fluctuation;
    angleN = random(-angleRange, angleRange);

    dir.rotate(angleN);
    vel = dir.setMag(speed);

    pos.add(vel);
  }

  private void Display() {
    push();

    fill(couleur);
    rect(pos.x, pos.y, taille, taille);

    stroke(couleur);
    line(pos.x, pos.y, apos.x, apos.y);

    pop();
  }
}

void mousePressed() {
  Feux.add(new FeuArtifice(mouseX, mouseY));
  
  timerBlack = millis();
}
