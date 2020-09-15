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

	void SetForce(float fX, float fY){
		forceV.set(fX, fY);
	}

	void AddForces(float g, float drag){
		forceV.mult(1 - drag);
		forceV.set(forceV.x, forceV.y + g);
		pos.add(forceV);
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

	void Draw(){

		deformX *= 0.1;
		deformY *= 0.1;

		noStroke();
		fill(ballColor);

		ellipse(pos.x, pos.y, radius *2 + deformX, radius *2 + deformY);
	}
}