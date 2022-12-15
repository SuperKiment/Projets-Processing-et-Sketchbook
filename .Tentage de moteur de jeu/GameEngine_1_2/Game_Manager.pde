enum State {
  Title, Game, Inventory, Died;
}

static State gameState = State.Game;

static class GameManager {

  State getState() {
    return gameState;
  }
  
  //Changer le State
  void State(State s) {
    gameState = s;
  }

  void Died() {
    gameState = State.Died;
  }

  void Inventory() {
    gameState = State.Inventory;
  }

  void Title() {
    gameState = State.Title;
  }

  void Game() {
    gameState = State.Game;
  }
}
