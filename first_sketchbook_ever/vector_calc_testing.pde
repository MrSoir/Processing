float yPos = 0.0;

PFont font;

float angle = 0.0f;

void drawVector_calc_Testing(){
  font = createFont("Arial",16,true);
  float scaleFactor = 100f;
  
  Vector3 refVec = new Vector3(1f, 0f, 0f);
  Vector3 vec = new Vector3(cos(radians(angle)), sin(radians(angle)), 0f);
  
  line3D(refVec.mult(scaleFactor), new ColorBD(0, 255, 0, 255)  , 2);
  line3D(vec.mult(scaleFactor)   , new ColorBD(255, 0, 255, 255), 2);
  
  line3D(vec.cross(refVec).mult(scaleFactor)   , new ColorBD(255, 0, 0, 255), 2);

           
 // printText(vec.dot(refVec) + ""  , (int)(-window_width*0.2f + 20), (int)(-window_height*0.2f + 20));
 // printText(vec.cross(refVec).length() + "", (int)(-window_width*0.2f + 20), (int)(-window_height*0.2f + 40));
 
  println("dot: " + vec.dot(refVec));
  println("cross: " + vec.cross(refVec).length() + "\n");

  angle += 0.5f;
  if (angle > 360)
    angle -= 360;
}

void line3D(Vector3 vec, ColorBD col, float strokeWeight)
{
  pushMatrix();
  stroke(col.r, col.g, col.b, col.a);
  strokeWeight(strokeWeight);
  line(0,0,0,   vec.x, vec.y, vec.z);
  popMatrix();
}

void printText(String text, int x, int y)
{
  textFont(font, 16);                  // STEP 3 Specify font to be used
  fill(255);                         // STEP 4 Specify font color 
  text(text, x, y);
}
