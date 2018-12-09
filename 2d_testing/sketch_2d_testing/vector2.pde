class Vector2{
  float x, y;
  Vector2(){x = 0.0f; y = 0.0f;}
  Vector2(float x, float y){this.x = x; this.y = y;}

  float length(){return sqrt(x*x + y*y);}
  Vector2 normalize(){
    float length = length();
    return new Vector2(x/length, y/length);
  }
  
  float dot(Vector2 other){
    return x * other.x + y * other.y;
  }
  float dotNormalized(Vector2 other){
    return this.normalize().dot(other.normalize());
  }
  
  Vector2 mult(float a){return new Vector2(x*a, y*a);}
  Vector2 div (float a){return new Vector2(x/a, y/a);}
  Vector2 add (float a){return new Vector2(x+a, y+a);}
  Vector2 sub (float a){return new Vector2(x-a, y-a);}
  Vector2 mult(Vector2 a){return new Vector2(x*a.x, y*a.y);}
  Vector2 div (Vector2 a){return new Vector2(x/a.x, y/a.y);}
  Vector2 add (Vector2 a){return new Vector2(x+a.x, y+a.y);}
  Vector2 sub (Vector2 a){return new Vector2(x-a.x, y-a.y);}
  
  String toString(){return String.format("x: %.2f  y: %.2f", x, y);}
}
