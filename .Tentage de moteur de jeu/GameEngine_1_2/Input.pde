class Input {
  Input() {
  }

  Key z = new Key('z');
  Key q = new Key('q');
  Key s = new Key('s');    //Je sais pas encore à quoi ça va servir
  Key d = new Key('d');    //Mais c'est stylé

  class Key {
    char cle;
    boolean pressed = false;
    Key(char ch) {
      cle = ch;
    }
  }
}

Input input = new Input();

//=====================================================

void keyPressed() {
  if (key == 'z') input.z.pressed = true;
  if (key == 'q') input.q.pressed = true;
  if (key == 's') input.s.pressed = true;     //Faudra faire un mapping de char à tableau à boolean
  if (key == 'd') input.d.pressed = true;     //Qu'est-ce que j'ai raconté moi ? Je sais plus ce que j'ai écrit

  if (key == ' ') {
    if (mondeActif.name.equals("monde1")) {
      SwitchMonde(AllMondes.get("monde2"));
    } else if (mondeActif.name.equals("monde2")) {
      SwitchMonde(AllMondes.get("monde1"));
    }
  }
}
void keyReleased() {
  if (key == 'z') input.z.pressed = false;
  if (key == 'q') input.q.pressed = false;
  if (key == 's') input.s.pressed = false;
  if (key == 'd') input.d.pressed = false;
}

void mousePressed() {
  camera.SwitchFocus();
}
