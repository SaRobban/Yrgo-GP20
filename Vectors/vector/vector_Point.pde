


class Point{
	String name;
	PVector cord;
	PVector pos;
	float radius;
	color col;
	int cordScale;

	Point(String name, int x, int y, int off, float radius, color col, int scal){
		this.name = name;
		this.pos = new PVector(x,y);
		this.radius = radius;
		this.col = col;

		
		this.cordScale = scal;

		this.cord = new PVector((x - off), (y - off));

	}

	void setPosition(int x, int y, int off){
		pos.set(x, y);
		cord.set(x - off, y - off);
	}

	PVector GetPosition(){
		return pos;
	}

	public float GetFakePosX(){
		return cord.x / cordScale;
	}

	public float GetFakePosY(){
		return (cord.y / cordScale);
	}

	void DrawCord(){
		textSize(12);
		fill(col);
		text(name + "\n" + "X" + (cord.x / cordScale) + "\nY" + (cord.y / cordScale), pos.x + radius * 2, pos.y + radius);
	}
	void Draw(){
		fill(col);
		noStroke();
		circle(pos.x, pos.y, radius);
		stroke(255);
	}
}