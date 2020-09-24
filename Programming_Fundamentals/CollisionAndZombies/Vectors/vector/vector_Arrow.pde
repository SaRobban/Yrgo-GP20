class Arrow{
	PVector from;
	PVector to;
	color col;
	int thickness;

	Arrow(PVector from, PVector to, color col, int thickness){
		this.from = from;
		this.to = to;
		this.col = color(red(col), green(col), blue(col), 128);
		this.thickness = thickness;

		//Shorten for grfx
		PVector subDir = PVector.sub(from, to);
		subDir.normalize();
		subDir.mult(thickness * 2);
		this.from.sub(subDir);
		this.to.add(subDir);
	}

	void drawArrow(){
		stroke(col);
		
		strokeWeight(thickness);	
		line(from.x, from.y, to.x, to.y);

		float rad = PI * 0.25;

		PVector dir = PVector.sub(from, to);
		dir = dir.normalize();
		dir = dir.rotate(rad);
		dir.mult(5);

		line(to.x, to.y, to.x + dir.x, to.y + dir.y);

		dir = dir.rotate(rad * -2);
		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
	}


	void drawLine(){
		stroke(col);
		
		strokeWeight(thickness);	
		line(from.x, from.y, to.x, to.y);

		float rad = PI * 0.5;

		PVector dir = PVector.sub(from, to);
		dir = dir.normalize();
		dir = dir.rotate(rad);
		dir.mult(5);

		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
		line(from.x, from.y, from.x + dir.x, from.y + dir.y);

		dir = dir.rotate(rad * 2);
		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
		line(from.x, from.y, from.x + dir.x, from.y + dir.y);
	}
}