class Heart {
	
	public PVector pos;

	public PVector[] points;

	public float pointStep  = 1;

	//public float a = 0.8f;

	public Heart(float posX, float posY, int numOfPoints){
		this.pos = new PVector(posX, posY);
		this.points = new PVector[numOfPoints];

		for(int i = 0; i < numOfPoints; i++){
			points[i] = new PVector();
		}
	}

	public void Update(float a) {

		float start = -2;
		float step = (1 / points.length) * 4 - start;

		for(int i = 0; i < points.length; i++){
			float x = i*step;
			points[i].set(x, pow(x, 2/3) + 0.9f * pow(3.3f - pow(x, 2), 1/2) * sin(a * PI * x));
		}	
	}

	public void Draw(){
		pushMatrix();
		translate(pos.x, pos.y);

		int a = 0;
		for(int b = 0; b < points.length; b++){
			line(points[a].x * pointStep, points[a].y * pointStep, points[b].x * pointStep, points[b].y * pointStep);
			a = b;
		}

		//line(0,0,100,100);

		popMatrix();
	}
}
