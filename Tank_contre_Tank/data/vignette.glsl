#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
varying vec4 vertTexCoord;

void main() {
  vec2 uv = vertTexCoord.st;
  vec4 col = texture2D(texture, uv);

  // Vignette
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.75, 0.25, d);
  col.rgb *= mix(0.35, 1.0, vig);

  // Léger boost contraste
  col.rgb = pow(col.rgb, vec3(0.95));

  gl_FragColor = col;
}
