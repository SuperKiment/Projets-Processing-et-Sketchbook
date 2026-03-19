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

  // Tremblement horizontal
  float shake = sin(time * 15.0 + uv.y * 80.0) * 0.001;
  shake += sin(time * 3.7) * 0.0005;

  // Aberration chromatique
  float aberr = 0.003 + sin(time * 2.0) * 0.001;
  float r = texture2D(texture, vec2(uv.x + aberr + shake, uv.y)).r;
  float g = texture2D(texture, vec2(uv.x + shake, uv.y)).g;
  float b = texture2D(texture, vec2(uv.x - aberr + shake, uv.y)).b;
  vec3 col = vec3(r, g, b);

  // Scanlines
  float scanline = sin(uv.y * resolution.y * 1.5) * 0.08;
  col -= scanline;

  // Bruit VHS
  float noise = rand(vec2(uv.x * time, uv.y * time)) * 0.06;
  col += noise - 0.03;

  // Bande de tracking (glitch horizontal)
  float band = step(0.995, sin(time * 0.8 + uv.y * 3.0));
  col += band * 0.15;

  // Légère teinte chaude
  col *= vec3(1.05, 1.0, 0.92);

  // Vignette forte
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.8, 0.2, d);
  col *= mix(0.2, 1.0, vig);

  // Contraste VHS (un peu délavé)
  col = mix(col, vec3(dot(col, vec3(0.299, 0.587, 0.114))), 0.15);

  gl_FragColor = vec4(col, 1.0);
}
