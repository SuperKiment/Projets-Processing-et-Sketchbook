GameManager gameManager;

enum GameState {
  Pause, Play, Title, Inventory;
}

class GameManager {

  GameState state;

  GameManager() {
    state = GameState.Play;
  }

  void setState(GameState s) {
    state = s;
  }
  void setPlay() {
    state = GameState.Play;
  }
  void setPause() {
    state = GameState.Pause;      //Sets
  }
  void setTitle() {
    state = GameState.Title;
  }
  void setInventory() {
    state = GameState.Inventory;
  }

  boolean isPlay() {
    if (state == GameState.Play) return true;
    else return false;
  }
  boolean isPause() {
    if (state == GameState.Pause) return true;
    else return false;
  }
  boolean isTitle() {
    if (state == GameState.Title) return true;
    else return false;
  }
  boolean isInventory() {
    if (state == GameState.Inventory) return true;
    else return false;
  }


  GameState State() {
    return state;                   //Get state
  }

  void PreUpdate() {
    if (inputControl.b) {
      setInventory();
    }
  }

  void PostUpdate() {
    if (!inputControl.b && isInventory()) {
      setPlay();
    }
  }
}
