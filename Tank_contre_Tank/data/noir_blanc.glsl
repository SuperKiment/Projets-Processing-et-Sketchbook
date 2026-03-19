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

  // Luminance perceptuelle
  float lum = dot(col.rgb, vec3(0.299, 0.587, 0.114));

  // Courbe de contraste S (film noir)
  lum = lum * lum * (3.0 - 2.0 * lum); // smoothstep contrast
  lum = pow(lum, 0.85); // boost légèrement les hautes lumières

  // Teinte sépia subtile
  vec3 sepia = vec3(lum * 1.05, lum * 0.98, lum * 0.85);

  // Grain de film
  float grain = fract(sin(dot(uv * time * 0.1, vec2(12.9898, 78.233))) * 43758.5453);
  sepia += (grain - 0.5) * 0.08;

  // Vignette forte (style cinéma noir)
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.7, 0.15, d);
  sepia *= mix(0.1, 1.0, vig);

  gl_FragColor = vec4(sepia, 1.0);
}
