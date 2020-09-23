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

	color colOne;
	color colTwo;
	color colInfoText;
	color colArrow;
	int arrowThickness;

	BDisplay direction;
	BDisplay directionNormal;
	BDisplay sqrMagnitude;
	BDisplay distance;
	BDisplay dotProduct;

	PVector directionV;
	PVector directionNV;
	PVector sqrMagnitudeVOne;
	PVector sqrMagnitudeVTwo;

	//scalar
	//angle
	
	Arrow allArrows[];

	//Constructor
	XYaxlar(int origoX, int origoY, int endX, int endY, int scal, color cOne, color cTwo, color cInfoText){
 
		this.origo = new PVector(origoX, origoY);
		this.xAxis = new PVector(endX, origoY);
		this.yAxis = new PVector(origoX, endY);
		this.cordScale = scal;
		this.colOne = cOne;
		this.colTwo = cTwo;
		this.colInfoText = cInfoText;
		this.colArrow = color(255, 255, 0, 255);
		this.arrowThickness = 3;

		this.direction = new BDisplay(origoX, endY + 20, 140, 40);
		this.directionNormal = new BDisplay(origoX + 160, endY + 20, 140, 40);
		this.sqrMagnitude = new BDisplay(origoX, endY + 80, 300, 40);

		this.distance = new BDisplay(origoX, endY + 140, 300, 40);

		this.allArrows = new Arrow[2];
		this.allArrows[0] = new Arrow(0, origo, xAxis, color(colTwo), 1);
		this.allArrows[1] = new Arrow(1, origo, yAxis, color(colTwo), 1);

	}

	void DrawXY(){




		//draw grid
		stroke(colOne);
		strokeWeight(1);
		for(int x = 0; x < xAxis.x -cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		//Draw Boxes and functions
		direction.Draw(colOne, colTwo, colInfoText);
		directionNormal.Draw(colOne, colTwo, colInfoText);

		sqrMagnitude.Draw(colOne, colTwo, colInfoText);
		distance.Draw(colOne, colTwo, colInfoText);

		for(int i = 0; i < allArrows.length; i++){
			allArrows[i].Draw();
		}

		//Draw Vectors
		if(pOne != null){
			pOne.Draw();
			pOne.DrawCord();
		}

		if(pTwo != null){
			pTwo.Draw();
			pTwo.DrawCord();
		}

		
	}

	int GetSizeX(){
		return (int)xAxis.x;
	}

	int GetSizeY(){
		return (int)yAxis.y;
	}

	void Clicked(float x, float y, boolean rc, boolean lc){
		
		//Clicked functions
		if(pOne != null && pTwo != null){
			removeNotNeededArrow();
			if(direction.Clicked(x, y)){
				addArrow(new Arrow(allArrows.length, pOne.GetPosition(), pTwo.GetPosition(), colArrow, 3));
				//print(allArrows.length);
			}else if(directionNormal.Clicked(x,y)){
				//addArrow(new Arrow(allArrows.length, pOne.GetPosition(), PVector.add(pOne.GetPosition(), PVector.mult(PVector.sub(pTwo.GetPosition(), pOne.GetPosition()).normalize(),22)), colArrow, 3));
				addArrow(new Arrow(allArrows.length, pOne.GetPosition(), directionNV, colArrow, 3));
			}else if(sqrMagnitude.Clicked(x,y)){
				addArrow(new Arrow(allArrows.length, pOne.GetPosition(), sqrMagnitudeVOne, colArrow, 3));
				addArrow(new Arrow(allArrows.length, pOne.GetPosition(), sqrMagnitudeVTwo, colTwo, 3));

			}else if(distance.Clicked(x,y)){
				addArrow(new Arrow(allArrows.length, pOne.GetPosition(), pTwo.GetPosition(), colArrow, 3));

			}else{
				removeNotNeededArrow();
			}
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

			PVector vectOne = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			PVector vectTwo = new PVector(pTwo.GetFakePosX(), pTwo.GetFakePosY());

			//Direction
			PVector dir = PVector.sub(vectTwo, vectOne);
			direction.SetText("Direction", ("V2 - V1 = direction\n" + "dirX " + nf(dir.x,0,1) + "  dirY " + nf(dir.y,0,1)));// ("V1 - V2 = " +(String)dir));
			
			directionV = PVector.add(pOne.GetPosition(), dir);


			PVector dirN = dir.copy();
			dirN.normalize();

			directionNV = PVector.add(pOne.GetPosition(), PVector.mult(dirN, cordScale + arrowThickness * 2));//compansate for arrow shotening

			//dir rot (dir square)
			directionNormal.SetText("Direction normalized", "dir/√dir²=normalized" +"\n" + "dirX " + nf(dirN.x,0,2) + "  dirY " + nf(dirN.y,0,2));
			


			PVector compDir = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			compDir.mult(-1);
			float compSqr = compDir.magSq();
			float vecSqr = dir.magSq();
			compDir.normalize();

			if(compSqr < vecSqr){
				sqrMagnitude.SetText("Squared Magnitude", ("Direction * Direction = Squared Magnitude" + "\n" + "V1 is closer to Origo then V2  (" + nf(vecSqr,0,2) + ")"));
			}else{
				sqrMagnitude.SetText("Squared Magnitude", ("Direction * Direction = Squared Magnitude" + "\n" + "V1 is closer to V2 then Origo  (" + nf(vecSqr,0,2) + ")"));
			}
			sqrMagnitudeVOne = PVector.add(pOne.GetPosition(), PVector.mult(dirN, vecSqr * cordScale));
			sqrMagnitudeVTwo = PVector.add(pOne.GetPosition(), PVector.mult(compDir, compSqr * cordScale));

			float dist = dir.mag();
			distance.SetText("Distance", "√ (Squared Magnitude) = Correct Distance" + "\n" + "V1 distance to V2 = " +  nf(dist,0,2));
		}
	}


	void addArrow(Arrow arrow){
		Arrow[] newArrows = new Arrow[allArrows.length+1];
		for(int i = 0; i < allArrows.length; i++){
			newArrows[i] = allArrows[i];
		}
		newArrows[allArrows.length] = arrow;

		allArrows = new Arrow[newArrows.length];
		arrayCopy(newArrows, allArrows);
	}

	void removeArrow(Arrow arrow){
		Arrow newArrows[] = new Arrow[allArrows.length-1];

		int r = 0;
		for(int i = 0; i < allArrows.length; i++){
			if(arrow != allArrows[i]){
				newArrows[r] = allArrows[i];
				r++;
			}
		}
		arrayCopy(newArrows, allArrows);
	}

	void removeNotNeededArrow(){
		allArrows = new Arrow[2];
		allArrows[0] = new Arrow(0, origo, xAxis, color(colTwo), 1);
		allArrows[1] = new Arrow(1, origo, yAxis, color(colTwo), 1);
	}
/*
	void Arrow(PVector from, PVector to, color col, int thickness){

		stroke(col);
		strokeWeight(thickness);
		line(from.x, from.y, to.x, to.y);


		float rad = PI * 0.25;

		PVector dir = new PVector();

		dir.x = from.x - to.x;
		dir.y = from.y - to.y;

		dir = dir.normalize();
		dir = dir.rotate(rad);
		dir.mult(10);


		line(to.x, to.y, to.x + dir.x, to.y + dir.y);

		dir = dir.rotate(rad * -2);
		line(to.x, to.y, to.x + dir.x, to.y + dir.y);

	}
*/
}
