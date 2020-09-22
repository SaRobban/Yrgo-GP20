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

int score = 0;
int hiScore = 0;

int state = 1; //1game start 2game 3 gameoever


enum GameState{
	Start, MainGame, GameOver
}

void setup(){
	size(640,480);
	frameRate(60);
	mainGameInit();
}


void mainGameInit(){
	emyBallManager = new BallManager(numberOfBalls);
	plBall = new PlayerBall(10, color(255, 0, 0, 255), new PVector(320,240), new PVector(0,1), 20, 3);
}


void draw(){
	deltaTime = ((millis() - timeSinceStart) * 0.001f);
	intervall += deltaTime;

	//check game state
	if(state == 1){
			runStartScreen(timeSinceStart * 0.01);
		if(space){
			changeGameState();
			space = false;

		}
	}else if(state == 2){
		runMainGame();
		if(!plBall.playerIsAlive()){
			changeGameState();
		}
	}else{
		GameOver(score);
		if(space){
			changeGameState();
			space = false;
		}
	}


	//print("state " + state, space);
	endTime();
}


void endTime(){
	timeSinceStart = millis();
}


void changeGameState(){
	state++;
	if(state > 3){
		state = 1;
	}

	//Reset
	if(state == 2)
		mainGameInit();
}


void runStartScreen(float anim){
	background(64,96,128,255);

	//text
	fill(255, 200, 153,255);
	textSize(96);
	text("Goldfish", 100, 200);
	textSize(32); 
	text("in bubble hell", 275, 230); 
	float ani = sin(anim) + 1;

	ani = lerp(255, 128, ani * 0.5);

	fill(255, ani, 153,255);
	textSize(48);
	text("Press any key", 150, 400); 
}


void runMainGame(){
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
		
	score = emyBallManager.GetNumberOfBalls();
	HUD(plBall.GetHp(), emyBallManager.GetNumberOfBalls());
}


//font = loadFont("LetterGothicStd-32.vlw");
void GameOver(int wave){
	fill(255, 0, 0,255);
	textSize(48);
	text("GameOver", 150, 100); 
	text("Wave: " + wave, 320, 200); 
}