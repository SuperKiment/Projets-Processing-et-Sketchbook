#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
varying vec4 vertTexCoord;

vec3 heatmap(float t) {
  // Noir -> Bleu -> Violet -> Rouge -> Orange -> Jaune -> Blanc
  vec3 c;
  if (t < 0.15) {
    c = mix(vec3(0.0, 0.0, 0.1), vec3(0.1, 0.0, 0.5), t / 0.15);
  } else if (t < 0.35) {
    c = mix(vec3(0.1, 0.0, 0.5), vec3(0.6, 0.0, 0.4), (t - 0.15) / 0.2);
  } else if (t < 0.55) {
    c = mix(vec3(0.6, 0.0, 0.4), vec3(1.0, 0.2, 0.0), (t - 0.35) / 0.2);
  } else if (t < 0.75) {
    c = mix(vec3(1.0, 0.2, 0.0), vec3(1.0, 0.7, 0.0), (t - 0.55) / 0.2);
  } else if (t < 0.9) {
    c = mix(vec3(1.0, 0.7, 0.0), vec3(1.0, 1.0, 0.3), (t - 0.75) / 0.15);
  } else {
    c = mix(vec3(1.0, 1.0, 0.3), vec3(1.0, 1.0, 1.0), (t - 0.9) / 0.1);
  }
  return c;
}

void main() {
  vec2 uv = vertTexCoord.st;
  vec4 col = texture2D(texture, uv);

  // Luminance comme température
  float temp = dot(col.rgb, vec3(0.299, 0.587, 0.114));

  // Boost les couleurs vives (sources de chaleur)
  float sat = length(col.rgb - vec3(temp));
  temp += sat * 0.4;
  temp = clamp(temp, 0.0, 1.0);

  // Appliquer palette thermique
  vec3 result = heatmap(temp);

  // Léger bruit thermique
  float noise = fract(sin(dot(uv * time * 0.05, vec2(12.9898, 78.233))) * 43758.5453);
  result += (noise - 0.5) * 0.04;

  // Vignette
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.8, 0.25, d);
  result *= mix(0.3, 1.0, vig);

  gl_FragColor = vec4(result, 1.0);
}
