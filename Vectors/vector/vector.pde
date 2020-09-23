
XYaxlar cordSys;
Point pointer;

int offset = 20;

int cordScale = 20;

Direction dir;

color bg = color (40,41,35,255);
color colOne = color (50,52,46,255);
color colTwo = color (70,72,66,255);
color colTre = color (40,41,35,255);

color cInfoText = color(0, 0, 0, 255);

void setup(){
	//noLoop();
	size(512,512);
	cordSys = new XYaxlar(offset, offset, 320, 320, cordScale, colOne, colTwo, cInfoText);
	reDraw();
}


void draw(){
	//background(bg);
	//cordSys.DrawXY();
}	


void reDraw(){
	background(bg);
	cordSys.DrawXY();
}	


void mousePressed() {
	boolean lc = false;
	boolean rc = false;
	if(mouseButton == LEFT)
		lc = true;

	if(mouseButton == RIGHT)
		rc = true;

	cordSys.Clicked(mouseX, mouseY, rc, lc);

	reDraw();
}


boolean Contains(float posX, float posY, float minX, float maxX, float minY, float maxY){
	if(posX < maxX && posX > minX){
		if(posY < maxY && posY > minY)
			return true;
	}
	return false;
}