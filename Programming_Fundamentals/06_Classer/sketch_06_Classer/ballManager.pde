class BallManager{
	Ball[] emyBalls;
	color baseColor = color(128,64,32,255);
	int baseRadius = 5;
	float baseSpeed = 100;


	BallManager(int numberOfBalls, int r, color c, PVector p, PVector d, float s){
		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = new Ball(r,c,p,d,s);
		}
	}

	BallManager(int numberOfBalls, int r, PVector p, float s){
		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = new Ball(r, baseColor, p, new PVector(random(0, 1), random(0, 1)), s);
		}
	}

	BallManager(int numberOfBalls){
		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = CreateRadnomBall();
		}
 	}

	void CheckSelfCollitionsAnd(){
		for(int b = 0; b < emyBalls.length; b++){
			for(int bOther = 0; bOther < emyBalls.length; bOther++){
				if(bOther != b){
					this.emyBalls[b].CheckCollision(this.emyBalls[bOther].GetPosition(), this.emyBalls[bOther].GetRadius());
				}
			}
			this.emyBalls[b].Restrict(width, height);
		}
	}

	void CheckSelfCollitionsAnd(PlayerBall playerBall){
		for(int b = 0; b < emyBalls.length; b++){
			for(int bOther = 0; bOther < emyBalls.length; bOther++){
				if(bOther != b){
					this.emyBalls[b].CheckCollision(this.emyBalls[bOther].GetPosition(), this.emyBalls[bOther].GetRadius());
				}
			}
			this.emyBalls[b].CheckCollision(playerBall.GetPosition(), playerBall.GetRadius());
			playerBall.CheckCollision(this.emyBalls[b].GetPosition(), this.emyBalls[b].GetRadius());

			this.emyBalls[b].Restrict(width, height);
		}
	}

	void MovePositions(float deltaT){
		for(int b = 0; b < emyBalls.length; b++){
			this.emyBalls[b].MovePos(deltaT);
		}
	}

	void DrawBalls(){
		for(int i = 0; i < this.emyBalls.length; i++){
			this.emyBalls[i].DrawBall();
		}
	}


	void AddBall(){
		emyBalls = (Ball[]) expand(emyBalls, emyBalls.length + 1);
		emyBalls[emyBalls.length - 1] = CreateRadnomBall();
		//emyBalls = temp;

		//this.emyBalls[b] = new Ball(baseRadius, baseColor, new PVector(100 + 10 * b, 100 + 10 * b), new PVector(random(0, 1), random(0, 1)), baseSpeed);
	}

	Ball CreateRadnomBall(){
		return new Ball((int)random(5, 20), baseColor, new PVector(100 + 10, 100 + 10), new PVector(random(0, 1), random(0, 1)), baseSpeed);
	}

	void NumberOfBalls(){
		print(emyBalls.length);
	}
}