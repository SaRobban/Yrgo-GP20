	//Start by making a copy from the "Input and Movement" lesson assignment, so we get a character that we can move on the screen.
	//Create a player class and move as much code out from the main file as possible.

	//(Let time and delta time still be calculated in the main file)
	
	//Add the Ball class from this lesson.
	
//Add size and color to the ball class.
	
	//Make the ball class handle bounces at the edge of the screen.
	
	//Create 10 balls that can bounce around the screen.
	//Check if the player collides with a ball.
	//Make some kind of Game Over screen when the player gets hit.


//Using the input example from the lesson. Make it so a circle/character can move left-right-up-down.
//Create input that gives the circle/character acceleration when it moves.
//Make it deaccelerate down to a standstill when no key is pressed.
//Use deltaTime to control movement every update.

PlayerBall plBall;
float plAccTime = 1; //seconds till full speed or stop is rached
float plDeAccTime = 2; 
float plTurnSpeed = 4; 
float plMaxSpeed = 5;

long timeSinceStart;
float deltaTime;
float intervall;

BallManager emyBallManager;
int numberOfBalls = 1;


void setup(){
	size(640,480);
	frameRate(60);
	emyBallManager = new BallManager(numberOfBalls);
	plBall = new PlayerBall(10, color(255, 0, 0, 255), new PVector(320,240), new PVector(0,1), 20, 3);
}

void draw(){
	deltaTime = ((millis() - timeSinceStart) * 0.001f);
	intervall += deltaTime;

	if(intervall > 3){
		emyBallManager.AddBall();
		emyBallManager.NumberOfBalls();
		intervall = 0;
	}

	background(64,96,128,255);
	
	plBall.ControllBall(inputAxis, plMaxSpeed, plDeAccTime, plDeAccTime, plTurnSpeed, deltaTime);
	plBall.Restrict(width, height);

	emyBallManager.MovePositions(deltaTime);
	emyBallManager.CheckSelfCollitionsAnd(plBall);
	emyBallManager.DrawBalls();

	plBall.DrawBall(timeSinceStart * 0.01f);
	


	HUD(plBall.GetHp(), emyBallManager.GetNumberOfBalls());

	endTime();
}


void endTime(){
	timeSinceStart = millis();
}
/*
void LoopBalls(float dt){
	for(int b = 0; b < balls.length; b++){
		for(int bOther = 0; bOther < balls.length; bOther++){
			if(bOther != b){
				balls[b].CheckCollision(balls[bOther].GetPosition(), balls[bOther].GetRadius());
			}
		}
		playerBall.CheckCollision(balls[b].GetPosition(), balls[b].GetRadius());
	}

	for(int i = 0; i < balls.length; i++){
		balls[i].MovePos(100, dt);
		balls[i].DrawBall();
	}
}
*/