//Class cordinatSystem (meat of the program)
//Draws and calculate all vectors and its sub classes.

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


	//Declare new functions here
	Direction direction;
	DirectionNormalized directionNormal;
	SqrMagnitude sqrMagnitude;
	Distance distance;
	Dot dotProduct;

	BDisplay[] dirsplayBoxes;
	//angle
	//closest point on line

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

		this.direction = new Direction(						origoX,			endY + 20, 	140, 40, color(255, 255, 0));
		this.directionNormal = new DirectionNormalized(		origoX + 160, 	endY + 20, 	180, 40, color(255, 192, 0));
		this.sqrMagnitude = new SqrMagnitude(				origoX, 		endY + 80, 	340, 40, color(255, 128, 0), origo.copy());
		this.distance = new Distance(						origoX, 		endY + 140, 340, 40, color(255, 64, 0));
		this.dotProduct = new Dot(							origoX, 		endY + 200, 340, 40, color(192, 0,64));

		this.dirsplayBoxes = new BDisplay[5];
		this.dirsplayBoxes[0] = this.direction;
		this.dirsplayBoxes[1] = this.directionNormal;
		this.dirsplayBoxes[2] = this.sqrMagnitude;
		this.dirsplayBoxes[3] = this.distance;
		this.dirsplayBoxes[4] = this.dotProduct;

		




	}

	int getSizeX(){
		return (int)xAxis.x;
	}

	int getSizeY(){
		return (int)yAxis.y;
	}

	void draw(){

		//DrawGrid BG
		stroke(cBgB);
		strokeWeight(1);
		for(int x = 0; x < xAxis.x - cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		//Draw Boxes and functions
		direction.drawArrows(cBgB);
		directionNormal.drawArrows(cBgB);
		sqrMagnitude.drawArrows(cBgB);
		distance.drawArrows(cBgB);
		dotProduct.drawArrows(cBgB);

		for(int i = 0; i < dirsplayBoxes.length; i++){
			dirsplayBoxes[i].draw(cBgB);
		}

		//InfoText
		fill(255);
		text("Right/Left Click on\ngrid to add vectors.\nClick on Calculation\nto see result of\ncalculation", 370, origo.x, 0);


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

	

	void clicked(float x, float y, boolean rc, boolean lc){
		//Clicked functions
		if(pOne != null && pTwo != null){
			for(int i = 0; i < dirsplayBoxes.length; i++){
				dirsplayBoxes[i].clicked(x,y);
			}
			/*
			direction.clicked(x, y);
			directionNormal.clicked(x,y);
			sqrMagnitude.clicked(x,y);
			distance.clicked(x,y);
			dotProduct.clicked(x,y);
			*/             ///+-------------------Check if loop is ok
		}


		//Clicked vectorfield
		if(contains(x, y, origo.x, xAxis.x, origo.y, yAxis.y)){
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
		calculate();
	}


	void calculate(){
		if(pOne != null && pTwo != null){

			PVector vectOne = new PVector(pOne.getFakePosX(), pOne.getFakePosY());
			PVector vectTwo = new PVector(pTwo.getFakePosX(), pTwo.getFakePosY());

			//Direction
			direction.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			directionNormal.setColorOther(direction.getColorBase());
			directionNormal.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			sqrMagnitude.setColorOther(direction.getColorBase());
			sqrMagnitude.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			distance.setColorOther(sqrMagnitude.getColorBase());
			distance.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			dotProduct.setColorOther(direction.getColorBase());
			dotProduct.setCalculation(vectOne,vectTwo, pOne.getPosition(), pTwo.getPosition());

		}
	}

	boolean contains(float posX, float posY, float minX, float maxX, float minY, float maxY){
		if(posX < maxX && posX > minX){
			if(posY < maxY && posY > minY)
				return true;
		}
		return false;
	}
}
