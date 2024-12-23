float PI = 3.141592653589793;

uniform vec2 uResolution; // in pixel
uniform float uTime; // in s
uniform vec2 uCursor; // 0 (left) 0 (top) / 1 (right) 1 (bottom)
uniform float uScrollVelocity; // - (scroll up) / + (scroll down)
uniform sampler2D uTexture; // texture
uniform vec2 uTextureSize; // size of texture
uniform vec2 uQuadSize; // size of texture element
uniform float uBorderRadius; // pixel value
uniform float uMouseEnter; // 0 - 1 (enter) / 1 - 0 (leave)
uniform vec2 uMouseOverPos; // 0 (left) 0 (top) / 1 (right) 1 (bottom)

#include './resources/utils.glsl';

out vec2 vUv;  // 0 (left) 0 (bottom) - 1 (top) 1 (right)
out vec2 vUvCover;


vec3 deformationCurve(vec3 position, vec2 uv) {
  //position.y = position.y - (sin(uv.x * PI) * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);
  //position.y = position.y - (pow(uv.x, 2) * PI * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);
  //position.y = position.y - (uv.x * PI * min(abs(uScrollVelocity), 2.0) * sign(uScrollVelocity) * -0.005);
  //position.y = position.y - (pow(uv.x, 1.5) * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);
  //position.y = position.y - ((uv.x + pow(uv.x, 2)) * 0.5 * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);
  //position.y = position.y - (pow(uv.x, 1.5) * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);

  //position.y = position.y - (pow(abs(uv.x - 0.5), 1.5) * min(abs(uScrollVelocity), 5.0) * sign(uScrollVelocity) * -0.01);
  position.y = position.y - (uv.x * min(abs(uScrollVelocity), 1.2) * sign(uScrollVelocity) * -0.01);

  return position;
}

void main() {
  vUv = uv;
  vUvCover = getCoverUvVert(uv, uTextureSize, uQuadSize);

  vec3 deformedPosition = deformationCurve(position, vUvCover);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(deformedPosition, 1.0);
}
