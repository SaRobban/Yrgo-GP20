
void Arrow(PVector from, PVector to, color col){

	

	stroke(col);	
	line(from.x, from.y, to.x, to.y);


	float rad = PI * 0.25;

	PVector dir = new PVector();

	dir.x = from.x - to.x;
	dir.y = from.y - to.y;

	//dir.set(from.sub(to));  //BUG???????????????

	dir = dir.normalize();
	dir = dir.rotate(rad);
	dir.mult(10);


	line(to.x, to.y, to.x + dir.x, to.y + dir.y);

	dir = dir.rotate(rad * -2);
	line(to.x, to.y, to.x + dir.x, to.y + dir.y);

}
