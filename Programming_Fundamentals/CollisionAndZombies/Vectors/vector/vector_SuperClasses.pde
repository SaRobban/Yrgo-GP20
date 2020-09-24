class Direction extends BDisplay{
	Arrow arrow;

	Direction(int posX, int posY, int sizeX, int sizeY, color colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDir = PVector.sub(v2, v1);
		PVector realDir = PVector.sub(realV2, realV1);
		PVector target = PVector.add(realV1, realDir);
		this.arrow = new Arrow(realV1, target, cBase, lineThickness);
		this.SetText(
			"Direction", 
			"   V1",
			"V2","",
			"  -   = direction\n" + 
			"dirX" + nf(fakeDir.x,0,1) + " dirY" + nf(fakeDir.y,0,1)
		);
	}


	void draw(color boxBg){
		super.draw(boxBg);
		if(super.active)
			arrow.drawArrow();
	}
}



class DirectionNormalized extends BDisplay{
	Arrow arrow;

	DirectionNormalized(int posX, int posY, int sizeX, int sizeY, color colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDirN = PVector.sub(v2, v1);
		fakeDirN.normalize();

		PVector realDir = PVector.sub(realV2, realV1);
		realDir.normalize();
		realDir.mult(20 + lineThickness);
		PVector target = PVector.add(realV1, realDir);
		this.arrow = new Arrow(realV1, target, cBase, lineThickness);
		this.SetText(
			"Direction normalized", "","",
			"dir  dir",
			"   /√   ² = normalized" +"\n" + "dirX" + nf(fakeDirN.x,0,2) + "  dirY" + nf(fakeDirN.y,0,2)
		);
	}


	void draw(color boxBg){
		super.draw(boxBg);
		if(super.active)
			arrow.drawArrow();
	}
}


class SqrMagnitude extends BDisplay{
	Arrow line;
	Arrow lineB;
	PVector fakeOrigo;

	SqrMagnitude(int posX, int posY, int sizeX, int sizeY, color colBase, PVector fakeOrigo){
		super(posX, posY, sizeX, sizeY, colBase);
		this.fakeOrigo = fakeOrigo;
	}

	void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDir = PVector.sub(v2, v1);
		float fakeMagSq = fakeDir.magSq();
		PVector realDir = PVector.sub(realV2, realV1);

		float compSq = v1.magSq();
		//float realMagSq = realDir.magSq();
		PVector target = realDir.normalize();
		target.mult(fakeMagSq * 20);
		target.add(realV1);

		this.lineB = new Arrow(realV1.copy(), fakeOrigo.copy(), color(32,32,32), lineThickness);
		this.line = new Arrow(realV1, target, cBase, lineThickness);
		
		if(compSq < fakeMagSq){
			this.SetText(
				"Squared Magnitude","\nV1",                  
				"\n                           V2         " + nf(fakeMagSq,3,2),
				"Direction Direction",
				"         *          = Squared Magnitude" + "\n" + 
				"   is closer to Origo then    ("+ nf(compSq,3,2) + "<" + "      )"
			);
		}else{
			this.SetText(
				"Squared Magnitude","\nV1",                  
				"\n                V2                    " + nf(fakeMagSq,3,2),
				"Direction Direction",
				"         *          = Squared Magnitude" + "\n" + 
				"   is closer to    then Origo ("+ nf(compSq,3,2) + ">" + "      )"
			);
		}
	}


	void draw(color boxBg){
		super.draw(boxBg);
		if(super.active){
			this.line.drawLine();
			this.lineB.drawLine();
		}
	}
}

class Distance extends BDisplay{
	Arrow arrow;

	Distance(int posX, int posY, int sizeX, int sizeY, color colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		float fakeDist = PVector.dist(v2, v1);

		float realDist = PVector.dist(realV1, realV2);
		PVector target = PVector.sub(realV2, realV1);
		target.normalize();
		target.mult(realDist);
		target.add(realV1);

		this.arrow = new Arrow(realV1, target, cBase, lineThickness);


		this.SetText(
			"Distance","\n" + 
				"V1", "\n" +
				"               V2 = ",
				"  SquaredMagnitude",
				"√                   = Correct Distance" + "\n" + 
				"   distance to    = " +  nf(fakeDist,0,2)
		);
	}


	void draw(color boxBg){
		super.draw(boxBg);
		if(super.active)
			arrow.drawLine();
	}
}