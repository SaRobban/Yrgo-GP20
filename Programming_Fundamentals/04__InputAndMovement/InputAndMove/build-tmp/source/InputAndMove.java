import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class InputAndMove extends PApplet {

//Using the input example from the lesson. Make it so a circle/character can move left-right-up-down.
//Create input that gives the circle/character acceleration when it moves.
//Make it deaccelerate down to a standstill when no key is pressed.
//Use deltaTime to control movement every update.

float accTime = 1; //seconds till full speed or stop is rached

float deAccTime = 2; 
float turnSpeed = 4; 

float maxSpeed = 5;

PVector moveDir;
PVector moveStep;
float acc = 0;
PVector pos;

long time;
float deltaTime;

public void setup(){

	
	moveStep = new PVector(0,0);
	moveDir = new PVector(1,0);
	pos = new PVector(0,240);
	frameRate(60);
}

public void draw(){
	deltaTime = ((millis() - time) * 0.001f);

	background(0);

	if(inputAxis.magSq() != 0){
		//moveDir = inputAxis.copy();
		acc += deltaTime * accTime;
		if(acc > 1){
			acc = 1;
		}

		//For rotation instead of lerp
		/*
		float rad = PVector.angleBetween(inputAxis, moveDir);
		PVector bendDir = inputAxis.copy();

		bendDir.set(-bendDir.y, bendDir.x);
		if(bendDir.dot(moveDir) > 0){
			rad *=-1;
		}
		//moveDir.rotate(rad * turnSpeed * deltaTime);
		*/
		moveDir.set(lerp(moveDir.x, inputAxis.x, turnSpeed * deltaTime), lerp(moveDir.y, inputAxis.y, turnSpeed * deltaTime));
		moveDir.normalize();
	}else{
		acc -= deltaTime * deAccTime;
		if(acc < 0){
			acc = 0;
		}
	}

	//print(acc);
	moveStep = moveDir.copy();
	moveStep.mult(acc * maxSpeed);
	pos.add(moveStep);


	plPos(pos);

	endTime();
}


public void endTime(){
	time = millis();
}
public void plPos(PVector pos){
	circle(pos.x, pos.y, 20);
}
PVector inputAxis = new PVector(0,0);
//keys

int left;
int right;
int up; 
int down;

public void keyPressed(){
	if(keyCode == LEFT || key == 'a'){
		left = 1;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 1;
	}

	if(keyCode == UP || key == 'w'){
		up = 1;
	}

	if(keyCode == DOWN || key == 's'){
		down = 1;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();
}


public void keyReleased(){
	if(keyCode == LEFT || key == 'a'){
		left = 0;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 0;
	}

	if(keyCode == UP || key == 'w'){
		up = 0;
	}

	if(keyCode == DOWN || key == 's'){
		down = 0;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();
}
/*
class Input{
	PVector inputAxis;
	

	Input(float x, float y){
		inputAxis = new PVector(0,0);
	}

	PVector GetInput(){

		inputAxis.set(0,0);

		if(keyCode == LEFT || key == 'a'){
			inputAxis.x -= left;
		}

		if(keyCode == RIGHT || key == 'd'){
			inputAxis.x += right;
		}

		if(keyCode == UP || key == 'w'){
			inputAxis.y -= up;
		}

		if(keyCode == DOWN || key == 's'){
			inputAxis.y += down;
		}

		inputAxis.normalize();

		
		return inputAxis.copy();
	}
}
*/
  public void settings() { 	size(640,480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "InputAndMove" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
