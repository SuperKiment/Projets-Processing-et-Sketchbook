// ============================================
// InputManager.pde - Système d'input abstrait
// ============================================

InputManager inputManager;

class InputManager {
  PlayerInput[] joueurs = new PlayerInput[MAX_JOUEURS];
  int nbJoueursActifs = 2;

  InputManager() {
    // Joueur 1 : ZQSD + C pour tir
    joueurs[0] = new PlayerInput(0);
    joueurs[0].AssignerClavier(
      new ToucheClavier('z'),
      new ToucheClavier('s'),
      new ToucheClavier('q'),
      new ToucheClavier('d'),
      new ToucheClavier('c'),
      new ToucheClavier('v')
    );

    // Joueur 2 : Flèches + Entrée pour tir
    joueurs[1] = new PlayerInput(1);
    joueurs[1].AssignerClavier(
      new ToucheClavier(UP),
      new ToucheClavier(DOWN),
      new ToucheClavier(LEFT),
      new ToucheClavier(RIGHT),
      new ToucheClavier(ENTER),
      new ToucheClavier(SHIFT)
    );

    for (int i = 2; i < MAX_JOUEURS; i++) {
      joueurs[i] = new PlayerInput(i);
    }
  }

  void MettreAJour() {
    for (int i = 0; i < MAX_JOUEURS; i++) {
      joueurs[i].MettreAJour();
    }
  }

  void FinFrame() {
    for (int i = 0; i < MAX_JOUEURS; i++) {
      joueurs[i].FinFrame();
    }
    FinFrameManettes();
  }

  void OnKeyPressed(char k, int kc) {
    for (int i = 0; i < MAX_JOUEURS; i++) {
      joueurs[i].OnKeyPressed(k, kc);
    }
  }

  void OnKeyReleased(char k, int kc) {
    for (int i = 0; i < MAX_JOUEURS; i++) {
      joueurs[i].OnKeyReleased(k, kc);
    }
  }

  PlayerInput GetJoueur(int id) {
    if (id >= 0 && id < MAX_JOUEURS) return joueurs[id];
    return null;
  }

  String DescriptionJoueur(int id) {
    PlayerInput pi = joueurs[id];
    String desc = "";
    if (pi.utiliseManette && pi.manette != null && pi.manette.connectee) {
      desc = "Manette: " + pi.manette.nom;
    }
    if (pi.clavier != null) {
      String clavDesc = (id == 0) ? "Clavier ZQSD" : (id == 1) ? "Clavier Fleches" : "Clavier";
      desc = desc.length() > 0 ? desc + " + " + clavDesc : clavDesc;
    }
    return desc.length() > 0 ? desc : "Vide";
  }

  boolean JoueurActif(int id) {
    PlayerInput pi = joueurs[id];
    return pi.clavier != null || (pi.utiliseManette && pi.manette != null && pi.manette.connectee);
  }
}

// --- Touche clavier ---

class ToucheClavier {
  char caractere;
  int code;
  boolean estCodee;

  ToucheClavier(char c) { caractere = c; estCodee = false; }
  ToucheClavier(int c)  { code = c; estCodee = true; }

  boolean Correspond(char k, int kc) {
    if (estCodee) return (k == CODED && kc == code);
    else return (k == caractere);
  }
}

// --- Input d'un joueur ---

class PlayerInput {
  int joueurId;
  boolean utiliseManette = false;

  // État unifié
  boolean avancer, reculer, gauche, droite;
  boolean tir;
  boolean tirMaintenu;
  boolean special;
  boolean pause;

  float axeX, axeY;

  ToucheClavier[] clavier;
  ManetteNative manette;

  boolean[] touchesMaintenues = new boolean[6];
  boolean tirPresse = false;

  PlayerInput(int id) { joueurId = id; }

  void AssignerClavier(ToucheClavier av, ToucheClavier re, ToucheClavier ga, ToucheClavier dr, ToucheClavier ti, ToucheClavier sp) {
    clavier = new ToucheClavier[6];
    clavier[0] = av; clavier[1] = re; clavier[2] = ga;
    clavier[3] = dr; clavier[4] = ti; clavier[5] = sp;
  }

  void AssignerManette(ManetteNative m) {
    manette = m;
    utiliseManette = true;
  }

  void RetirerManette() {
    manette = null;
    utiliseManette = false;
  }

  void RetirerClavier() {
    clavier = null;
  }

  void ReassignerClavier(ToucheClavier av, ToucheClavier re, ToucheClavier ga, ToucheClavier dr, ToucheClavier ti, ToucheClavier sp) {
    AssignerClavier(av, re, ga, dr, ti, sp);
  }

  void OnKeyPressed(char k, int kc) {
    if (clavier == null) return;
    for (int i = 0; i < 6; i++) {
      if (clavier[i].Correspond(k, kc)) {
        touchesMaintenues[i] = true;
        if (i == 4) tirPresse = true;
      }
    }
  }

  void OnKeyReleased(char k, int kc) {
    if (clavier == null) return;
    for (int i = 0; i < 6; i++) {
      if (clavier[i].Correspond(k, kc)) {
        touchesMaintenues[i] = false;
      }
    }
  }

  void MettreAJour() {
    if (utiliseManette && manette != null && manette.connectee) {
      MettreAJourManette();
    } else if (clavier != null) {
      MettreAJourClavier();
    }
  }

  void MettreAJourManette() {
    float deadzone = 0.3;

    // Xbox Linux joydev mapping :
    // Axes: 0=LX, 1=LY, 2=LT, 3=RX, 4=RY, 5=RT, 6=DpadX, 7=DpadY
    // Boutons: 0=A, 1=B, 2=X, 3=Y, 4=LB, 5=RB, 6=Back, 7=Start, 8=Xbox, 9=LS, 10=RS

    float stickX = manette.axes[0];
    float stickY = manette.axes[1];
    float dpadX  = manette.axes[6];
    float dpadY  = manette.axes[7];

    axeX = stickX;
    axeY = stickY;

    avancer = (stickY < -deadzone) || (dpadY < -deadzone);
    reculer = (stickY > deadzone)  || (dpadY > deadzone);
    gauche  = (stickX < -deadzone) || (dpadX < -deadzone);
    droite  = (stickX > deadzone)  || (dpadX > deadzone);

    // Tir : A, RB, ou gâchette droite
    boolean triggerDroit = manette.axes[5] > 0.3;
    tirMaintenu = manette.boutons[0] || manette.boutons[5] || triggerDroit;
    tir = manette.boutonsPresses[0] || manette.boutonsPresses[5];

    // Spécial : B, LB, ou gâchette gauche
    boolean triggerGauche = manette.axes[2] > 0.3;
    special = manette.boutons[1] || manette.boutons[4] || triggerGauche;

    // Pause : Start (bouton 7)
    pause = manette.boutonsPresses[7];
  }

  void MettreAJourClavier() {
    avancer = touchesMaintenues[0];
    reculer = touchesMaintenues[1];
    gauche  = touchesMaintenues[2];
    droite  = touchesMaintenues[3];
    tirMaintenu = touchesMaintenues[4];
    tir = tirPresse;
    special = touchesMaintenues[5];
    pause = false;
  }

  void FinFrame() {
    tirPresse = false;
    pause = false;
  }
}

void Setup_InputManager() {
  inputManager = new InputManager();
  InitManettes();
}
