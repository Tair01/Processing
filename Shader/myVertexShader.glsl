uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

//varying vec4 vertColor;
varying vec3 vertNormal;
varying vec4 vertPosition;
varying vec4 vertColor;

void main() {
  gl_Position = transform * position;    
  //vec3 ecPosition = vec3(modelview * position);  
  //vec3 ecNormal = normalize(normalMatrix * normal);

  //vec3 direction = normalize(lightPosition.xyz - ecPosition);    
  //float intensity = max(0.0, dot(direction, ecNormal));

  //vertColor = vec4(intensity, intensity, intensity, 1) * color;     
  vertNormal   = normal;
  vertPosition = position;
  vertColor    = color;
}