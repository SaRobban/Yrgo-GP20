//Draw a circle (ellipse) on screen.
//Teleport the circle to the mouse when you press the mouse button.
//	Draw a line from the circle to the mouse while the mouse button is pressed.
//Calculate the vector between the circle and the mouse.
//Use the vector to give the circle direction (movement).
//Adjust the speed in a way so it doesn't go too fast.
//But still make it so a longer line makes it go faster then a short line.
//	Make the circle bounce on the edges of the screen.

float ballRadius = 55;
PVector ballPos;
PVector force;
PVector ballMovement;

PVector mousePos;
//en vector är int x, int y

int offsett = 40;

float speedAdjust = 0.1;


color bgC = color(48, 64, 32, 255);
color ballC = color(128, 255, 128, 255);
color lineOneC = color(0, 255,0, 128);
color lineTwoC = color(0, 255, 0, 255);

void setup(){
	size(640, 480);
   	ballPos = new PVector(0,0);
   	force = new PVector(0,0);
   	ballMovement = new PVector(0,0);
}

void draw(){
  background(bgC);
  if(ballRadius > 55){
  		ballRadius -= 1;
  }


  //Add force vector to move ball position each frame
  ballPos.add(force);

  
  //If our mousebutton is pressed 
  if(mousePressed){
  	//screen center cords
  	float halfWidth = width * 0.5;
  	float halfHeight = height * 0.5;

  	//Our balls new position is mouse position
    ballPos.set(mouseX, mouseY);
	ballPos.set(ScreenRestrictions(ballPos));

	//Our force vector is screencenter - ball position
    force.set(halfWidth - ballPos.x, halfHeight - ballPos.y);
    force.mult(speedAdjust);

	//Draws line form screen middle to ball
	stroke(lineOneC);
    line(halfWidth, halfHeight, ballPos.x, ballPos.y);

    //Draws our force vector to middle of screen
    stroke(lineTwoC);
    line(halfWidth, halfHeight, halfWidth + force.x, halfHeight + force.y);

    PVector arrowHead = new PVector();
    arrowHead.set(force);
    arrowHead.normalize();
    arrowHead.mult(25);
    arrowHead.rotate(PI * 0.75);
    line(halfWidth + force.x, halfHeight + force.y, halfWidth + force.x + arrowHead.x, halfHeight + force.y + arrowHead.y);
    arrowHead.rotate(PI * 0.5);
    line(halfWidth + force.x, halfHeight + force.y, halfWidth + force.x + arrowHead.x, halfHeight + force.y + arrowHead.y);
    
  }

  //restrict room
  if((ballPos.x > width - offsett) || (ballPos.x < offsett)){
  	force.x *= -1;
  	ballRadius = 65;
  }
  if((ballPos.y > height - offsett) || (ballPos.y < offsett)){
  	force.y *= -1;
  	ballRadius = 65;
  }

  //draw Circle/ ball
  circle(ballPos.x, ballPos.y, ballRadius);
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