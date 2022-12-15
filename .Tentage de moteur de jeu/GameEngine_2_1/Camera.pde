Camera camera = new Camera();

class Camera {

  float translX, translY;

  Entite focus;

  Camera() {
  }

  void Setup_Focus(Entite entite) {
    focus = entite;                //Setup /shrug
  }

  void Focus(Entite entite) {
    focus = entite;            //Focus sur une certaine entite
  }

  void Translate() {
    if (focus != null) {
      translX = width/2-focus.position.x;     //Positionne l'entite focus au milieu de l'écran
      translY = height/2-focus.position.y;
      translate(translX, translY);
    }
  }

  void SwitchFocus() {
    for (Entite entite : mondeActif.AllEntites) {
      if (entite.IsClicked()) {
        focus = entite;                     //Si on click sur un entite focus = l'entite clickée
        println("Switch de focus");
      }
    }
  }
}
