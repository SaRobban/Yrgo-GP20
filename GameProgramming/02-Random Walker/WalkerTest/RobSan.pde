class Example implements WalkerInterface {

  //Add your own variables here.
  //Do not use processing variables like width or height
  int pAWidth;
  int pAHeight;

  PVector myPos;
  PVector mulVector;
  int x = 0;
  
  String getName()
  {
    return "RobSan"; //When asked, tell them our walkers name
  }

  PVector getStartPosition(int playAreaWidth, int playAreaHeight)
  {
    this.pAWidth = playAreaWidth;
    this.pAHeight= playAreaHeight;
    
    
    //Select a starting position or use a random one.
    float x = (int) random(0, playAreaWidth);
    float y = (int) random(0, playAreaHeight);
    
    myPos = new PVector(x,y);

    mulVector = new PVector(1,1);
    //a PVector holds floats but make sure its whole numbers that are returned!
    return new PVector((int)myPos.x, (int)myPos.y);
  }

  PVector update()
  {
    //add your own walk behavior for your walker here.
    //Make sure to only use the outputs listed below.
    if(myPos.x > (pAWidth -1))
    {
      mulVector.x = -1;
    }
    else if(myPos.x < 1)
    {
      mulVector.x = 1;
    }else{
      if((int)random(0, 100) == 1)
      mulVector.x *= -1;
    }

    if(myPos.y > (pAHeight -1))
    {
      mulVector.y = -1;
    }
    else if(myPos.y < 1)
    {
      mulVector.y = 1;
    }

    x++;
    if(x >= 8){
      x = 0;
    }

    PVector newPos = new PVector();
    //Score closest to 0 but above 1
    if(x < 4){
        newPos.set(1,0);
    }else if( x < 6){
       newPos.set(0,1);
    }else if(x < 7){
       newPos.set(-1,0);
    }else{
       newPos.set(0,-1);
    }

    newPos.x *= mulVector.x;
    newPos.y *= mulVector.y;
    myPos.add((int)newPos.x, (int)newPos.y);

    return new PVector(newPos.x, newPos.y);
  }
}

//All valid outputs:
// PVector(-1, 0);
// PVector(1, 0);
// PVector(0, 1);
// PVector(0, -1);

//Any other outputs will kill the walker!
