//Super class to BDisplay
//Fills BDisplay with text and calculations

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


	void drawArrows(color boxBg){
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

	//this is split since vector arrows can overshoot grid
	void drawArrows(color boxBg){
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
				"         ×          = Squared Magnitude" + "\n" + 
				"   is closer to Origo then    ("+ nf(compSq,3,2) + "<" + "      )"
			);
		}else{
			this.SetText(
				"Squared Magnitude","\nV1",                  
				"\n                V2                    " + nf(fakeMagSq,3,2),
				"Direction Direction",
				"         ×          = Squared Magnitude" + "\n" + 
				"   is closer to    then Origo ("+ nf(compSq,3,2) + ">" + "      )"
			);
		}
	}

	//this is split since vector arrows can overshoot grid
	void drawArrows(color boxBg){
		if(super.active){
			this.lineB.drawLine();
			this.line.drawLine();
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
				"               V2",
				"  SquaredMagnitude",
				"√                   = Correct Distance" + "\n" + 
				"   distance to    = " +  nf(fakeDist,0,2)
		);
	}


	void drawArrows(color boxBg){
		if(super.active)
			arrow.drawLine();
	}
}


class Dot extends BDisplay{
	Arrow arrow;

	Dot(int posX, int posY, int sizeX, int sizeY, color colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		
		

		PVector fakeDir = PVector.sub(v1, v2);
		float fakeDot = PVector.dot(fakeDir, v1);
		PVector fakedirtoO = v1.copy();
		fakedirtoO.normalize();
		fakedirtoO.mult(fakeDot);
		fakedirtoO.add(realV1);
		


		float mydot = fakeDir.x * v1.x + fakeDir.y * v1.y;
		println("dot: "+fakeDot + "  Mydot: " + mydot);
		this.arrow = new Arrow(realV1, fakedirtoO, cBase, lineThickness);

		//v1*v2  //v1.x * v2.x + v1.y * v2.y
		if(fakeDot < 0){
			this.SetText(
				"Dot", 
				"V1       V1.x       V1.y" + "\n" +
				"V1                                V1", 
				"\n                     V2",
				"   dir        dir.x      dir.y",       
				"  ∙    →(    ×     +    ×     )= Dot product" + "\n" + 
				"   is faceing origo,    is behind    (" +  nf(fakeDot,0,2) + ")"
			);
		}else{
			this.SetText(
				"Dot", 
				"V1       V1.x       V1.y" + "\n" +
				"V1                   V1", 
				"\n                                  V2",
				"   dir        dir.x      dir.y",       
				"  ∙    →(    ×     +    ×     )= Dot product" + "\n" + 
				"   is faceing origo,    is behind    (" +  nf(fakeDot,0,2) + ")"
			);
		}
	}


	void drawArrows(color boxBg){
		if(super.active){
			//arrow.drawArrow();
			arrow.drawArrow();
		}
	}
}