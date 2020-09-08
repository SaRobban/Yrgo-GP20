



/*
		Jag har försökt lösa uppgiften på enklaste möjliga sätt och komenterat skiten ur det i hopp om att någon ska finna det hjälpsamt.
************************************************ SAMT FÖR ATT LÄRAREN SA ATT HAN ÄLSKA KOD KOMMENTARER!!! *********************************************

-------------------------------------------------------------------------------------------------------------------------------------------------------

Så här ser prossesing cordenater ut
				  ____________~___
				0| 1 2 3 4 5...640-screen size X
				1|
				2|
				3| 
				4|
				 ~
		   ...480|
				screen size Y

Vi vill rita en parabolisk figur med ett visst antal linjer. Vi kommer därför skapa två axlar med koordinater för X resp. Y.
En variabel för hur många linjer vi vill ha
En för avstånd mellan linjer
Samt lite färger

 Vi kommer sedan rita linjer genom att stega framåt i våra koordinat listor och rita en linje från koordinat till koordinat
 var tredje linje kommer även fyllas i med annan färg med hjälp av modulus.
 */


int frame = 0; //<-- Vår animations variabel i Class-en (vårt script). Måste ligga här eftersom vi vill spara värdet mellan vår Void Update/draw(). 
int animModulus = 0; //<-- Vår andra animations variabel.

//Den här funktionen körs en gång vid programmets start. Här kan du lägga saker som bara behövs räknas en gång och sedan är konstant ex. Programmets upplösning
void setup()
{
	size(640, 480);
	strokeWeight(2);
	background(64,64,64,255);
}



//Den här funktionen uppdateras varje frame (typ. Egentligen med ett intervall som styrs av processing3).
void draw(){

///Variabler som vi kommer behöva, Jag har lagt dom här för att kunna "Tweeka" i Prossesing3.////////////////////////////////////////////////////////////////

	//Variabler som vi kommer behöva:
	color svart = color(0,0,0,255); //<--Color är en inbyggt class som vi skapar våra färgvaribler med.	//color(Red, Green, Blue, Alpha).
	color gra = color(64,64,64,255);
	color lattVit = color(255,255,255,34);
	
	int numberOfLines = 20; //<-- Hur många linjer vår parabol ska ha.								// En Integer "int" kan inte ha decimaler
	float lineStep = 25.0; 	//<-- Hur långt avstånd (i pixlar) det ska vara mellan kordinater.		// En floating-point "float" ett nummer kan ha decimaler 
	
	float maxAxisSize = numberOfLines * lineStep; //<-- Detta är den maximala längden (i pixlar) vår parabol-graf kommer ha.
	
		PVector axisOffset = new PVector(20, 20); //<-- PVector är en inbyggd class består av två floats x,y. Jag skapar denna enbart för att kunna flytta hela vår graf på skärmen.
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Rita bakgrundsfärg om detta inte görs kommer även föregående uppritad ruta hänga kvar. (sätt brackets "//" för att se själv).
	background(gra);
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Detta kallas en "Forward loop". Varje gång "loopNumber" är mindre än numret av linjer vi vill ha kommer följande kod inom måsvingar köras.
	for(int loopNumber = 0; loopNumber < numberOfLines; loopNumber += 1){ //<-- Skrivs vanligtvis " for(int i = 0; i < lista.length; i++){kod} ""

		//Denna variabel kommer att få värden som successivt ökar från 0 till maxlängd
		float myX = loopNumber * lineStep; //<-- loopNummer ökar med ett för varje loop, vi multiplicerar därför detta med önskat avstånd mellan koordinater för att få en lista med ökande tal.

		//Denna variabel kommer få värden som successivt minskar från maxlängd till noll.
		float myY = maxAxisSize - loopNumber * lineStep; //<-- Vår maximalalängd substraherat men vår ökande kordinat.

		//X axel
		float startLineX = myX;
		float startLineY = 0;

		//Y axel
		float endLineX = 0;
		float endLineY = myY;

		//Vi har nu kordinat för att rita vår parabol, men slängt in lite funktioner före det.

		//Flytta hela parabol grafen med värden från axisOffsett
		startLineX += axisOffset.x;
		startLineY += axisOffset.y;
		endLineX += axisOffset.x;
		endLineY += axisOffset.y;

		//Animation
		startLineX += frame;
		endLineY -= frame;

		//% Modulus för att färgsätta var 3dje linje
		if(((loopNumber + animModulus) % 3) == 0){
			stroke(svart);
		}else{
			stroke(lattVit);
		}
		
		//Rita linje
		line(startLineX, startLineY, endLineX, endLineY);
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Done////

	//För animation adderar vi variablen "frame" varje frame. om frame är större än lineStep är frame lika med 0.
	frame++;
	if(frame >= lineStep){
		frame = 0;
		animModulus+=2;
	}
}