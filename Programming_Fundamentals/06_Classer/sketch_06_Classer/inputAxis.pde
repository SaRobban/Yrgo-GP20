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
	}
}
/*
class Input{
	PVector inputAxis;
	

	Input(float x, float y){
		inputAxis = new PVector(0,0);
	}

	PVector GetInput(){

		inputAxis.set(0,0);

		if(keyCode == LEFT || key == 'a'){
			inputAxis.x -= left;
		}

		if(keyCode == RIGHT || key == 'd'){
			inputAxis.x += right;
		}

		if(keyCode == UP || key == 'w'){
			inputAxis.y -= up;
		}

		if(keyCode == DOWN || key == 's'){
			inputAxis.y += down;
		}

		inputAxis.normalize();

		
		return inputAxis.copy();
	}
}
*/