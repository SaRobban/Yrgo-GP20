class BDisplay{
	int posX;
	int posY;
	int sizeX;
	int sizeY;

	String head;
	String display;

	BDisplay(int posX, int posY, int sizeX, int sizeY){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		head = new String();
		display = new String();
	}

	void SetText(String header, String display){
		print(header);
		this.head = header;
		this.display = display;
	}

	void Draw(color col, color fill){
		stroke(col);
		fill(fill);
		rect(posX, posY, sizeX, sizeY);


		if(head.isEmpty() || display.isEmpty()){
			line(posX, posY, posX + sizeX, posY + sizeY);
		}else{
			textSize(12);
			text(head, posX, posY);
			fill(255,0,0);
			text(display, posX + 10, posY + 15);
		}
	}
}