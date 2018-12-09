int x = 0;
int frameWidth, frameHeight;

Ball2[] balls;
Rect2 court;

float lastTime = -1.0f;

void setup() {
  size(640, 640);
    
  frameWidth = 640;
  frameHeight = 480;
  
  background(0);
  fill(255);
  
  frameRate(90);
    
  balls = new Ball2[10];
  court = new Rect2(0,frameWidth, 0, frameHeight);
  
  //generateRandomBalls();
  //setupCircleApproximation();
}

void draw() {  
  clear();
  
   translate(width*0.5, height*0.5);
   stroke(255,0,255);
   
   ellipseMode(CENTER);

  //ball_physics_testing();
  //angle_testing_draw();
  angle_on_circle_testing_draw();
  //drawCircleApproximation();
}

void generateRandomBalls(){
  float minMass = 1.0f, maxMass = 5.0f;
  float offs = 20.0f;
  float maxVel = 80.0f;
  
  for(int i=0; i < balls.length; i++){
    float mass = random(minMass, maxMass);
    float radius = 10.0f * mass;
    balls[i] = new Ball2(new Vector2(random(court.xmin + offs, court.xmax - offs),  // positionX
                                     random(court.ymin + offs, court.ymax - offs)), // positionY
                                     
                         new Vector2(random(-maxVel, maxVel),                       // velocityX
                                     random(-maxVel, maxVel)),                      // velocityY
                                     
                         radius,                                                    // radius
                         mass);                                 // mass
  }
}

void ball_physics_testing(){
  float curTime = (float)millis() / 1000.0; // in seconds!
  
  float dt = lastTime >= 0 ? curTime-lastTime :  0.0f;
  
  lastTime = curTime;
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  for(int i=0; i < balls.length; i++){
    Ball2 ball = balls[i];
    ball.move(dt, court);
  }
  for(int i=0; i < balls.length; i++){
    Ball2 ball = balls[i];
    boolean iscolliding = false;
    for(int j=i+1; j < balls.length; j++){
      if(i != j){
        Ball2 ball2 = balls[j];
        boolean collission = ball.collission(ball2);
        if(collission)
          iscolliding = collission;
      }
    }
    ColorBD col = iscolliding ? new ColorBD(255, 0, 0, 255) :
                                new ColorBD(255, 255, 255, 255);
    drawEllipse(ball.radius*2.0, ball.pos, col);
  }
  println();
}

void drawEllipse(float radius, Vector2 center, ColorBD col)
{
  fill(col.r, col.g, col.b, col.a);
  ellipse(center.x, center.y, radius, radius);
}

class ColorBD{
  int r,g,b, a;
  ColorBD(int r, int g, int b, int a){
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
}
