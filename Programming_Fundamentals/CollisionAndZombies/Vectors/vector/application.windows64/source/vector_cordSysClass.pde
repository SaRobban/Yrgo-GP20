//Class cordinatSystem
class XYaxlar{
	PVector origo;
	PVector xAxis;
	Arrow arrowX;
	PVector yAxis;
	Arrow arrowY;
	int cordScale;

	Point pOne;
	Point pTwo;

	color cBgA;
	color cBgB;
	color colArrow;
	int arrowThickness;

	Direction direction;
	DirectionNormalized directionNormal;
	SqrMagnitude sqrMagnitude;
	BDisplay distance;
	BDisplay dotProduct;

	//scalar
	//angle

	//Constructor
	XYaxlar(int origoX, int origoY, int endX, int endY, int scal, color cBgA, color cBgB){
 
		this.origo = new PVector(origoX, origoY);
		this.xAxis = new PVector(endX, origoY);
		this.yAxis = new PVector(origoX, endY);
		this.cordScale = scal;
		this.cBgA = cBgA;
		this.cBgB = cBgB;
		this.colArrow = color(255, 255, 0, 255);
		this.arrowThickness = 3;

		this.direction = new Direction(origoX, endY + 20, 140, 40, color(255, 128, 0));
		this.directionNormal = new DirectionNormalized(origoX + 160, endY + 20, 140, 40, color(255, 255, 0));
		this.sqrMagnitude = new SqrMagnitude(origoX, endY + 80, 300, 40, color(255, 64, 0), origo.copy());

		this.distance = new BDisplay(origoX, endY + 140, 300, 40, color(255, 32, 0));
	}

	int GetSizeX(){
		return (int)xAxis.x;
	}

	int GetSizeY(){
		return (int)yAxis.y;
	}

	void DrawXY(){

		//DrawGrid BG
		stroke(cBgB);
		strokeWeight(1);
		for(int x = 0; x < xAxis.x - cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		//Draw Boxes and functions
		direction.draw(cBgB);
		directionNormal.draw(cBgB);
		sqrMagnitude.draw(cBgB);
		//distance.draw(cBgB);


		//Draw Vectors
		if(pOne != null){
			pOne.draw();
			pOne.drawCord();
		}

		if(pTwo != null){
			pTwo.draw();
			pTwo.drawCord();
		}
	}

	

	void Clicked(float x, float y, boolean rc, boolean lc){
		//Clicked functions
		if(pOne != null && pTwo != null){
			direction.clicked(x, y);
			directionNormal.clicked(x,y);
			sqrMagnitude.clicked(x,y);
		}


		//Clicked vectorfield
		if(Contains(x, y, origo.x, xAxis.x, origo.y, yAxis.y)){
			int posX = round(x * 0.1);
			int posY = round(y * 0.1);
			posX *= 10;
			posY *= 10;
			
			if (lc) {
				if(pOne == null){
					pOne = new Point("V1", posX, posY, offset, 5.0, color(0,255,0,255), cordScale);
				}
				pOne.setPosition(posX, posY, offset);
			}
			else if (rc) 
			{
				if(pTwo == null){
					pTwo = new Point("V2", posX, posY, offset, 5.0, color(255,0,0,255), cordScale);
				}
				pTwo.setPosition(posX, posY, offset);
			}
		}
		Calculate();
	}


	void Calculate(){
		if(pOne != null && pTwo != null){

			PVector vectOne = new PVector(pOne.getFakePosX(), pOne.getFakePosY());
			PVector vectTwo = new PVector(pTwo.getFakePosX(), pTwo.getFakePosY());

			//Direction
			direction.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			directionNormal.setColorOther(direction.getColorBase());
			directionNormal.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			sqrMagnitude.setColorOther(direction.getColorBase());
			sqrMagnitude.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());



		}
	}

	boolean Contains(float posX, float posY, float minX, float maxX, float minY, float maxY){
		if(posX < maxX && posX > minX){
			if(posY < maxY && posY > minY)
				return true;
		}
		return false;
	}

	/*
			PVector dir = PVector.sub(vectTwo, vectOne);
			directionV = PVector.add(pOne.GetPosition(), dir);
			direction.SetText(
				"Direction", 
				"   V1",
				"V2","",
				"  -   = direction\n" + 
				"dirX" + nf(dir.x,0,1) + " dirY" + nf(dir.y,0,1)
			);

			//Direction Normalized
			

			PVector dirN = dir.copy();
			dirN.normalize();
			directionNV = PVector.add(pOne.GetPosition(), PVector.mult(dirN, cordScale + arrowThickness * 2));//compansate for arrow shotening
			directionNormal.setColorOther(direction.getColorBase());

			directionNormal.SetText(
				"Direction normalized", "","",
				"dir  dir",
				"   /√   ² = normalized" +"\n" + "dirX" + nf(dirN.x,0,2) + "  dirY" + nf(dirN.y,0,2)
			);
			

			//sqrMagnitude
			PVector compDir = vectOne.copy();
			float compSqr = compDir.magSq();
			compDir.mult(-1);
			float vecSqr = dir.magSq();
			compDir.normalize();

			
			sqrMagnitude.setColorOther(direction.getColorBase());

			if(compSqr < vecSqr){
				sqrMagnitude.SetText(
					"Squared Magnitude","\nV1",
					"\n                           V2 ", 
					"Direction Direction",
					"         *          = Squared Magnitude" + "\n" + 
					"   is closer to Origo then     (" + nf(vecSqr,0,2) + ")"
				);
			}else{
				sqrMagnitude.SetText(
					"Squared Magnitude",
					"\nV1",
					"\n                V2",
					"Direction Direction",
					"         *          = SquaredMagnitude" + "\n" + 
					"   is closer to    then Origo  (" + nf(vecSqr,0,2) + ")"
				);
			}
			sqrMagnitudeVOne = PVector.add(pOne.GetPosition(), PVector.mult(dirN, vecSqr * cordScale));
			sqrMagnitudeVTwo = PVector.add(pOne.GetPosition(), PVector.mult(compDir, compSqr * cordScale));

			//Magnitude
			float dist = dir.mag();
			distance.setColorOther(sqrMagnitude.getColorBase());
			distance.SetText(
				"Distance","\n" + 
				"V1", "\n" +
				"               V2 = ",
				"  SquaredMagnitude",
				"√                   = Correct Distance" + "\n" + 
				"   distance to    = " +  nf(dist,0,2)
			);

			*/

}
