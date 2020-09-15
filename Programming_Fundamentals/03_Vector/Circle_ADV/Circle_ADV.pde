Ball ball;
BoxCollider2D cols[];


void setup(){
  size(640, 480);
  ball = new Ball(40, 320, 240);

  cols = new BoxCollider2D[1];
  cols[0] = new BoxCollider2D(200,200,80,40, 0.523599);

}

void draw(){
  background(0);
  ball.SetPosition(mouseX, mouseY);
  ball.SetColor(color (0,128,64,255));

  if(cols[0].CircleCheckIfCollision(ball)){
    ball.SetColor(color (255,128,64,255));
  }

  ball.Draw();
  cols[0].Draw(color(0, 0, 255, 255));
}