const vertexShaderSource = `#version 300 es
in vec4 a_position;

out vec4 v_color;
void
main()
{
    gl_Position = a_position;
    v_color = gl_Position * 0.5 + 0.5; 
}
`;

const fragmentShaderSource = `#version 300 es
precision highp float;
in vec4 v_color;

out vec4 outColor;

void
main()
{
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
  const spaceProgram = twgl.createProgramInfo(gl, [
    vertexShaderSource,
    fragmentShaderSource,
  ]);

  return {
    gl,
    spaceProgram,
  };
};