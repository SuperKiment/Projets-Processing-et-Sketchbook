ArrayList<Ligne> AllLignes = new ArrayList<Ligne>();
float vitesse = 0.1;

void setup() {
  size(1000, 1000);
  background(0);
  frameRate(60);

  AllLignes.add(new Ligne(500, 1));
  AllLignes.add(new Ligne(500, 3));
  AllLignes.add(new Ligne(500, 6));
  AllLignes.add(new Ligne(500, 9));
}

void draw() {
  for (Ligne l : AllLignes) {
    //l.Update();
    l.Display();
  }
}

class Ligne {
  float val = 250, pos = 0, var = 2;
  color couleur;
  ThreadUpdate threadUpdate = new ThreadUpdate();


  Ligne(float vl, float vr) {
    val = vl;
    var = vr;
    couleur = color(random(50, 255), random(50, 255), random(50, 255));  
    threadUpdate.start();
  }

  void Update() {
    val = random(val-var, val+var);
    pos+= vitesse;
      println("fez"+random(4,5));
  }

  void Display() {
    stroke(couleur);
    point(pos, val);
  }

  class ThreadUpdate extends Thread {
    void run() {
      Update();
      println("oay"+random(4,5));
      delay(100);
    }
  }
}
