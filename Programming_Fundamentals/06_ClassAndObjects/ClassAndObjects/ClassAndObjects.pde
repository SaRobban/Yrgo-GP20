//Add size and color to the ball class.
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

//thx. Jacob Lundberg och Robin Bono
enum GameState{
	Title, GameInit, MainGame, SaveLoad, GameOver, MainInit
};

GameState gState = GameState.Title;

//enum 
void setup(){
	size(640,480);
	frameRate(60);
	mainMenuInit();
	gState = GameState.Title;
}

void mainMenuInit(){
	emyBallManager = new BallManager(100);
	print("numberOfBalls: ", emyBallManager.GetNumberOfBalls(), "\n");
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
			runStartScreen();
		if(space){
			changeGameState();
		}
	}else if (gState == GameState.GameInit) {
		mainGameInit();
		changeGameState();
	
	}else if(gState == GameState.MainGame){
		runMainGame();
		if(!plBall.playerIsAlive()){
			changeGameState();
		}
	}else if(gState == GameState.SaveLoad){
		saveAndLoad();
		changeGameState();
	
	}else if (gState == GameState.GameOver){
		gameOver(score, hiScore, timeSinceStart * 0.01);
		if(space){
			changeGameState();
		}
	}else if(gState == GameState.MainInit){
			mainMenuInit();
			changeGameState();
	}

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
        	gState = GameState.GameInit;
       		break;

   		case GameInit :
       		gState = GameState.MainGame;
       		break;

        case MainGame :
	        gState = GameState.SaveLoad;
        	break;	

        case SaveLoad :
        	gState = GameState.GameOver;
        	break;

        case GameOver :
        	gState = GameState.MainInit;
        	break;

        case MainInit : 
        	gState = GameState.Title;
        	break;

        default :
       		gState = GameState.Title;
    }
}


void runStartScreen(){

	background(64,96,128,255);

	emyBallManager.MovePositions(deltaTime);
	emyBallManager.RestrictBalls();
	emyBallManager.DrawBalls();

	//text
	textAlign(CENTER, CENTER);
	
	textSize(96);
	fill(0, 0, 0, 32);
	text("Goldfish", width * 0.5 + 5, height * 0.5 - 155);
	fill(255, 180, 100,255);
	text("Goldfish", width * 0.5, height * 0.5 - 160);

	textSize(32); 
	fill(0, 0, 0, 32);
	text("in bubble hell", width * 0.5 + 90, height * 0.5 - 95); 
	fill(255, 180, 100,255);
	text("in bubble hell", width * 0.5 + 85, height * 0.5 - 100); 
	

	//Press to start
	textSize(48);
	fill(0, 0, 0, 32);
	text("Press space", width * 0.5, height * 0.5);

	float ani = sin(timeSinceStart * 0.01) + 1;
	float aniC = ani * 32;
	fill(aniC + 192, aniC + 64, aniC, 255);
	
	text("Press space", width * 0.5 - ani, height * 0.5 - ani); 
	
}


void runMainGame(){
	if(intervall > 3){
		emyBallManager.AddBall();
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


void saveAndLoad(){
	hiScore = LoadHiScore();
	if(hiScore < score){
		SaveHiScore(score);
	}
}

//font = loadFont("LetterGothicStd-32.vlw");
void gameOver(int currentScore, int oldScore, float anim){
	fill(255,0,0,3);
	rect(0, 0, width, height);

	fill(0, 0, 0, 1);
	textSize(62);
	textAlign(CENTER, CENTER);
	text("Your fish is dead!!", width * 0.5 + 5, 155);

	fill(255, 128, 0,255);
	text("Your fish is dead!!", width * 0.5, 150); 
	textSize(48);


	if(oldScore > currentScore){
		text("Your Score: " + currentScore, width *0.5, 250);
		text("HighScore: " + oldScore, width * 0.5, 320);
	}else{
		text("New HiScore: " + currentScore, width *0.5, 250);
		text("OldHighScore: " + oldScore, width * 0.5, 320);
	}
	
	//Press to start
	textSize(48);
	fill(0, 0, 0, 1);
	text("Press space", width * 0.5, height * 0.5 + 150);

	float ani = sin(anim) + 1;
	float aniC = ani * 32;
	fill(aniC + 192, aniC + 64, aniC, 255);
	
	text("Press space", width * 0.5 - 2, height * 0.5 + 148); 
}