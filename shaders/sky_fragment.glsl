#version 120
uniform sampler2D sampler;
uniform float timer;
varying vec2 fragment_uv;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = timer;
  tmpvar_1.y = fragment_uv.y;
  gl_FragColor = texture2D (sampler, tmpvar_1);
}
