class PlayerBall{
	int radius;
	color col;
	PVector pos;
	PVector dir;
	float speed;
	float scaleSpeed;

	int hp;

	PVector graphicDir;
	float anim;


	PlayerBall(int r, color c, PVector p, PVector d, float s, int hp){
		this.radius = r;
		this.col = c;
		this.pos = p;
		this.dir = d.normalize();
		this.speed = s;
		this.hp = hp;
		this.graphicDir = d.copy();
	}
	
	PVector GetPosition(){
		return pos.copy();
	}

	int GetRadius(){
		return radius;
	}

	public int GetHp(){
		return hp;
	}


	void Restrict(int maxRoomX, int maxRoomY){
		//Restrict room
		if(this.pos.x <= this.radius){
			this.dir.x *= -1;
		}else if(this.pos.x >= maxRoomX - this.radius){
			this.dir.x *=-1;
		}

		if(this.pos.y <= this.radius){
			this.dir.y *= -1;
		}else if(this.pos.y > maxRoomY - this.radius){
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
			this.scaleSpeed = 1;//ImpactSpeed
			this.hp--;
		}
	}

	void ControllBall(PVector inputAxis, float maxSpeed, float accTime, float deAccTime, float turnSpeed, float deltaTime){
		if(inputAxis.magSq() != 0){
			
			if(scaleSpeed <= 1){
				scaleSpeed += deltaTime * accTime;
				//scaleSpeed = 1;
			}

			dir.set(lerp(dir.x, inputAxis.x, turnSpeed * deltaTime), lerp(dir.y, inputAxis.y, turnSpeed * deltaTime));
			graphicDir = dir.copy();
			graphicDir = graphicDir.normalize();

			
		}else{
			scaleSpeed -= deltaTime * deAccTime;
			if(scaleSpeed < 0){
				scaleSpeed = 0;
			}
		}


		PVector d = dir.copy();
		d.mult(scaleSpeed * maxSpeed);
		this.pos.add(d);

		anim += scaleSpeed * 0.5;
	}

	void DrawBall(float t){
		noStroke();
		fill(col);

		PVector[] gfx = new PVector[4];
		for(int i = 0; i < 4; i++){
			gfx[i] = graphicDir.copy();
			gfx[i].rotate(0.5*PI * i);
			
		}
		ellipse(pos.x, pos.y, radius*2, radius*2);
		
		float floppyValue = 2 * (sin(anim) + 5 + scaleSpeed);
		//fin
		quad(pos.x - gfx[0].x * radius, pos.y - gfx[0].y * radius,
			
			pos.x - gfx[1].x * (radius + 8) - gfx[0].x *5,
			pos.y - gfx[1].y * (radius + 8) - gfx[0].y *5,

			pos.x - gfx[2].x * radius, pos.y - gfx[2].y * radius,
			
			pos.x - gfx[3].x * (radius + 5) - gfx[0].x *floppyValue,
			pos.y - gfx[3].y * (radius + 5) - gfx[0].y *floppyValue);

		for(int u = 0; u<4;u++){
			gfx[u].add(graphicDir);
		}
		//back fin
		floppyValue = 2 * (sin(anim +1) + 2 + scaleSpeed);		

		quad(pos.x - gfx[0].x * radius, pos.y - gfx[0].y * radius,
			
			pos.x - gfx[1].x * radius - gfx[0].x *floppyValue,
			pos.y - gfx[1].y * radius - gfx[0].y *floppyValue,

			pos.x - gfx[2].x * radius, pos.y - gfx[2].y * radius,
			
			pos.x - gfx[3].x * radius - gfx[0].x *floppyValue,
			pos.y - gfx[3].y * radius - gfx[0].y *floppyValue);

		fill(255,255,255,128);
		ellipse(pos.x + 2, pos.y - 5, 10, 5);

		fill(255,255,255,255);
		ellipse(pos.x + dir.x * 10, pos.y + dir.y * 10, 10, 10);
	
		fill(0);
		ellipse(pos.x + dir.x * 12, pos.y + dir.y * 12, 5, 5);
	}
}