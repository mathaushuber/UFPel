var gui = new dat.GUI();
var cameraGui = new dat.GUI();
var animationGui = new dat.GUI();
var lightGui = new dat.GUI();
var guiElements = [];

var config = {
  Aleatorio: () => {
    addElement();
    addGuiElement();
  },
  Esfera: () => {
    addElement("Esfera");
    addGuiElement();
  },
  Cubo: () => {
    addElement("Cubo");
    addGuiElement();
  },
  Cone: () => {
    addElement("Cone");
    addGuiElement();
  },
  Disco: () => {
    addElement("Disco");
    addGuiElement();
  },
  Cilindro: () => {
    addElement("Cilindro");
    addGuiElement();
  },
  Cilindro: () => {
    addElement("Cilindro");
    addGuiElement();
  },
  Plano: () => {
    addElement("Plano");
    addGuiElement();
  },
  AddCamera: () => {
    config.SelectCameras.push(cameras.length);
    addCamera();
    createGuiCamera();
  },
  AddLight: () => {
    config.SelectLights.push(lights.length);
    addLight();
    createGuiLight();
  },
  animation1: () => {
    animationObj1();
  },
  animation2: () => {
    animationObj2();
  },
  animation3: () => {
    animationObj3();
  },
  animationCamera1: () => {
    animationCam1();
  },
  animationCamera2: () => {
    animationCam2();
  },
  animationCamera3: () => {
    animationCam3();
  },
  animationLight1: () => {
    animationLight1();
  },
  animationLight2: () => {
    animationLight2();
  },
  animationLight3: () => {
    animationLight3();
  },
  isAnimationActive: false,
  SelectCameras: [],
  SelectLights: [],
  SelectElements: [],
  elementGui: 1,
  lDirectionX: 0.5,
  lDirectionY: 0.7,
  lDirectionZ: 1,
  elements: [],
  elementTarget: "none",
  index: 0,
  callback: 0,
  zoom: 120,
  fieldVision: 60,
  bezObj: 0,
  Bp1x: 50,
  Bp1y: 50,
  Bp2x: 50,
  Bp2y: 50,
  Bp3x: 50,
  Bp3y: 50,
  Bp4x: 50,
  Bp4y: 50,
  objTX: 20,
  objTY: 20,
  bezier: false,
};

const loadGUI = () => {
  config.AddCamera();

  addElement();
  addElement();

  addGuiElement();
  config.elements = objects?.map((elem) => elem.position);
  createGuiCamera();
};

const loadAnimationGUI = () => {
  const animations = animationGui.addFolder("Animações Elemento");
  animations.add(config, "animation1").name("Animação 1");
  animations.add(config, "animation2").name("Animação 2");
  animations.add(config, "animation3").name("Animação 3");
  const animations2 = animationGui.addFolder("Animações Camera");
  animations2.add(config, "animationCamera1").name("Animação 1");
  animations2.add(config, "animationCamera2").name("Animação 2");
  animations2.add(config, "animationCamera3").name("Animação 3");
  const animations3 = animationGui.addFolder("Animações Luz");
  animations3.add(config, "animationLight1").name("Animação 1");
  animations3.add(config, "animationLight2").name("Animação 2");
  animations3.add(config, "animationLight3").name("Animação 3");
  animations.open();
  animations2.open();
  animations3.open();
}

const createGuiCamera = () => {
  if (cameraGui) {
    cameraGui.destroy();
  }
  cameraGui = new dat.GUI();

  cameraGui
    .add(config, "zoom", 0, 180, 1)
    .name("Zoom")
    .listen().onChange(() => (config.fieldVision = 180 - config.zoom));

  cameraGui.add(config, "AddCamera").name("Add Câmera");
  cameraGui
    .add(config, "index", config.SelectCameras)
    .name("Câmera")
    .listen()
    .onChange(() => {
      activateCamera(parseInt(config.index));
      animationCameraType = []; //zera o vetor de animação, caso troque de câmera
      createGuiCamera(); //chama o guiCamera pra destruir e recriar a Gui
    }); 
  cameraGui
    .add(config, "elementTarget", config.elements.concat(["none"]))
    .name("Olhar de").listen().onChange(() => {
      cameras[config.index].translation.x = 0;
      cameras[config.index].translation.y = 0;
      createGuiCamera();
    });

  const lightDirectionGui = cameraGui.addFolder('Luz');
    lightDirectionGui
    .add(config, "lDirectionX", -10, 10, 0.1)
    .name("x").listen().onChange(() => {
      config.lDirectionX;
    });
    lightDirectionGui
    .add(config, "lDirectionY", -10, 10, 0.1)
    .name("y").listen().onChange(() => {
      config.lDirectionY;
    });
    lightDirectionGui
    .add(config, "lDirectionZ", -10, 10, 0.1)
    .name("z").listen().onChange(() => {
      config.lDirectionZ;
    });
  const newCameraGui = cameraGui.addFolder(`Câmera ${config.index}`);

  const camTranslation = newCameraGui.addFolder("Translação");
  camTranslation.add(cameras[config.index].translation, "x", -360, 360, 1);
  camTranslation.add(cameras[config.index].translation, "y", -360, 360, 1);
  camTranslation.add(cameras[config.index].translation, "z", -360, 360, 1);

  const camRotation = newCameraGui.addFolder("Rotação");
  camRotation.add(cameras[config.index].rotation, "x", -360, 360, 1);
  camRotation.add(cameras[config.index].rotation, "y", -360, 360, 1);
  camRotation.add(cameras[config.index].rotation, "z", -360, 360, 1);
};

const createGuiLight = () => {
  if (lightGui) {
    lightGui.destroy();
  }
  lightGui = new dat.GUI();
  console.log(lights.GUI)
  lightGui.add(config, "AddLight").name("Adicionar Luz");
  lightGui
    .add(config, "index", config.SelectLights)
    .name("Luz")
    .listen()
    .onChange(() => {
      activateLight(parseInt(config.index));
      createGuiLight(); 
    }); 
  lightGui
    .add(config, "elementTarget", config.elements.concat(["none"]))
    .name("Olhar de").listen().onChange(() => {
      lights[config.index].translation.x = 0;
      lights[config.index].translation.y = 0;
      createGuiLight();
    });


  const newLightGui = cameraGui.addFolder(`Luz ${config.index}`);

  const lightTranslation = newLightGui.addFolder("Translação");
  lightTranslation.add(lights[config.index].translation, "x", -360, 360, 1);
  lightTranslation.add(lights[config.index].translation, "y", -360, 360, 1);
  lightTranslation.add(lights[config.index].translation, "z", -360, 360, 1);

  const lightRotation = newLightGui.addFolder("Rotação");
  lightRotation.add(lights[config.index].rotation, "x", -360, 360, 1);
  lightRotation.add(lights[config.index].rotation, "y", -360, 360, 1);
  lightRotation.add(lights[config.index].rotation, "z", -360, 360, 1);
};

const addGuiElement = () => {
  if (gui) {
    gui.destroy();
  }
  gui = new dat.GUI();
  const newElement = gui.addFolder("Adicionar Elemento");
  newElement.add(config, "Aleatorio");
  newElement.add(config, "Esfera");
  newElement.add(config, "Cubo");
  newElement.add(config, "Cone");
  newElement.add(config, "Disco");
  newElement.add(config, "Cilindro");
  newElement.add(config, "Plano");
  newElement.open();
  config.elements = objects?.map((elem) => elem.position);

  const objectIndex = config.elements.indexOf(parseInt(config.elementGui));

  gui.add(config, "elementGui", config.elements).name("Elemento")
    .onChange(() => {
      addGuiElement(true);
    });
  const element = gui.addFolder(objects[objectIndex]?.name);

  if (objectIndex >= 1) {
    element.add(objects[objectIndex], "Remover");
  }

  const bezFolder = gui.addFolder("Bezier")
  bezFolder
  .add(config, "bezObj", 0,1,0.1)
  .name("Bezier")
  .listen()
  .onChange(() => {
    config.bezier = true;
  }); 
  bezFolder
  .add(config,"Bp1x",-100,300,1)
  .name("P1 X")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });
  bezFolder
  .add(config,"Bp1y",-100,300,1)
  .name("P1 Y")
  .listen()
  .onChange(() => {
    config.bezier = true;
  }); 
  bezFolder
  .add(config,"Bp2x",-100,300,1)
  .name("P2 X")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });
  bezFolder
  .add(config,"Bp2y",-100,300,1)
  .name("P2 Y")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });
  bezFolder
  .add(config,"Bp3x",-100,300,0.5)
  .name("P3 X")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });
  bezFolder
  .add(config,"Bp3y",-100,300,1)
  .name("P3 Y")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });
  bezFolder
  .add(config,"Bp4x",-100,300,1)
  .name("P4 X")
  .listen()
  .onChange(() => {
    config.bezier = true;
  })
  bezFolder
  .add(config,"Bp4y",-100,300,1)
  .name("P4 Y")
  .listen()
  .onChange(() => {
    config.bezier = true;
  });

  const elementRotation = element.addFolder("Rotação");
  elementRotation.add(objects[objectIndex].rotation, "x", -50, 500, 0.5);
  elementRotation.add(objects[objectIndex].rotation, "y", -50, 50, 0.5);
  elementRotation.add(objects[objectIndex].rotation, "z", -50, 50, 0.5);
  elementRotation.open();

  const elementTranslation = element.addFolder("Translação");
  elementTranslation.add(objects[objectIndex].translation, "x", -300, 300, 0.5);
  elementTranslation.add(objects[objectIndex].translation, "y", -300, 300, 0.5);
  elementTranslation.add(objects[objectIndex].translation, "z", -50, 50, 0.5);
  elementTranslation.open();

  const elementScale = element.addFolder("Escala");
  elementScale.add(objects[objectIndex].scale, "x", 0, 5, 0.5);
  elementScale.add(objects[objectIndex].scale, "y", 0, 5, 0.5);
  elementScale.add(objects[objectIndex].scale, "z", 0, 10, 0.5);
  elementScale.open();
  createGuiCamera();
};
