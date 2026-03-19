#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
varying vec4 vertTexCoord;

vec3 rgb2hsv(vec3 c) {
  vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
  vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
  vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
  vec2 uv = vertTexCoord.st;
  vec4 col = texture2D(texture, uv);

  // Convertir en HSV
  vec3 hsv = rgb2hsv(col.rgb);

  // Boost saturation massif
  hsv.y = pow(hsv.y, 0.5) * 1.6;
  hsv.y = min(hsv.y, 1.0);

  // Shift de teinte subtil animé
  hsv.x = fract(hsv.x + sin(time * 0.3) * 0.02);

  // Boost luminosité
  hsv.z = pow(hsv.z, 0.8) * 1.15;

  // Reconvertir
  vec3 result = hsv2rgb(hsv);

  // Bloom simulé (halos lumineux)
  vec3 bloom = vec3(0.0);
  for (int i = 1; i <= 4; i++) {
    float offset = float(i) * 0.004;
    bloom += texture2D(texture, uv + vec2(offset, 0.0)).rgb;
    bloom += texture2D(texture, uv - vec2(offset, 0.0)).rgb;
    bloom += texture2D(texture, uv + vec2(0.0, offset)).rgb;
    bloom += texture2D(texture, uv - vec2(0.0, offset)).rgb;
  }
  bloom /= 16.0;
  vec3 bloomHsv = rgb2hsv(bloom);
  bloomHsv.y = min(bloomHsv.y * 1.5, 1.0);
  bloom = hsv2rgb(bloomHsv);

  result += bloom * 0.3;

  // Vignette légère
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.8, 0.3, d);
  result *= mix(0.5, 1.0, vig);

  gl_FragColor = vec4(clamp(result, 0.0, 1.0), 1.0);
}
