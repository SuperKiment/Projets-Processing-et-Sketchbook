class Module {

  PVector pos, posDir, posCible;
  Player player;
  float speed, taille, distance;
  color couleur;

  Module() {
    Constructor();
  }

  Module(Player p, float t) {
    Constructor();
    player = p;
    taille = t;
  }

  void Constructor() {
    player = new Player();    
    pos = player.pos;
    posDir = new PVector();
    posCible = new PVector();
    taille = 50;
    speed = 0.02;
    couleur = color(255, 255, 255);
    distance = 2;
  }

  void Update() {
    SepareModule();
    SuivrePlayer();
  }

  void Display() {
    if (player != null) {
      push();
      stroke(0);
      strokeWeight(5);
      line(GrToSn(pos.x), GrToSn(pos.y), GrToSn(player.pos.x), GrToSn(player.pos.y));
      pop();
    }

    push();
    fill(couleur);
    noStroke();
    ellipse(GrToSn(pos.x), GrToSn(pos.y), taille, taille);
    pop();
  }

  void SuivrePlayer() {
    pos.lerp(PosCible(),0.1);
  }

  void SepareModule() {
    for (Module m : player.AllModules) {
      if (m!= this) {

        float separ = dist(GrToSn(pos.x), GrToSn(pos.y), GrToSn(m.pos.x), GrToSn(m.pos.y));
        float distO = (taille/2) + (m.taille/2);

        println(distO, separ);

        if (separ < distO) {
          float rentr = distO-separ;

          PVector react = new PVector(GrToSn(pos.x)-GrToSn(m.pos.x), GrToSn(pos.y)-GrToSn(m.pos.y));

          react.setMag(rentr);

          pos.lerp(react, speed);
        }
      }
    }
  }

  PVector PosCible() {
    PVector ret = posDir, posPix = pos;
    
    ret.setMag(distance);
    posPix.mult(map.tailleCase);
    
    ret.add(posPix);
    
    return ret;
  }
}
