const vertexShaderSource = `#version 300 es
in vec4 a_position;
in vec4 a_color;

uniform float angle;

out vec4 v_color;

void
main()
{
    gl_Position = a_position;
    v_color = a_color;    
}
`;

const fragmentShaderSource = `#version 300 es
precision highp float;
in vec4 v_color;

out vec4 outColor;

void
main()
{
    outColor = vec4( 1.0, 0.0, 0.0, 1.0 );
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