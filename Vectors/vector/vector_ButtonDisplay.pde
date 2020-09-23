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
		//print(header);
		this.head = header;
		this.display = display;
	}

	//float posX, float posY, float minX, float maxX, float minY, float maxY
	boolean Clicked(float clickPosX, float clickPosY){
		if(clickPosX < posX + sizeX && clickPosX > posX){
			if(clickPosY < posY + sizeY && clickPosY > posY){
				//print("clicked me " + head);
				return true;
			}
		}
		return false;



		//return(Contains(clickPosX, clickPosY, posX, posY, posX + sizeX, posY + sizeY));
	}

	void Draw(color col, color cFill, color cInfotext){
		
		fill(cFill);
		noStroke();
		rect(posX, posY, sizeX, sizeY);


		if(head.isEmpty() || display.isEmpty()){
			line(posX, posY, posX + sizeX, posY + sizeY);
		}else{
			textSize(12);
			text(head, posX, posY - 2);
			fill(cInfotext);
			text(display, posX + 10, posY + 15);
		}
	}
}