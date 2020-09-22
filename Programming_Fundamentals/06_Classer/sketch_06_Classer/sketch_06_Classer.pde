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

//thx. Jacob Lundberg och Robin Bono
enum GameState{
	Title, MainGame, SaveLoad, GameOver
};

GameState gState = GameState.Title;

//enum 
void setup(){
	size(640,480);
	frameRate(60);
	mainGameInit();
	gState = GameState.Title;
}


void mainGameInit(){
	emyBallManager = new BallManager(numberOfBalls);
	plBall = new PlayerBall(10, color(255, 0, 0, 255), new PVector(320,240), new PVector(0,1), 20, 3);
}


void draw(){
	deltaTime = ((millis() - timeSinceStart) * 0.001f);
	intervall += deltaTime;

	//check game state
	if(gState == GameState.Title){
			runStartScreen(timeSinceStart * 0.01);
		if(space){
			changeGameState();
		}
	}else if(gState == GameState.MainGame){
		runMainGame();
		if(!plBall.playerIsAlive()){
			changeGameState();
		}
	}else if(gState == GameState.SaveLoad){
		SaveAndLoad();
		changeGameState();
	}else{
		GameOver(score, hiScore, timeSinceStart *0.001);
		if(space){
			changeGameState();
		}
	}


	//print("state " + state, space);
	endTime();
}


void endTime(){
	space = false;
	timeSinceStart = millis();
}


void changeGameState(){
	switch (gState)
    {
    	case Title:
        	gState = GameState.MainGame;
       		break;

        case MainGame :
	        mainGameInit();
	        gState = GameState.SaveLoad;
        	break;	

        case SaveLoad :
        	gState = GameState.GameOver;
        	break;

        case GameOver :
        	gState = GameState.Title;
        	break;

        default :
       		gState = GameState.Title;
    }
	
    print(" ", gState);
}


void runStartScreen(float anim){

	background(64,96,128,255);

	//text
	textAlign(CENTER, CENTER);
	fill(255, 200, 153,255);
	textSize(96);
	text("Goldfish", width * 0.5, height * 0.5 - 160);
	textSize(32); 
	text("in bubble hell", width * 0.5 + 90, height * 0.5 - 100); 
	float ani = sin(anim) + 1;

	ani = lerp(255, 128, ani * 0.5);

	fill(255, ani, 153,255);
	textSize(48);
	text("Press space", width * 0.5, height * 0.5); 
	fill(0, 0, 0, 32);
	text("Press space", width * 0.5 + 2, height * 0.5 + 4);
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

void SaveAndLoad(){
	hiScore = LoadHiScore();
	if(hiScore < score){
		SaveHiScore(score);
	}
}
//font = loadFont("LetterGothicStd-32.vlw");
void GameOver(int currentScore, int oldScore, float anim){
	fill(255,0,0,3);
	rect(0, 0, width, height);

	fill(255, 128, 0,255);
	textSize(96);
	textAlign(CENTER, CENTER);
	text("GameOver", width * 0.5, 150); 
	textSize(48);



	




	text("Score: " + currentScore, width *0.5, 250);
	text("HighScore: " + oldScore, width * 0.5, 320);

	float ani = sin(anim) + 1;
	ani = lerp(255, 128, ani * 0.5);
	fill(255, ani, 153,255);
	text("Press space", width * 0.5, height -100); 
	fill(0, 0, 0, 32);
	text("Press space", width * 0.5 +2, height -96); 
}