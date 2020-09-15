//Class cordinatSystem
class XYaxlar{
	PVector origo;
	PVector xAxis;
	PVector yAxis;
	int cordScale;

	Point pOne;
	Point pTwo;

	color colOne;
	color colTwo;

	BDisplay direction; 
	BDisplay sqrMagnitude;
	BDisplay distance;

	//scalar
	//angle
	

	//Constructor
	XYaxlar(int origoX, int origoY, int endX, int endY, int scal, color cOne, color cTwo){
 
		this.origo = new PVector(origoX, origoY);
		this.xAxis = new PVector(endX, origoY);
		this.yAxis = new PVector(origoX, endY);
		this.cordScale = scal;
		this.colOne = cOne;
		this.colTwo = cTwo;

		this.direction = new BDisplay(origoX, endY + 20, 200, 20);
		this.sqrMagnitude = new BDisplay(origoX, endY + 60, 200, 40);

		this.distance = new BDisplay(origoX, endY + 120, 200, 40);
	}

	void DrawXY(){
		stroke(colOne);
		for(int x = 0; x < xAxis.x -cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		Arrow(origo, xAxis, color(colTwo));
		Arrow(origo, yAxis, color(colTwo));

		if(pOne != null){
			pOne.Draw();
			pOne.DrawCord();
		}

		if(pTwo != null){
			pTwo.Draw();
			pTwo.DrawCord();
		}



		//Draw Boxes
		direction.Draw(colOne, colTwo);
		sqrMagnitude.Draw(colOne, colTwo);
		distance.Draw(colOne, colTwo);
	}

	int GetSizeX(){
		return (int)xAxis.x;
	}

	int GetSizeY(){
		return (int)yAxis.y;
	}

	void Clicked(float x, float y, boolean rc, boolean lc){
		if(Contains(x, y, origo.x, xAxis.x, origo.y, yAxis.y)){

			int posX = round(x * 0.1);
			int posY = round(y * 0.1);
			posX *= 10;
			posY *= 10;
			
			if (lc) {
				if(pOne == null){
					pOne = new Point(posX, posY, offset, 5.0, color(0,255,0,255), cordScale);
				}
				pOne.setPosition(posX, posY, offset);
			}
			else if (rc) 
			{
				if(pTwo == null){
					pTwo = new Point(posX, posY, offset, 5.0, color(255,0,0,255), cordScale);
				}
				pTwo.setPosition(posX, posY, offset);
			}
		}

		Calculate();
	}


	void Calculate(){
		if(pOne != null && pTwo != null){

			PVector vectOne = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			PVector vectTwo = new PVector(pTwo.GetFakePosX(), pTwo.GetFakePosY());

			PVector dir = vectTwo.sub(vectOne);
			direction.SetText("Direction", ("V2 - V1 = " + "dirX " + dir.x + " dirY " + dir.y));// ("V1 - V2 = " +(String)dir));

			

			PVector comp = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			float compSqr = comp.magSq();
			float vecSqr = dir.magSq();

			if(compSqr < vecSqr){
				sqrMagnitude.SetText("Squared Magnitude", ("Dir * Dir = " + vecSqr + "\n" + "V1 is closer to Origo then V2"));
			}else{
				sqrMagnitude.SetText("Squared Magnitude", ("Dir * Dir = " + vecSqr + "\n" + "V1 is closer to V2 then Origo"));
			}

			float dist = dir.mag();
			distance.SetText("Distance", "√ (dir * dir) = " + dist + "\n" + "V1 distance to V2");
		}
	}
}
