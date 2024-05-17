PShader monProgrammeShader; //1//
float angle = 0; 
float radius = 0;
float max_R = 20; 
float radius_S = 0.02; 

void setup() {
  monProgrammeShader = 
    loadShader("myFragmentShader.glsl",  "myVertexShader.glsl"); //2//
  size(800, 800, P3D);
}

void draw() {
  background(255); 

  pointLight(255, 255, 255, mouseX, mouseY, 400); 

  translate(width/2, height/2); 
  noStroke();
  fill(192, 128, 64);
  sphere(300); 
  
  float sRadius = 10; 
  
   for (int j = 0; j < 11; j++) {
    for (float i = -PI; i < PI; i += PI / 40) {
      float t = i + PI/30 + angle; 
      float p = map(j, 0, 10, -HALF_PI, HALF_PI); 
      float R = (310 + radius * j) * cos(p); 
      float x = cos(t) * R;
      float y = sin(p) * 305;
      float z = sin(t) * R;
      pushMatrix();
      translate(x, y, z);
      sphere(sRadius);
      popMatrix();
    }
  }
  angle += 0.01;
  if (radius <= max_R) {
    radius += radius_S;
  }
}
