#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

varying float sh;


void main() {
  float intensity;
  vec4 color;
  intensity = max(0.0, dot(vertLightDir, normalize(vertNormal)));

  if (intensity > pow(0.95, fraction)) {
    color = vec4(vec3(0.5+0.5*sh), 1.0);
  } else if (intensity > pow(0.75, fraction)) {
    color = vec4(vec3(0.4+0.4*sh), 1.0);
  } else if (intensity > pow(0.25, fraction)) {
    color = vec4(vec3(0.3+0.3*sh), 1.0);
  } else {
    color = vec4(vec3(0.2+0.2*sh), 1.0);
  }

  gl_FragColor = color * vertColor;
}