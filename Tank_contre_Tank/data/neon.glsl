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

  float lum = dot(col.rgb, vec3(0.299, 0.587, 0.114));

  // Fond très sombre
  vec3 result = col.rgb * 0.15;

  // Détection de bords (différence avec voisins)
  float edge = 0.0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) continue;
      vec2 offset = vec2(float(i), float(j)) * 0.002;
      vec4 neighbor = texture2D(texture, uv + offset);
      float nLum = dot(neighbor.rgb, vec3(0.299, 0.587, 0.114));
      edge += abs(lum - nLum);
    }
  }
  edge = smoothstep(0.02, 0.15, edge / 8.0);

  // Les bords brillent en néon (couleur originale boostée)
  vec3 hsv = rgb2hsv(col.rgb);
  hsv.y = 1.0; // saturation max
  hsv.z = 1.0; // luminosité max
  vec3 neonColor = hsv2rgb(hsv);

  // Glow sur les zones lumineuses
  float glow = smoothstep(0.25, 0.8, lum);

  // Combiner : fond sombre + bords néon + glow
  result += neonColor * edge * 1.5;
  result += col.rgb * glow * 1.2;

  // Bloom néon
  vec3 bloom = vec3(0.0);
  for (int i = 1; i <= 3; i++) {
    float o = float(i) * 0.005;
    bloom += texture2D(texture, uv + vec2(o, 0.0)).rgb;
    bloom += texture2D(texture, uv - vec2(o, 0.0)).rgb;
    bloom += texture2D(texture, uv + vec2(0.0, o)).rgb;
    bloom += texture2D(texture, uv - vec2(0.0, o)).rgb;
  }
  bloom /= 12.0;
  float bloomLum = dot(bloom, vec3(0.299, 0.587, 0.114));
  result += bloom * smoothstep(0.2, 0.6, bloomLum) * 0.6;

  // Vignette sombre
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.8, 0.2, d);
  result *= mix(0.1, 1.0, vig);

  gl_FragColor = vec4(result, 1.0);
}
