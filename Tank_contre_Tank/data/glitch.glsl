#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
uniform vec2 resolution;
varying vec4 vertTexCoord;

float rand(vec2 co) {
  return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
  vec2 uv = vertTexCoord.st;

  // Blocs de glitch
  float blockSize = 0.03 + sin(time * 1.3) * 0.01;
  float blockY = floor(uv.y / blockSize) * blockSize;
  float glitchStrength = step(0.92, rand(vec2(blockY, floor(time * 8.0))));
  float glitchOffset = (rand(vec2(blockY, floor(time * 12.0))) - 0.5) * 0.08 * glitchStrength;

  // Décalage RGB par canal
  float r = texture2D(texture, vec2(uv.x + glitchOffset + 0.003, uv.y)).r;
  float g = texture2D(texture, vec2(uv.x + glitchOffset, uv.y)).g;
  float b = texture2D(texture, vec2(uv.x + glitchOffset - 0.003, uv.y)).b;
  vec3 col = vec3(r, g, b);

  // Bandes de couleur aléatoires
  float bandGlitch = step(0.97, rand(vec2(floor(uv.y * 100.0), floor(time * 5.0))));
  col = mix(col, vec3(rand(vec2(time, uv.y)), 0.0, rand(vec2(uv.y, time))), bandGlitch * 0.7);

  // Shift de teinte brusque par zone
  float zoneShift = step(0.85, rand(vec2(floor(uv.x * 8.0), floor(time * 3.0))));
  col.rb = mix(col.rb, col.br, zoneShift);

  // Scanlines rapides
  float scan = sin(uv.y * resolution.y * 0.8 + time * 50.0) * 0.04;
  col -= scan;

  // Bruit numérique
  float noise = rand(vec2(uv.x * time * 0.3, uv.y * time * 0.3)) * 0.05;
  col += noise - 0.025;

  // Vignette
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.8, 0.25, d);
  col *= mix(0.3, 1.0, vig);

  gl_FragColor = vec4(col, 1.0);
}
