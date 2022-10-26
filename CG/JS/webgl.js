const vertexShaderSource = `#version 300 es

  in vec4 a_position;
  in vec4 a_color;
  in vec3 a_normal;
  in vec2 a_texcoord;

  uniform mat4 u_matrix;
  uniform mat4 u_worldInverseTranspose;

  out vec4 v_color;
  out vec3 v_normal;
  out vec2 v_texcoord;

  void main() {
    gl_Position = u_matrix * a_position;

    v_color = a_color;
    v_texcoord = a_texcoord;
    v_normal = mat3(u_worldInverseTranspose) * a_normal;
  }
`;

const fragmentShaderSource = `#version 300 es
precision highp float;

in vec4 v_color;
in vec3 v_normal;
in vec2 v_texcoord;

uniform vec4 u_colorMult;
uniform vec3 u_reverseLightDirection;
uniform sampler2D u_texture;

out vec4 outColor;

void main() {
   vec3 normal = normalize(v_normal);
   outColor = v_color * u_colorMult;
//   outColor = vec4(texture(u_texture, v_texcoord).rrr, 1) * u_colorMult;
   float light = dot(normal, u_reverseLightDirection);
   outColor.rgb *= light;
}
`;

const initializeWorld = () => {
  const canvas = document.querySelector("#canvas");
  const gl = canvas.getContext("webgl2");
  if (!gl) {
    return;
  }
  twgl.setAttributePrefix("a_");
  const meshProgramInfo = twgl.createProgramInfo(gl, [
    vertexShaderSource,
    fragmentShaderSource,
  ]);

  return {
    gl,
    meshProgramInfo,
  };
};
