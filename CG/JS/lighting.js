var lights = [];
var createdLights = 1;

var guiLight = {
  index: 0,
};

    var lightPosition = [0, 0, 200];
    var alvo = [0, 0, 0];
    var tap = [0, 1, 0];
    var lightLookAt = m4.lookAt(lightPosition, alvo, tap);
    const liRotationX = m4.xRotation(
      degToRad(lights[guiLight.index].rotation.x)
    );
    const liRotationY = m4.yRotation(
      degToRad(lights[guiLight.index].rotation.y)
    );
    const liRotationZ = m4.zRotation(
      degToRad(lights[guiLight.index].rotation.z)
    );
    lightMatrix = m4.multiply(
      lightLookAt,
      m4.multiply(liRotationX, m4.multiply(liRotationY, liRotationZ))
    );
    lightMatrix = m4.translate(
      lightMatrix,
      lights[guiLights.index].translation.x,
      lights[guiLights.index].translation.y,
      lights[guiLights.index].translation.z
    );

const addlight = () => {
  if (createdLights < 4) {
  const light = {
    name: `Luz ${createdLights}`,
    rotation: {
      x: 0,
      y: 0,
      z: 0,
    },
    translation: {
      x: 0,
      y: 0,
      z: 360,
    },
    active: false,
  };
  createdLights++;
  ligths.push(light);
  }
};

activateLight = (index) => {
  lights = lights.map((light, i) => { //operação sobre vetores, pegar uma câmera e testar se o índice da posição for igual ao index, aí o camera recebe true, senão false
    i === index ? (light.active = true) : (light.active = false);
    return camera;
  });

  lights.forEach((light,index) => {
    if(light.active) {
      guiLight.index = index;
    }
  })
};

function setNormals(gl) {
  var normals = new Float32Array([
          // left column front
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,

          // top rung front
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,

          // middle rung front
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,
          0, 0, 1,

          // left column back
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,

          // top rung back
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,

          // middle rung back
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,
          0, 0, -1,

          // top
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,

          // top rung right
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,

          // under top rung
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,

          // between top rung and middle
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,

          // top of middle rung
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,
          0, 1, 0,

          // right of middle rung
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,

          // bottom of middle rung.
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,

          // right of bottom
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,
          1, 0, 0,

          // bottom
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,
          0, -1, 0,

          // left side
          -1, 0, 0,
          -1, 0, 0,
          -1, 0, 0,
          -1, 0, 0,
          -1, 0, 0,
          -1, 0, 0,
  ]);
  gl.bufferData(gl.ARRAY_BUFFER, normals, gl.STATIC_DRAW);
}