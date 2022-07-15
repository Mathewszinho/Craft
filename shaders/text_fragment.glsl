#version 120
uniform sampler2D sampler;
uniform bool is_sign;
varying vec2 fragment_uv;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (sampler, fragment_uv);
  color_1 = tmpvar_2;
  if (is_sign) {
    if ((tmpvar_2 == vec4(1.0, 1.0, 1.0, 1.0))) {
      discard;
    };
  } else {
    color_1.w = max (tmpvar_2.w, 0.4);
  };
  gl_FragColor = color_1;
}
