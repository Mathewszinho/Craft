#version 120
uniform mat4 matrix;
uniform vec3 camera;
uniform float fog_distance;
uniform int ortho;
attribute vec4 position;
attribute vec3 normal;
attribute vec4 uv;
varying vec2 fragment_uv;
varying float fragment_ao;
varying float fragment_light;
varying float fog_factor;
varying float fog_height;
varying float diffuse;
void main ()
{
  gl_Position = (matrix * position);
  fragment_uv = uv.xy;
  fragment_ao = (0.3 + ((1.0 - uv.z) * 0.7));
  fragment_light = uv.w;
  diffuse = max (0.0, dot (normal, vec3(-0.5773503, 0.5773503, -0.5773503)));
  if (bool(ortho)) {
    fog_factor = 0.0;
    fog_height = 0.0;
  } else {
    vec3 tmpvar_1;
    tmpvar_1 = (camera - position.xyz);
    fog_factor = pow (clamp ((
      sqrt(dot (tmpvar_1, tmpvar_1))
     / fog_distance), 0.0, 1.0), 4.0);
    float tmpvar_2;
    tmpvar_2 = (position.y - camera.y);
    float tmpvar_3;
    vec2 tmpvar_4;
    tmpvar_4 = (position.xz - camera.xz);
    tmpvar_3 = sqrt(dot (tmpvar_4, tmpvar_4));
    float tmpvar_5;
    float tmpvar_6;
    tmpvar_6 = (min (abs(
      (tmpvar_2 / tmpvar_3)
    ), 1.0) / max (abs(
      (tmpvar_2 / tmpvar_3)
    ), 1.0));
    float tmpvar_7;
    tmpvar_7 = (tmpvar_6 * tmpvar_6);
    tmpvar_7 = (((
      ((((
        ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
       * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
     * tmpvar_7) + 0.9999793) * tmpvar_6);
    tmpvar_7 = (tmpvar_7 + (float(
      (abs((tmpvar_2 / tmpvar_3)) > 1.0)
    ) * (
      (tmpvar_7 * -2.0)
     + 1.570796)));
    tmpvar_5 = (tmpvar_7 * sign((tmpvar_2 / tmpvar_3)));
    if ((abs(tmpvar_3) > (1e-08 * abs(tmpvar_2)))) {
      if ((tmpvar_3 < 0.0)) {
        if ((tmpvar_2 >= 0.0)) {
          tmpvar_5 += 3.141593;
        } else {
          tmpvar_5 = (tmpvar_5 - 3.141593);
        };
      };
    } else {
      tmpvar_5 = (sign(tmpvar_2) * 1.570796);
    };
    fog_height = ((tmpvar_5 + 1.570796) / 3.141593);
  };
}
