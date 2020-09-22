

ParabolicCurve pc;
int frame = 0;
int modus =2 ;
boolean b = true;

int axis =0;

boolean coolDown = true;

void setup()
{
	//noLoop();
	size(640, 480);
	PVector gridCenter = new PVector((float)width * 0.5, (float)height * 0.5);
	pc = new ParabolicCurve(gridCenter, 2, 30, 4);

	background(255,255,255,255);
	
}


void draw(){
////////animation variables ~Ignore looks////////////////////////////////////////////////////////////////////**/
/**/	float animOne = cos(frame * 0.01);																	/**/
/**/	float animTwo = sin(frame * 0.01);																	/**/
/**/	float animTre = sin(frame * 0.005);																	/**/
/**/	animTre = animTre * animTre;																		/**/
/**/	if(animTre < 0.01){																					/**/
/**/		if(!coolDown){																					/**/
/**/			PVector gridCenter = new PVector((float)width * 0.5, (float)height * 0.5);					/**/
/**/			int newArmNumber = pc.GetNumberOfArms();													/**/
/**/			print(newArmNumber);																		/**/
/**/			newArmNumber++;																				/**/
/**/			if(newArmNumber > 10){																		/**/
/**/				newArmNumber = 3;																		/**/
/**/			}																							/**/
/**/			pc = new ParabolicCurve(gridCenter, 3, 30, 2);									/**/
/**/			coolDown = true;																			/**/
/**/		}																								/**/
/**/	}else if(animTre > 0.9){																			/**/
/**/		coolDown = false;																				/**/
/**/	}																									/**/
/**/																										/**/
/**/	if(frame % 10 == 0)																					/**/
/**/		modus++;																						/**/
/**/	if(modus > 10)																						/**/
/**/		modus = 1;																						/**/
/**/																										/**/
/**/																										/**/
/**/////////////////////////////////////////////////////////////////////////////////////////////////////////////



	//background(0,0,0,255);
	fill(255,255,255,32);
	rect(0, 0, width, height);
	//pc.MoveMe(f * 10 + 320, f * 10 + 240);
	pc.RotateMe(frame * 0.01);
	pc.WobbleMe(animOne * 0.25);
	pc.ScaleMe(animTre * 6);
	pc.DrawMe(color(255,0,0,32), color(255, 0, 128,128), modus);


	
	frame++;
}

public class ParabolicCurve{
	int numberOfLines;
	float scaleMul;
	float wobble = 0;
	float rotation = 0;

	PVector cPosition;

	float armSize;
	PVector[] axises;
	int [] [] axisOder;
	
	
	//Constructor  (centerPosition, number of arms, number of lines, size)
	ParabolicCurve (PVector pos, int nOA, int nOL, float lS){
		scaleMul = 1;

		//Failsafe if below minimum values
		if(nOL < 1){
			nOL = 1;
		}

		if(nOA < 2){
			nOA = 2;
		}

		if(lS <= 0){
			lS = 1;
		}

		//Angle of axis in radians
		float piSlice = (2 * PI)/nOA;

		if (nOA == 2) {
			piSlice = (2 * PI)/3;
		}

		//We do this to get an extra end line, this makes odd number of axisesavaleble
		nOA++;
		
		//Set variabels////////////////////////////////////////////////////////////////
		numberOfLines = nOL;
		axises = new PVector[nOA];
		axisOder = new int[nOA] [nOL];
		armSize = lS;
		cPosition = new PVector();
		cPosition.set(pos);

		//Create parabol axis
		boolean armSwitch = false;
		for(int a =0; a < nOA; a++){
			//rotate axis
			axises[a] = new PVector(0,1);
			axises[a] = axises[a].rotate(piSlice * a);

			for(int l = 0; l < nOL; l++){
				
				if(armSwitch){
					axisOder[a][l] = l;
					//print(axisOder[a][l], ">> ");
				}else{
					axisOder[a][l] = (nOL - 1 - l);
					//print(axisOder[a][l], "<< ");
				}
			}
			armSwitch = !armSwitch;
			//print("\n","LOPPSWITCH________", armSwitch,"\n");
		}


		AssciART(nOA-1);
		print("created a ParabolicCurve width " , nOA-1 , " arms \n");
	}

	void MoveMe(PVector xy){
		cPosition.set(xy);
	}

	void MoveMe(float x, float y){
		cPosition.x = x;
		cPosition.y = y;
	}

	void RotateMe(float rad){
		rotation = rad;
	}

	void ScaleMe(float scale){
		scaleMul = scale;		
	}

	void WobbleMe(float rad){
		wobble = rad;
	}

	int GetNumberOfArms(){
		return (axises.length - 1);
	}

	void DrawMe(color col, color col2, int mod){
		stroke(255,255,255,255);
		strokeWeight(2);


		//Modify axis
		float piSlice = (2*PI) / (axises.length - 1);
		if (axises.length - 1 == 2) {
			piSlice = (2 * PI)/4;
		}


		for(int a = 0 ; a < axises.length-1; a++){
			axises[a].set(0, 1);
			axises[a].rotate(a * piSlice + rotation);

			if(a % 2 == 0)
				axises[a].rotate(wobble);
			else
				axises[a].rotate(-wobble);
		}
		axises[axises.length-1].set(axises[0]);

		//draw lines between axis points
		for(int a = 0; a < axises.length -1; a++){
			int b = a + 1;

			//line(cPosition.x, cPosition.y, cPosition.x + axises[a].x * 500, cPosition.y + axises[a].y * 500); //<-- show axis


			for(int c = 0; c < numberOfLines; c++){
				stroke(col);
				if(c % mod == 0)
					stroke(col2);

				line(	(axises[a].x * axisOder[a][c] * armSize) * scaleMul + cPosition.x,
						(axises[a].y * axisOder[a][c] * armSize) * scaleMul + cPosition.y,
						(axises[b].x * axisOder[b][c] * armSize) * scaleMul + cPosition.x,
						(axises[b].y * axisOder[b][c] * armSize) * scaleMul + cPosition.y);
			}
		}
	}
}


void AssciART(int i){

	if(i == 2){
		PImage  img = loadImage("test.gif");
		int length = img.height * img.width;
		img.loadPixels();

		int o =0;
		for(int p = 0; p < length; p++){
			if(p%32==0)
				print("\n");

			if(img.pixels[p] == color(0,0,0))
				print("%");
			else 
				print(" ");

			o++;
		}
		print(" \n  Oh no its the modulus squid!!! \n");

	}else
	if(i == 3){
		PImage  img = loadImage("test2.gif");
		int length = img.height * img.width;
		img.loadPixels();

		int o =0;
		for(int p = 0; p < length; p++){
			if(p%32==0)
				print("\n");

			if(img.pixels[p] == color(0,0,0))
				print("%");
			else 
				print(" ");

			o++;
		}
		print(" \n  Argghhh and here comes his friend!!! \n");
	}else{
		PImage  img = loadImage("test3.gif");
		int length = img.height * img.width;
		img.loadPixels();

		int o =0;
		for(int p = 0; p < length; p++){
			if((p%img.width *0.5)==0)
				print("\n");

			if(img.pixels[p] == color(0,0,0))
				print("%");
			else 
				print(" ");

			o++;
		}
		print(" \n  So many arms!!! \n");
	}
}
