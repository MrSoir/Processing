

void angle_on_circle_testing_draw(){   
   float radius = 300.0f;
   drawEllipse(radius, new Vector2(0f,0f), new ColorBD(255, 0, 255, 255));
   
   Vector2 refVec = new Vector2(1.0f, 0.0f);
   
   float edge = 200.0f;
   strokeWeight(3);
   line(0,0, refVec.x * edge, refVec.y * edge);
   
   float x = cos(radians(angle)) * edge;
   float y = sin(radians(angle)) * edge;
   
   stroke(0,255,0);
   line(0,0, x,y);
   
   Vector2 tarVec = new Vector2(x,y);
     
   float calcAngle = angleDeg(tarVec);
     
  println(String.format("angle: %.2f  %.2f  |  %s  |  %s", angle, calcAngle, 
                                                                   refVec, tarVec));
  
   angle += 0.1f;
   if(angle > 360)
     angle -= 360;
}

float angleRad(Vector2 v1){
    v1 = v1.normalize();
    Vector2 refVec = new Vector2(1.0, 0.0);
    
    float cosinus = refVec.dot(v1);
    float angle = acos(cosinus);
    
    if(v1.y < 0){
      angle = (float)(Math.PI * 2.0) - angle;
    }
    return angle;
}
float angleDeg(Vector2 v1){
    return degrees(angleRad(v1));
}

//Vector2[] calcCollision(Vector2 v1, Vector2 v2, Vector2 cent1, Vector2 cent2,
//                        float m1, float m2){
//  float s1 = v1.length(); // speed of v1
//  float s2 = v2.length(); // speed of v2
    
//   float thet1 = angleRad(v1); // absolute angle of v1 in global space
//   float thet2 = angleRad(v2); // absolute angle of v1 in global space
   
//   float phi = angleRad(cent2);
   
//   double cos_thet1_phi = Math.cos(thet1 - phi);
//   double cos_thet2_phi = Math.cos(thet2 - phi);
//   double sin_thet1_phi = Math.sin(thet1 - phi);
//   double sin_thet2_phi = Math.sin(thet2 - phi);
//   double cosPhi = Math.cos(phi);
//   double sinPhi = Math.sin(phi);
//   double m1_m2 = m1 - m2;
//   double m2_m1 = m1_m2 * -1.0;
   
//   double v1x_ = s1 * cos_thet1_phi * m1_m2 + 2 * m2 * s2 * cos_thet2_phi / (m1 + m2) 
//                 * cosPhi + s1 * sin_thet1_phi * sinPhi;    
                 
//   double v2x_ = s2 * cos_thet2_phi * m2_m1 + 2 * m1 * s1 * cos_thet1_phi / (m2 + m1) 
//                 * cosPhi + s2 * sin_thet2_phi * sinPhi;
                 
//   double v1y_ = s1 * cos_thet1_phi * m1_m2 + 2 * m2 * s2 * cos_thet2_phi / (m1 + m2) 
//                 * sinPhi + s1 * sin_thet1_phi * cosPhi;
                 
//   double v2y_ = s2 * cos_thet2_phi * m2_m1 + 2 * m1 * s1 * cos_thet1_phi / (m2 + m1) 
//                 * sinPhi + s2 * sin_thet2_phi * cosPhi;
                 
//   Vector2 v1_ = new Vector2((float)v1x_, (float)v1y_);
//   Vector2 v2_ = new Vector2((float)v2x_, (float)v2y_);
//   return new Vector2[]{v1_, v2_};
//}
