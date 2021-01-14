class Example implements WalkerInterface {

  //Add your own variables here.
  //Do not use processing variables like width or height
  int pAWidth;
  int pAHeight;
  
  String getName()
  {
    return "SaRobban"; //When asked, tell them our walkers name
  }

  PVector getStartPosition(int playAreaWidth, int playAreaHeight)
  {
    this.pAWidth = playAreaWidth;
    this.pAHeight= playAreaHeight;
    
    //Select a starting position or use a random one.
   // float x = (int) random(0, playAreaWidth);
   // float y = (int) random(0, playAreaHeight);
    
    float x = (int) random(0, 15);
    float y = (int) random(0, 15);

    //a PVector holds floats but make sure its whole numbers that are returned!
    return new PVector(x, y);
  }

  PVector update()
  {
    //add your own walk behavior for your walker here.
    //Make sure to only use the outputs listed below.
    
    //Score closest to 0 but above 1
    

    switch((int)random(0, 4)) {
    case 0:
      return new PVector(-1, 0);
    case 1:
      return new PVector(1, 0);
    case 2:
      return new PVector(0, 1);
    default:
      return new PVector(0, -1);
    }
    
    
    
  }
}

//All valid outputs:
// PVector(-1, 0);
// PVector(1, 0);
// PVector(0, 1);
// PVector(0, -1);

//Any other outputs will kill the walker!
