float animSpeed = 1.0f;
color bgColor = color(16, 0, 64, 16);

Crown crown;
Crown crownTwo;

Branch branch;

void setup(){
	size(600, 400);
	background(bgColor);
	fill(bgColor);

  	crown = new Crown(200,200,100,1000,1);
  	crownTwo = new Crown(200,200,50,1000,2);

  	branch = new Branch(new PVector(500,50),100,10);

  	crown.SetColor(32,128,255);
  	crownTwo.SetColor(16,192,255);
}

void draw(){
	strokeWeight(0);
	rect(-10, -10, width + 10, height + 10);
	//background(0);

  	animSpeed +=0.1f;
  	strokeWeight(3);
  	branch.Draw(animSpeed);
	strokeWeight(2);
  	crown.Update(animSpeed);
  	crown.Draw(animSpeed);
  	crownTwo.Update(-animSpeed);
  	crownTwo.Draw(-animSpeed);
	
}