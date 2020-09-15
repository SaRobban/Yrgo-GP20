class Direction{
	int posX;
	int posY;
	int sizeX;
	int sizeY;

		String head;
				String display;

	Direction(int posX, int posY, int sizeX, int sizeY){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
	}

	void setText(String head, String display){
		this.head = head;
		this.display = display;
	}

	void Draw(String headder, String display, color col, color fill){
		stroke(col);
		fill(fill);
		rect(posX, posY, sizeX, sizeY);
		line(posX, posY, posX + sizeX, posY + sizeY);

		textSize(12);
		
		text(headder, posX, posY);

		
		fill(255,0,0);
		text("V1", posX + 10, posY + 20);
		fill(0,255,0);
		text("     V2", posX + 10, posY + 20); // SCACE = NUMBER OF CHARACTERS
		fill(col);
		text(display, posX + 10, posY + 20);
	}
}