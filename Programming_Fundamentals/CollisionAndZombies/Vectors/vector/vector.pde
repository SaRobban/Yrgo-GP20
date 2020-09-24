
XYaxlar cordSys;
Point pointer;

int offset = 20;

int cordScale = 20;


color colbgA = color (40,41,35,255);
color colbgB = color (50,52,46,255);
color colBgC = color (70,72,66,255);
color colbgD = color (40,41,35,255);

color colInfoTextA = color(0, 0, 0, 255);
color colInfoTextB = color(0, 0, 0, 255);

PFont font;

void setup(){
	
	font = loadFont("Consolas-12.vlw");
	textFont(font, 12);

	//noLoop();
	size(512,512);
	cordSys = new XYaxlar(offset, offset, 360, 320, cordScale, colbgA, colbgB);
	reDraw();
}


void draw(){
}	


void reDraw(){
	background(colbgA);
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


//Special thx. Robin Bono, Daniel Nielsen, Jonatan Johansson, Simon Johansson
