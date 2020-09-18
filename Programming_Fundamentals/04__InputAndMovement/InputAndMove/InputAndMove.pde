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

void setup(){

	size(640,480);
	moveStep = new PVector(0,0);
	moveDir = new PVector(1,0);
	pos = new PVector(0,240);
	frameRate(60);
}

void draw(){
	deltaTime = ((millis() - time) * 0.001f);

	background(0);

	if(inputAxis.magSq() != 0){
		//moveDir = inputAxis.copy();
		acc += deltaTime * accTime;
		if(acc > 1){
			acc = 1;
		}
		float rad = PVector.angleBetween(inputAxis, moveDir);
		PVector bendDir = inputAxis.copy();

		bendDir.set(-bendDir.y, bendDir.x);
		if(bendDir.dot(moveDir) > 0){
			rad *=-1;
		}
		//moveDir.rotate(rad * turnSpeed * deltaTime);

		moveDir.set(lerp(moveDir.x, inputAxis.x, turnSpeed * deltaTime), lerp(moveDir.y, inputAxis.y, turnSpeed * deltaTime));
		//moveDir = inputAxis.copy();

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


void endTime(){
	time = millis();
}
void plPos(PVector pos){
	circle(pos.x, pos.y, 20);
}
