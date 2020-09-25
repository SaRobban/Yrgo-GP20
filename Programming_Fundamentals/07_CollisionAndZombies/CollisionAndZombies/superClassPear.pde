class Pear extends GameObject{
  color colApple = color(0,255,0,255);
  int radius;
  Pear(float x, float y, int r){
      super(x,y);
      this.radius = r;
  }  
  
  void draw(){
    fill(colApple);
    circle(position.x, position.y, radius);
  }
}
