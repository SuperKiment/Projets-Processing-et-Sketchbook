Camera camera;

class Camera {
  Ensemble focus;
  PVector cible, ecran, translate;

  float cameraSpeed = 0.1;

  Camera() {
    focus = map.AllEnsembles.get(0);

    cible = new PVector(-focus.pos.x * map.tailleCase + width/2, -focus.pos.y * map.tailleCase+height/2);

    translate = cible;
  }

  void Update() {
    cible = new PVector(-focus.pos.x * map.tailleCase + width/2, -focus.pos.y * map.tailleCase+height/2);

    translate.lerp(cible, cameraSpeed);
  }

  String Print() {
    return "Camera Focus : " + focus.Print();
  }

  void Translate() {
    translate(translate.x, translate.y);
  }

  void SwitchFocus(Ensemble e) {
    focus = e;
  }
}
