class Ball{
	int radius;
	color col;
	PVector pos;
	PVector dir;
	float speed;

	Ball(int r, color c, PVector p, PVector d, float s){
		this.radius = r;
		this.col = c;
		this.pos = p;
		this.dir = d;
		this.speed = s;
	}

	
	PVector GetPosition(){
		return pos.copy();
	}


	int GetRadius(){
		return radius;
	}


	void MovePos(float deltaT){
		PVector d = dir.copy();
		d.mult(speed * deltaT);
		pos.add(d);
	}


	void Restrict(int maxRoomX, int maxRoomY){
		//Restrict room
		if(this.pos.x <= radius){
			if(this.dir.dot(1,0,0) <= 0)
				this.dir.x *= -1;
		}else if(this.pos.x >= maxRoomX - radius){
			if(this.dir.dot(-1,0,0) <= 0)
				this.dir.x *= -1;
		}

		if(this.pos.y <= radius){
			if(this.dir.dot(0,1,0) <= 0)
				this.dir.y *= -1;
		}else if(this.pos.y > maxRoomY - radius){
			if(this.dir.dot(0,-1,0) <= 0)
				this.dir.y *= -1;
		}

	}


	void CheckCollision(PVector posOther, float rOther){
		

		float minDist = radius + rOther;
		minDist *= minDist;

		PVector dirBetween = posOther.sub(pos);
		//Optimized???????
		if(dirBetween.x > minDist && dirBetween.y > minDist){
			return;
		}

		float  distBetween = dirBetween.magSq();

		if(distBetween < minDist){
			this.col = color(255,255,0,255);
			this.dir = dirBetween.normalize();
			this.dir.mult(-1);
		}
	}


	void DrawBall(){
		strokeWeight(3);
		stroke(128,192,255,255);
		//fill(col);
		fill(128,192,255,128);
		ellipse(pos.x, pos.y, radius*2, radius*2);
		fill(255,255,255,64);
		ellipse(pos.x + radius*0.5, pos.y - radius * 0.5, 5,3);
	}
}