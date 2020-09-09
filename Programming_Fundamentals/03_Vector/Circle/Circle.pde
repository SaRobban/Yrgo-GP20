//Draw a line from the circle to the mouse while the mouse button is pressed.
//Calculate the vector between the circle and the mouse.
//Teleport the circle to the mouse when you press the mouse button.
//Use the vector to give the circle direction (movement).
//Adjust the speed in a way so it doesn't go too fast.
//But still make it so a longer line makes it go faster then a short line.
//Draw a circle (ellipse) on screen.
//Make the circle bounce on the edges of the screen.

float ballRadius = 55;

PVector ballPos;
PVector oldBallPos;

PVector force;
float forceAdjust = 0.05;
PVector ballMovement;


int offsett = 40;
color bgC = color(48, 64, 32, 255);
color ballC = color(128, 255, 128, 255);
color lineOneC = color(0, 255,0, 128);
color lineTwoC = color(0, 255, 0, 255);

void setup(){
  size(640, 480);
  ballPos = new PVector(320,240);
  oldBallPos = new PVector(320,240);
  force = new PVector(0,0);
  ballMovement = new PVector(0,0);
}

void draw(){
  background(bgC);

  //Add force vector to move ball position each frame
  ballPos.add(force);

  
  //If our mousebutton is pressed 
  if(mousePressed){

    //Our balls new position is mouse position
    ballPos.set(mouseX, mouseY);
    ballPos.set(ScreenRestrictions(ballPos));

    //Our force vector is screencenter - ball position
    force.set(oldBallPos.x - ballPos.x, oldBallPos.y - ballPos.y);
    force.mult(forceAdjust);

    //Draws line form screen middle to ball
    stroke(lineOneC);
    strokeWeight(2);
    line(oldBallPos.x, oldBallPos.y, ballPos.x, ballPos.y);
  }else{
    oldBallPos.set(ballPos);
  }

  //restrict room
  if((ballPos.x > width - offsett) || (ballPos.x < offsett)){
  	force.x *= -1;
  }
  if((ballPos.y > height - offsett) || (ballPos.y < offsett)){
  	force.y *= -1;
  }

  //draw Circle/ ball
  //circle(ballPos.x, ballPos.y, ballRadius);
  noStroke();
  fill(ballC);
  
  ellipse(ballPos.x, ballPos.y, ballRadius, ballRadius);
}


PVector ScreenRestrictions(PVector v){
if(v.x > width - offsett)
	v.x = width -offsett;

if(v.x < offsett)
	v.x = offsett;

if(v.y > height - offsett)
	v.y = height -offsett;

if (v.y < offsett)
	v.y = offsett;

return v;
}
