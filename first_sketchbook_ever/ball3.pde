class Ball3{
  Vector3 pos, vel;
  float radius;
  float mass;
  Ball3(){this(new Vector3(), new Vector3(), 5.0f, 1.0f);}
  Ball3(Vector3 pos, Vector3 vel, float radius, float mass){
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.mass = mass;
  }
  
  boolean collission(Ball3 other)
  {
    if(pos.sub(other.pos).length() < radius + other.radius){
      Vector3 v1 = vel;
      Vector3 v2 = other.vel;
      Vector3 x1 = pos;
      Vector3 x2 = other.pos;
      float m1 = mass;
      float m2 = other.mass;
      
      Vector3 x1_x2 = x1.sub(x2);
      Vector3 v1_v2 = v1.sub(v2);
      Vector3 x2_x1 = x2.sub(x1);
      Vector3 v2_v1 = v2.sub(v1);
      
      float x1_x2_length = x1_x2.length();
      float x2_x1_length = x2_x1.length();
            
      Vector3 v1_new = v1.sub( x1_x2.mult( (2*m2/(m1+m2)) * (v1_v2.dot(x1_x2) / (x1_x2_length*x1_x2_length)) ) );
      Vector3 v2_new = v2.sub( x2_x1.mult( (2*m1/(m1+m2)) * (v2_v1.dot(x2_x1) / (x2_x1_length*x2_x1_length)) ) );

      vel = v1_new;
      other.vel = v2_new;

      return true;
    }else{
      return false;
    }
  }
  
  void move(float dt, Rect3 court){
    pos.x += vel.x * dt;
    pos.y += vel.y * dt;
    pos.z += vel.z * dt;
    
    checkForCourtBounds(court);
  }
  void checkForCourtBounds(Rect3 court){
    float xmin = court.xmin + radius;
    float xmax = court.xmax - radius;

    float ymin = court.ymin + radius;
    float ymax = court.ymax - radius;

    float zmin = court.zmin + radius;
    float zmax = court.zmax - radius;
        
    if(pos.x < xmin){
      vel.x = abs(vel.x);
    }else if(pos.x > xmax){
      vel.x = - abs(vel.x);
    }
    
    if(pos.y < ymin){
      vel.y = abs(vel.y);
    }else if(pos.y > ymax){
      vel.y = - abs(vel.y);
    }
    
    if(pos.z < zmin){
      vel.z = abs(vel.z);
    }else if(pos.z > zmax){
      vel.z = - abs(vel.z);
    }
  }
}
