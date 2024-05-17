void setup(){
  size(800, 1000, P3D);
  frameRate(200);
}


void draw(){
  translate (width/2, height/2);
  rotateX(PI/3);
  background(255,192,255);
   
  float da = PI/25;
  strokeWeight(0.2);
  beginShape(QUAD_STRIP);
  
  for (int i=-200; i<=200; i++){
    float a = i/50.0*2*PI;
    for (int j=-50; j<=50; j++){
      float b = j/50.0*2*PI;
      float re = 3+cos(frameCount/10.0);
      fill(127+i*255/100, abs(i)*255/100, 127-i*255/100);

      float RBig = 150+40*cos(i*PI/200);
      float RSmall = 40+30*cos(i*PI/200);
      float R2 = RBig+RSmall*cos(b);
      float R3 = RSmall*sin(b);
      vertex(R2*cos(a), R2*sin(a), R3+re*i);
      
      RBig = 150+40*cos((i+1)*PI/200);
      RSmall = 40+30*cos((i+1)*PI/200);
      R2 = RBig+RSmall*cos(b);
      R3 = RSmall*sin(b);
      vertex(R2*cos(a+da), R2*sin(a+da), R3+re*(i+1));
    }
  }
  endShape();
}
