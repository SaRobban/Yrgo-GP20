PVector inputAxis = new PVector(0,0);
//keys

int left;
int right;
int up; 
int down;

boolean space = false;

void keyPressed(){
	if(keyCode == LEFT || key == 'a'){
		left = 1;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 1;
	}

	if(keyCode == UP || key == 'w'){
		up = 1;
	}

	if(keyCode == DOWN || key == 's'){
		down = 1;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();

	if(key == ' '){
		space = true;
		//print("space is true " , space);
	}

}


void keyReleased(){
	if(keyCode == LEFT || key == 'a'){
		left = 0;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 0;
	}

	if(keyCode == UP || key == 'w'){
		up = 0;
	}

	if(keyCode == DOWN || key == 's'){
		down = 0;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();

	if(key == ' '){
		space = false;
		//print("space is false " , space);
	}
}