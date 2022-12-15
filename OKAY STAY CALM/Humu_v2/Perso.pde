class Personnage {
  
  int x = 100;
  int y = 600;
  int mvtx;
  int mvty;
  
  
  Personnage(int nouvx, int nouvy, int nouvmvtx, int nouvmvty) {
    
    x = nouvx;
    y = nouvy;
    mvtx = nouvmvtx;
    mvty = nouvmvty;
    
  }
  
  void DeplacementX() {
    
    x += mvtx;
    
  }
  
}
