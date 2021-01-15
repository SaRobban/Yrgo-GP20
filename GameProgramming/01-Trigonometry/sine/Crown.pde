class Crown{

	public float posX;
	public float posY;
	public float radius;

	public int knorrNum;
	public PVector[] points;
	public float step;
	public float animTimeMul = 0.25f;

	public float red = 255;
	public float green = 255;
	public float blue = 255;

	public Crown(){
		this.posX = 0;
		this.posY = 0;
		this.radius = 100;
		this.knorrNum = 0;
		this.points = new PVector[1000];

		for(int i = 0; i < points.length; i++){
			points[i] = new PVector();
		}
		this.step = 1.0f / (points.length-1);
	}

	public Crown(float posX, float posY, float radius, int itt, int knorr){
		this.posX = posX;
		this.posY = posY;
		this.radius = radius;

		this.points = new PVector[itt];
		this.knorrNum = knorr;

		for(int i = 0; i < points.length; i++){
			points[i] = new PVector(0,0);
		}
		this.step = 1.0f / (points.length-1);
		Update(0);
	}
  	
  	public void Update(float delta){
  		for(int i = 0; i < points.length; i++){
  							//Circel										//knorr											
  			points[i].x = sin(i * 2 * PI * step + delta * animTimeMul) * radius + cos(i * step * knorrNum * 2 * PI) * radius *0.75f;
  			points[i].y = cos(i * 2 * PI * step + delta * animTimeMul) * radius + sin(i * step * knorrNum * 2 * PI) * radius *0.75f;

  			points[i].add(posX, posY); 			
  		}
  	}

  	public void SetColor(float r, float  g, float b){
  		this.red = r;
  		this.green = g;
  		this.blue = b;
  	}

  	public void Draw(float anim){
  		int a = 0;
  		float fourStep = step * 4;
  		
  		for(int b = 1; b < points.length; b++){
  			float c = 128 + (127 * sin(PI * a * fourStep + anim));
  			stroke(color(red, green, blue, c));
  			line(points[a].x, points[a].y, points[b].x, points[b].y);
  			a = b;
  		}
  	}
}
