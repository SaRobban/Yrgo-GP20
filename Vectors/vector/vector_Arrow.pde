class Arrow{
	int id;
	PVector from;
	PVector to;
	color col;
	int thickness;
	Arrow(int id, PVector from, PVector to, color col, int thickness){
		this.id = id;
		this.from = from.copy();
		this.to = to.copy();
		this.col = col;
		this.thickness = thickness;

		PVector subDir = PVector.sub(from, to);
		subDir.normalize();
		subDir.mult(thickness * 2);
		this.from.sub(subDir);
		this.to.add(subDir);
	}

	void Draw(){
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
}