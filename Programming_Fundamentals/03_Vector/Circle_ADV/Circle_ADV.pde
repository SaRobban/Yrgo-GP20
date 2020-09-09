//Draw a line from the circle to the mouse while the mouse button is pressed.
//Calculate the vector between the circle and the mouse.
//Teleport the circle to the mouse when you press the mouse button.
//Use the vector to give the circle direction (movement).
//Adjust the speed in a way so it doesn't go too fast.
//But still make it so a longer line makes it go faster then a short line.
//Draw a circle (ellipse) on screen.
//Make the circle bounce on the edges of the screen.

int frame = 0;
int trailIntervall = 3;
int trailLength = 100;
float  trailColNum;

float gravity = 0.1;
float ballRadius = 55;
float ballH = 55;
float ballW = 55;

PVector ballPos;
PVector force;
PVector ballMovement;
float speedAdjust = 0.1;

int offsett = 40;
color bgC = color(48, 64, 32, 255);
color bgCa = color(48, 64, 32, 0);
color ballC = color(128, 255, 128, 255);
color lineOneC = color(0, 255,0, 128);
color lineTwoC = color(0, 255, 0, 255);

PVector trail[];

void setup(){
  size(640, 480);
  ballPos = new PVector(320,240);
  force = new PVector(0,0);
  ballMovement = new PVector(0,0);

  trail = new PVector[trailLength];
  for(int i = 0; i < trail.length; i++){
    trail[i] = new PVector(320,240);
  }

  trailColNum = 1.000000 / trailLength;
}

void draw(){
  background(bgC);

  //Add force vector to move ball position each frame
  force.y += gravity;
  force.mult(0.99); // draft
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
      
/*
      //Draws line form screen middle to ball
      stroke(lineOneC);
      strokeWeight(2);
      line(halfWidth, halfHeight, ballPos.x, ballPos.y);
    */  
      //Draws our force vector to middle of screen
      stroke(lineTwoC);
      strokeWeight(6);
      line(halfWidth, halfHeight, halfWidth + force.x, halfHeight + force.y);

      PVector arrowHead = new PVector();
      arrowHead.set(force);
      arrowHead.normalize();
      arrowHead.mult(25);
      arrowHead.rotate(PI * 0.75);
      line(halfWidth + force.x, halfHeight + force.y, halfWidth + force.x + arrowHead.x, halfHeight + force.y + arrowHead.y);
      arrowHead.rotate(PI * 0.5);
      line(halfWidth + force.x, halfHeight + force.y, halfWidth + force.x + arrowHead.x, halfHeight + force.y + arrowHead.y);


      force.mult(speedAdjust);

      ZeroTrail(ballPos);
  }

  //restrict room
  if((ballPos.x > width - offsett) || (ballPos.x < offsett)){
    force.x *= -1;
    ballW = ballRadius - 20;
    ballH = ballRadius + 20;
    frame = trailIntervall;
  }
  
  if(ballPos.y < -200){
    force.y *= -1;
    ballW = ballRadius + 20;
    ballH = ballRadius - 20;
    frame = trailIntervall;
  }
  
  if(ballPos.y > height - offsett) {
    force.y *= -1;
    ballW = ballRadius + 20;
    ballH = ballRadius - 20;
    frame = trailIntervall;

    ballPos.y = height - offsett;
  }

  

  if(ballW > ballRadius)
    ballW -= 1;
  if(ballW < ballRadius)
    ballW += 1;
  if(ballH > ballRadius)
    ballH -= 1;
  if(ballH < ballRadius)
    ballH += 1;

//Set trial/////////////////////////////////////////////////////////
  if(frame >= trailIntervall){
    for(int i = trail.length-1; i > 0; i--){
      trail[i].set(trail[i-1]);
    }
    trail[0].set(ballPos);
    frame = 0;
  }

//draw trail
  stroke(lineTwoC);
  for(int t = trail.length-1; t > 0; t--){

    stroke(lerpColor(ballC, bgC, trailColNum * t));
    strokeWeight(10);
    line(trail[t].x, trail[t].y, trail[t-1].x, trail[t-1].y);
  }
/////////////////////////////////////////////////////////////////////


//draw Circle/ ball
  //circle(ballPos.x, ballPos.y, ballRadius);
  stroke(ballC);
  fill(bgC);
  ellipse(ballPos.x, ballPos.y, ballW, ballH);

  frame++;
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


void ZeroTrail(PVector pos){
  for(int i = 0; i < trail.length; i++){
    trail[i].set(pos);
  }
}