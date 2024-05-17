void setup(){
  size(600, 600, P3D);
  pixelDensity(2);
}


void draw(){
  translate (width/2, height/2);
  rotateX(PI/3);
  background(255,192,255);
  stroke(0, 4);
  noStroke();
  strokeWeight(2);
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++){
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));  
    float R2 = 200+40*abs(cos(a*10));  
    fill(128, 64, 0);
    vertex(R1*cos(a), R1*sin(a),-100);
    fill(255, 192, 128);
    vertex(R2*cos(a), R2*sin(a),100);
  }
  endShape();
  fill(192, 128, 64);
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++){
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));  
    float R2 = 200+40*abs(cos(a*10));  
    vertex(R1*cos(a), R1*sin(a),100);
    vertex(R2*cos(a), R2*sin(a),100);
  }
  endShape();
  beginShape(QUAD_STRIP);
  for (int i=-250; i<=250; i++){
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));  
    float R2 = 200+40*abs(cos(a*10));  
    fill(128, 64, 0);
    vertex(R1*cos(a), R1*sin(a),-100);
    fill(255, 192, 128);
    vertex(R1*cos(a), R1*sin(a),100);
  }
  endShape();
  beginShape(TRIANGLE_FAN);
  fill(64, 32, 0);
  vertex(0,0,-100);
  for (int i=-250; i<=250; i++){
    float a = i/250.0*2*PI;
    float R1 = 180+40*abs(cos(a*10));  
    float R2 = 200+40*abs(cos(a*10));    
    vertex(R1*cos(a), R1*sin(a),-100);
   }
  endShape();
  translate (0,0, 50);
  sphere(150+30*sin(frameCount/10.0));
}
