uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;
uniform mat4 texMatrix;
uniform float deform;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying float sh;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  vec4 nposition= vec4(position.x, position.y, position.z, position.w);
  nposition.z += texCoord.x*deform;
  gl_Position   = transform * nposition;
  sh = 1+cos(texCoord.y);
  vertColor     = color;
  vertNormal    = normalMatrix * normal;
  vertLightDir  = -lightNormal;
}