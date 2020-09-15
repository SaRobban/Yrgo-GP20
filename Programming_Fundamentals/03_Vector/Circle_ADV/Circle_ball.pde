class Ball{
	float radius;
	PVector pos;
	PVector forceV;

	float deformY;
	float deformX;

	color ballColor = color(255, 255, 255);

	Ball(float r, float posX, float posY){
		this.radius = r;
		this.pos = new PVector(posX, posY);
		this.deformX = 0;
		this.deformY = 0;
		this.forceV = new PVector(0,0);
	}

	void SetPosition(float x, float y){
		pos.set(x,y);
	}

	void AddPosition(float x, float y){
		pos.x += x;
		pos.y += y;
	}

	void SetForce(float fX, float fY){
		forceV.set(fX, fY);
	}

	void AddForces(float g, float drag){
		forceV.mult(1 - drag);
		forceV.set(forceV.x, forceV.y + g);
		//pos.add(forceV);
	}

	//thx. Joni @ stackoverflow //https://stackoverflow.com/questions/61272597/calculate-the-bouncing-angle-for-a-ball-point
	PVector bounce(PVector n, PVector v) {
		PVector norm = new PVector(n.x, n.y);
		PVector travel = new PVector(v.x, v.y);

  		PVector tmp = norm.mult(-2 * travel.dot(norm));
		tmp.add(v);
	    return tmp;
	}


	void Collided(PVector n, PVector p, PVector c){
		

		float movePosX = c.x;//n.x * radius;
		float movePosY = c.y;//n.y * radius;
	
		this.AddPosition(movePosX, movePosY);
		
		forceV.set(bounce(n, forceV));


	}

	void SetColor(color col){
		this.ballColor = col;
	}

	float GetRadius(){
		return radius;
	}

	PVector GetPosition(){
		return pos;
	}

	float GetPositionX(){
		return pos.x;
	}

	float GetPositionY(){
		return pos.y;
	} 

	void CalculateStep(){
		pos.add(forceV);
	}

	void Draw(){

		deformX *= 0.1;
		deformY *= 0.1;

		noStroke();
		fill(ballColor);

		ellipse(pos.x, pos.y, radius * 2 + deformX, radius * 2 + deformY);
	}
}