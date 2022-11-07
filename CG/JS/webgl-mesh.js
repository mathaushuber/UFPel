const vertexShaderSource = `#version 300 es
in vec4 a_position;
//in vec4 a_color;
//in vec2 a_texcoord;

uniform float angle;

out vec4 v_color;
out vec2 v_texcoord;

void
main()
{
    gl_Position = a_position;
    v_color = gl_Position * 0.5 + 0.5;   
//    v_texcoord = a_texcoord; 
}
`;

const fragmentShaderSource = `#version 300 es
precision highp float;
in vec4 v_color;
//in vec2 v_texcoord;

//uniform sampler2D u_texture;

out vec4 outColor;

void
main()
{
    //outColor = texture(u_texture, v_texcoord);
    outColor = v_color;
}
`;

const initializeWorld = () => {
  const canvas = document.querySelector("#canvas");
  const gl = canvas.getContext("webgl2");
  if (!gl) {
    return;
  }
  twgl.setAttributePrefix("a_");
  const meshProgram = twgl.createProgramInfo(gl, [
    vertexShaderSource,
    fragmentShaderSource,
  ]);

  return {
    gl,
    meshProgram,
  };
};