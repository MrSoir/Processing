

float angle = 0.0f;

void angle_testing_draw(){
   translate(width*0.5, height*0.5);
   stroke(255,0,255);
   
   float edge = 200.0f;
   strokeWeight(3);
   line(0,0, 0, edge);
   
   float x = cos(radians(angle+90)) * edge;
   float y = sin(radians(angle+90)) * edge;
   
   stroke(0,255,0);
   line(0,0, x,y);
     
   Vector2 refVec = new Vector2(0f,1f);
   Vector2 tarVec = new Vector2(x,y).normalize();
   
   float cos = tarVec.dot(refVec);
   float angle_II = degrees(acos(cos));
   if(x > 0)
     angle_II = 360 - angle_II;
     
  println(String.format("angle: %.2f  %.2f  %s  %.8f", angle, angle_II, checkForSimilarity(angle, angle_II, 0.001), angle-angle_II));
  
   angle += 0.5f;
   if(angle > 360)
     angle -= 360;
}
