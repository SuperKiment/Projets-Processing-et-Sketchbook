ArrayList<Bateau> AllBateaux = new ArrayList<Bateau>();

class Bateau {

  float x = 100, y = 100, dir = 0;
  float taille = 20, dirCible = 0;
  int lvl = 1, hp = 100;

  Bateau(float nx, float ny) {
    x = nx;
    y = ny;
    dir = random(-PI, PI);
    dirCible = random(-PI, PI);
  }

  void Affichage() {
    push();
    translate(x, y);
    rotate(dir);

    fill(255);
    rect(0, 0, taille, taille);
    rect(taille, 0, taille, taille/2);

    pop();
  }

  void Print() {
    println("Bateau témoin");
    println("coord : "+x, y+" dir : "+dir);
  }

  boolean Mort() {
    if (hp <= 0) {
      return true;
    } else return false;
  }
}

void Setup_Bateaux() {
  AllBateaux.add(new Bateau(random(0, width), random(0, height)));
}

void Fonctions_Bateaux() {
  for (int i=0; i<AllBateaux.size(); i++) {
    Bateau bato = AllBateaux.get(i);
    bato.Affichage();
    if (bato.Mort()) {
      AllBateaux.remove(i);
    }
  }
}
