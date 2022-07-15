#version 120
uniform sampler2D sampler;
uniform sampler2D sky_sampler;
uniform float timer;
uniform float daylight;
uniform int ortho;
varying vec2 fragment_uv;
varying float fragment_ao;
varying float fragment_light;
varying float fog_factor;
varying float fog_height;
varying float diffuse;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (sampler, fragment_uv);
  if ((tmpvar_1.xyz == vec3(1.0, 0.0, 1.0))) {
    discard;
  };
  bool tmpvar_2;
  tmpvar_2 = (tmpvar_1.xyz == vec3(1.0, 1.0, 1.0));
  if ((tmpvar_2 && bool(ortho))) {
    discard;
  };
  float tmpvar_3;
  if (tmpvar_2) {
    tmpvar_3 = (1.0 - (diffuse * 0.2));
  } else {
    tmpvar_3 = diffuse;
  };
  float tmpvar_4;
  if (tmpvar_2) {
    tmpvar_4 = (1.0 - ((1.0 - fragment_ao) * 0.2));
  } else {
    tmpvar_4 = fragment_ao;
  };
  float tmpvar_5;
  tmpvar_5 = min (1.0, (daylight + fragment_light));
  vec2 tmpvar_6;
  tmpvar_6.x = timer;
  tmpvar_6.y = fog_height;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = mix (clamp ((
    (tmpvar_1.xyz * (vec3(((tmpvar_5 * 0.3) + 0.2)) + (vec3((
      (tmpvar_5 * 0.3)
     + 0.2)) * min (1.0, 
      (tmpvar_3 + fragment_light)
    ))))
   * 
    min (1.0, (tmpvar_4 + fragment_light))
  ), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0)), texture2D (sky_sampler, tmpvar_6).xyz, fog_factor);
  gl_FragColor = tmpvar_7;
}
