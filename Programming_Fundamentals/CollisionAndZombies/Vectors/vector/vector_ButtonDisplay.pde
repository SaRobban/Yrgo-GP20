//Button and display class
//Draws buttons and text in rect boxes

class BDisplay{
	boolean active = false;

	int posX;
	int posY;
	int sizeX;
	int sizeY;

	int lineThickness = 3;
	color cGreen;
	color cRed;
	color cOther;
	color cBase;

	String textHeader;
	String textGreen;
	String textRed;
	String textInBox;
	String textOther;
	
	BDisplay(){
		this.posX = 100;
		this.posY = 100;
		this.sizeX = 100;
		this.sizeY = 100;
		this.textHeader = new String("isEmpty");
		this.textGreen = new String("isEmpty");
		this.textRed = new String("isEmpty");
		this.textInBox = new String("isEmpty");
		this.textOther = new String("isEmpty");

		this.cGreen = color(0,255,0,255);
		this.cRed = color(255,0,0,255);
		this.cOther = color(0,255,255,255);
		this.cBase = color(0,255,255,255);
	}

	BDisplay(int posX, int posY, int sizeX, int sizeY, color colBase){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;

		this.textHeader = new String();
		this.textGreen = new String();
		this.textRed = new String();
		this.textInBox = new String();
		this.textOther = new String();

		this.cGreen = color(0,255,0,255);
		this.cRed = color(255,0,0,255);
		this.cOther = color(0,255,255,255);
		this.cBase = colBase;
	}


	public void toggleActive(){
		active = !active;
	}


	public boolean getActive(){
		return active;
	}


	public color getColorBase(){
		return this.cBase;
	}


	public void setColorGreen(color c){
		cGreen = c;
	}


	public void setColorRed(color c){
		cRed = c;
	}


	public void setColorOther(color c){
		cOther = c;
	}

	public void SetText(String header, String textGreen, String textRed, String textOther, String textInBox){
		this.textHeader = header;
		this.textInBox = textInBox;
		this.textGreen = textGreen;
		this.textRed = textRed;
		this.textOther = textOther;
	}


	boolean clicked(float clickPosX, float clickPosY){
		if(clickPosX < posX + sizeX && clickPosX > posX){
			if(clickPosY < posY + sizeY && clickPosY > posY){
				toggleActive();
				return true;
			}
		}
		return false;
	}


	void draw(color boxBg){
		fill(boxBg);
		noStroke();
		rect(posX, posY, sizeX, sizeY);

		if(active){
			fill(cBase);
			rect(posX + 3, posY + 2, lineThickness, sizeY -5);
		}
		//textSize(12);
		//textFont(font, 12);

		if(!textHeader.isEmpty()){
			
			text(textHeader, posX, posY - 2);
		}
		if(!textGreen.isEmpty()){
			fill(cGreen);
			text(textGreen, posX + 10, posY + 15);
		}
		if(!textRed.isEmpty()){
			fill(cRed);
			text(textRed, posX + 10, posY + 15);
		}
		if(!textOther.isEmpty()){
			fill(cOther);
			text(textOther, posX + 10, posY + 15);
		}

		if(!textInBox.isEmpty()){
			fill(cBase);
			text(textInBox, posX + 10, posY + 15);
		}
	}
}
