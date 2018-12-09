class Vector3{
  float x, y, z;
  Vector3(){x = 0.0f; y = 0.0f; z = 0.0f;}
  Vector3(float x, float y, float z){this.x = x; this.y = y; this.z = z;}
  Vector3(double x, double y, double z){this.x = (float)x; this.y = (float)y; this.z = (float)z;}


  float length(){return sqrt(x*x + y*y + z*z);}
  Vector3 normalize(){
    float length = length();
    return new Vector3(x/length, y/length, z/length);
  }
  
  float dot(Vector3 other){
    return x * other.x + y * other.y + z * other.z;
  }
  float dotNormalized(Vector3 other){
    return this.normalize().dot(other.normalize());
  }
  
  Vector3 cross(Vector3 other){
    return new Vector3(y*other.z - z*other.y, z*other.x - x*other.z, x*other.y - y*other.x);
  }
  Vector3 corssNormlized(Vector3 other){
    return this.normalize().cross(other.normalize());
  }
  
  Vector3 mult(float a){return new Vector3(x*a, y*a, z*a);}
  Vector3 div (float a){return new Vector3(x/a, y/a, z/a);}
  Vector3 add (float a){return new Vector3(x+a, y+a, z+a);}
  Vector3 sub (float a){return new Vector3(x-a, y-a, z-a);}
  Vector3 mult(Vector3 a){return new Vector3(x*a.x, y*a.y, z*a.z);}
  Vector3 div (Vector3 a){return new Vector3(x/a.x, y/a.y, z/a.z);}
  Vector3 add (Vector3 a){return new Vector3(x+a.x, y+a.y, z+a.z);}
  Vector3 sub (Vector3 a){return new Vector3(x-a.x, y-a.y, z-a.z);}
  
  String toString(){return String.format("x: %.2f  y: %.2f  z: %.2f", x, y, z);}

}
