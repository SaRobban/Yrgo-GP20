//Using the input example from the lesson. Make it so a circle/character can move left-right-up-down.
//Create input that gives the circle/character acceleration when it moves.
//Make it deaccelerate down to a standstill when no key is pressed.
//Use deltaTime to control movement every update.



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

	if(inputAxis.magSq() != 0){
		//moveDir = inputAxis.copy();
		acc += deltaTime * 0.1;
		if(acc > 1){
			acc = 1;
		}
		//FUKK IT TILL TOMOROW!!!
		//float rad = PVector.angleBetween(inputAxis, moveDir);
		//float fullCircle = 2 * PI;
		//Use scalar inst....// float a = atan2(inputAxis.x - moveDir.x, inputAxis.y - moveDir.y);
		//moveDir.rotate(rad * 0.25);
		moveDir = inputAxis.copy();

	}else{
		acc -= deltaTime * 0.1;
		if(acc < 0){
			acc = 0;
		}
	}

	print(acc);
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
	circle(pos.x, pos.y, 5);
}



