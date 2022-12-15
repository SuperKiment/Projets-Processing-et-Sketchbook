ArrayList<Truc> AllTrucs = new ArrayList<Truc>();

class Truc {
  
  float x, y;
  
  Truc(float nx, float ny) {
    x = nx;
    y = ny;
  }

  void Affichage() {
    rect(x, y, 50, 50);
  }
}
