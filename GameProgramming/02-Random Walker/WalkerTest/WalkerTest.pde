//This file is only for testing your movement/behavior.
//The Walkers will compete in a different program!

WalkerInterface walker;
PVector walkerPos;

void setup() {
  size(640, 480);
  frameRate(240);
  //Create a walker from the class Example it has the type of WalkerInterface
  walker = new Example();

  walkerPos = walker.getStartPosition(width /2, height/2);
}

void draw() {
  point(walkerPos.x, walkerPos.y);
  //rect(walkerPos.x *2,walkerPos.y *2,2,2);
  walkerPos.add(walker.update());
}
