class Branch{
	PVector offsett;
	int spiralEvery = 10;

	float sinCurveClimb = 20;
	float sinCurvestep = 20;
	float sinCurveFreq = 0.25f;
	float step;

	int numberOfPoints = 100;
	int flip = 1;
	float spiralExpand = 1;
	float spiralRadius = 25.0;
	float spiralStep = 0.1;
	float spiralBias = 1;

	public float red = 32;
	public float green = 64;
	public float blue = 255;

	Branch(PVector offsett, int numberOfPoints, int spiralEvery){
		this.offsett = offsett;
		this.sinCurvestep = height / (float)(numberOfPoints-1.0f);
		this.step = 1 / (float)(numberOfPoints-1.0f);
		print(sinCurvestep);
	}

	void Draw(float animValue){
		stroke(32,192,192);
		int a = 0;

		PVector pOne = new PVector();
		PVector pTwo = new PVector();

		int flip = 1;



		for(int b = 1; b < numberOfPoints; b++){

			float c = 95 + (95 * sin(PI * a * step + animValue));
  			stroke(color(red, green + c, blue, 255));



			pOne.set(sin(a * sinCurveFreq - animValue *0.25) * sinCurveClimb *(numberOfPoints - a) * step, a * sinCurvestep);
			pTwo.set(sin(b * sinCurveFreq - animValue *0.25) * sinCurveClimb *(numberOfPoints - a) * step, b * sinCurvestep);

			pOne.add(offsett);
			pTwo.add(offsett);

			line(pOne.x, pOne.y, pTwo.x, pTwo.y);

			//Spiral down
			if(a % spiralEvery == 1){

				PVector normal = new PVector(pOne.x - pTwo.x, pOne.y -pTwo.y); 
				normal.set(normal.y, normal.x * -1);
				normal.normalize();

				if(flip < 0){
					normal.x *=-1;
					normal.y *=-1;
				}	
				SpiralFromAnchor(1 + sin(animValue * sinCurveFreq) * 0.5, pOne.x, pOne.y, normal.x, normal.y, flip, a, animValue);
				flip *=-1;
			}
			a=b;
		}
	}

	void SpiralFromAnchor(float curveing, float offX, float offY, float normalX, float normalY, int flip, int cAnim, float animValue){
		

		float shrinkS;
		PVector pOne = new PVector(0, 0);
		PVector pTwo = new PVector(normalX * spiralExpand, normalY * spiralExpand);

		PVector nMod = new PVector(0, 1);
		PVector n = new PVector(normalX, normalY);
		//line(offX, offY, offX+n.x*100, offY+n.y*100 );
		float angle = new PVector().angleBetween(nMod, n);
		if(n.x > 0){
			angle *=-1;
		}

		pushMatrix();
		translate(offX + n.x * spiralRadius * curveing, offY + n.y * spiralRadius * curveing); 
		rotate(angle);

		float curv = (curveing * -0.5f +1);
		int a = 0;
		for(int b = 1; b < numberOfPoints; b++){
			float c = 95 + (95 * sin(PI * (cAnim - a) * step + animValue));
  			stroke(color(red, green + c, blue, 2 * numberOfPoints - 255f * b * step));

			shrinkS = spiralRadius * step * a -spiralRadius;
			pOne.x = sin(step * spiralRadius * a * flip * curv) * shrinkS * curveing;
			pOne.y = cos(step * spiralRadius * a * flip * curv) * shrinkS * curveing;

			shrinkS = spiralRadius * step * b -spiralRadius;
			pTwo.x = sin(step * spiralRadius * b * flip * curv) * shrinkS * curveing;
			pTwo.y = cos(step * spiralRadius * b * flip * curv) * shrinkS * curveing;

			line(pOne.x, pOne.y, pTwo.x, pTwo.y);
			a=b;
		}
		popMatrix();
  }
}