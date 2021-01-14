interface WalkerInterface {
  //returns the name of the walker, should be your name!
  String getName();

  //returns the start position for the walker
  PVector getStartPosition(int playAreaWidth, int playAreaHeight);

  //updates the walker position
  //the walker is only allowed to take one step, left/right or up/down
  //If the walker moves diagonally or too long, it will be killed.
  PVector update();
}
