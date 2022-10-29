    var lightPosition = [0, 0, 200];
    var alvo = [0, 0, 0];
    var tap = [0, 1, 0];
    var lights = [0,1,2];
    var createdLights = 1;
    var guiLights = {
      index: 0,
    };

    var lightLookAt = m4.lookAt(lightPosition, alvo, tap);
    const liRotationX = m4.xRotation(
      degToRad(lights[guiLights.index].rotation.x),
    );
    const liRotationY = m4.yRotation(
      degToRad(lights[guiLights.index].rotation.y)
    );
    const liRotationZ = m4.zRotation(
      degToRad(lights[guiLights.index].rotation.z)
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
      guiLights.index = index;
    }
  })
};