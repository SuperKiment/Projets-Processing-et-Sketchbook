#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
uniform vec2 resolution;
varying vec4 vertTexCoord;

void main() {
  vec2 uv = vertTexCoord.st;

  // Pixelisation
  float pixels = 320.0;
  float ratio = resolution.x / resolution.y;
  vec2 pixUV = floor(uv * vec2(pixels, pixels / ratio)) / vec2(pixels, pixels / ratio);
  vec4 col = texture2D(texture, pixUV);

  // Palette réduite (4 niveaux par canal = 64 couleurs)
  col.rgb = floor(col.rgb * 5.0 + 0.5) / 5.0;

  // Effet CRT : courbure subtile
  vec2 curved = uv - 0.5;
  curved *= 1.0 + dot(curved, curved) * 0.06;
  curved += 0.5;

  // Bord noir si on sort de l'écran courbé
  if (curved.x < 0.0 || curved.x > 1.0 || curved.y < 0.0 || curved.y > 1.0) {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    return;
  }

  // Grille de pixels visible
  float gridX = mod(uv.x * pixels, 1.0);
  float gridY = mod(uv.y * pixels / ratio, 1.0);
  float grid = smoothstep(0.0, 0.1, gridX) * smoothstep(0.0, 0.1, gridY);
  col.rgb *= mix(0.7, 1.0, grid);

  // Teinte verte rétro subtile
  col.rgb *= vec3(0.85, 1.05, 0.85);

  // Vignette
  float d = distance(uv, vec2(0.5, 0.5));
  float vig = smoothstep(0.75, 0.25, d);
  col.rgb *= mix(0.3, 1.0, vig);

  gl_FragColor = col;
}
