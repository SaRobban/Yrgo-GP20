

ParabolicCurve pc;
int frame = 0;
int modus =2 ;
boolean b = true;

int arms  =0;

void setup()
{
	//noLoop();
	size(640, 480);
	//gridCenter = new PVector((float)width * 0.5, (float)height * 0.5);
	pc = new ParabolicCurve(4,30,10);
}


void draw(){
	background(0,0,0,255);
	PVector c = new PVector(320,200);
	pc.RotateMe(new PVector(0,100), 0.001);
	pc.DrawMe(c, color(64,0,0,32), color(0, 0, 128,255), modus);

	frame++;

	if(frame == 10){
		if(modus > 30 || modus < 2){
			b = !b;
			arms++;
			if(b == false)
				pc = new ParabolicCurve(arms,30,10);
		}

		if(b){
			modus++;
		}else{
			modus--;
		}
		frame = 0;
	}
	
	
}


public class ParabolicCurve{
	int numberOfArms;
	int numberOfLines;
	PVector[] [] vectors;
	
	//Constructor
	ParabolicCurve (int nOA, int nOL, float lS) {

		//Failsafe if below minimum values
		if(nOL < 1){
			nOL = 1;
		}
		if(nOA < 2){
			nOA = 2;
		}

		float piSlice = (2 * PI)/nOA;

		if (nOA == 2) {
			piSlice = (2 * PI)/3;
		}

		//We do this to get an extra end line, this makes odd number of arms avaleble
		numberOfArms = nOA;
		nOA++;
		
		numberOfLines = nOL;
		//lineSpace = lS;

		int armSwitch = 0;
		float maxArmLength = (nOL - 1) * lS;

		vectors = new PVector[nOA] [nOL];
		for(int a =0; a < nOA; a++){
			if(armSwitch == 0){ //<-- Loop forward
				for(int l = 0; l < nOL; l++){
					vectors[a][l] = new PVector(0,1);
					vectors[a][l].rotate(piSlice * a);
					vectors[a][l].mult(l * lS);
					print(l * lS, ">> ");
				}
			}else{
				for(int l = nOL-1; l >= 0; l--){// <-- Loop rewerse
					vectors[a][l] = new PVector(0,1);
					vectors[a][l].rotate(piSlice * a);
					vectors[a][l].mult(maxArmLength - (l * lS));
					print(l * lS, "<< ");
				}

				armSwitch -= 2;
			}
			
			armSwitch++;
			print("\n","LOPPSWITCH-------------------------------------------------------------------", armSwitch,"\n");
		}
		print("created a ParabolicCurve");
	}

	void RotateMe(PVector center, float rad){

		for(int a = 0; a < numberOfArms+1; a++){
			for(int b = 0; b < numberOfLines; b++){
				PVector rotPV = new PVector(0,0);
				rotPV.set(vectors[a][b]);
				rotPV.sub(center);
				rotPV.rotate(rad);
				rotPV.add(center);
				vectors[a][b] = rotPV;
			}
		}
	}

	void DrawMe(PVector center, color col, color col2, int mod){
		stroke(255,255,255,255);
		strokeWeight(2);
		for(int a = 0; a < numberOfArms; a++){
			for(int b = 0; b < numberOfLines; b++){
				int c = a + 1;// (a+1) % numberOfArms;

				stroke(col);
				if(b % mod == 0)
					stroke(col2);
				//line(vectors[a][0].x + center.x, vectors[a][0].y + center.y, vectors[a][b].x + center.x, vectors[a][b].y + center.y);
				line(vectors[a][b].x + center.x, vectors[a][b].y + center.y, vectors[c][b].x + center.x, vectors[c][b].y + center.y);
			}
		}
	}
}