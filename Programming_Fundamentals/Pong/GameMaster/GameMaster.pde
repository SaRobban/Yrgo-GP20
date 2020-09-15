color black = color(0, 0, 0,255);
color neonRed = color(255, 0, 128,255);
color neonPurp = color(128, 0, 255,255);
color neonPink = color(255, 0, 255,255);
color gray = color(128, 128, 128,255);

void setup(){
	size(512,512);
}

void draw(){
	background(black);
	strokeWeight(2);
	stroke(neonRed);
	line(0,0,256,256);
	stroke(neonPink);
	line(256,256,512,512);
}
