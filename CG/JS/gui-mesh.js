var cameraGui = new dat.GUI();
var elementGui = new dat.GUI();
var config = {
	AddCamera: () => {
    config.SelectCameras.push(cameras.length);
    addCamera();
    createGuiCamera();
  	},
  	AddElem: () => {
  	createGuiElement();
  	},
  	SelectCameras: [],
    SelectRender: ['TRIANGLES', 'LINES'],
    tipoRender: 'LINES',
  	index: 0,
    value: 5,
  	zoom: 120,
  	subdivisao: 5,
    angulo: 120,
    angle: 0,
  	fieldOfView: 60,
    tessellationGrad: 0,
  	elements: [],
  	elementTarget: "none",
};

const loadGUI = () => {
  config.AddCamera();
  config.AddElem();
};

const createGuiElement = () => {
  if (elementGui) {
    elementGui.destroy();
  }
  elementGui = new dat.GUI();

  elementGui
    .add(config, "subdivisao", 1, 10, 1)
    .name("Subdivisão")
    .listen().onChange(() => {
    config.tesselationGrad = config.subdivisao;
    rerender();
    });

  elementGui
    .add(config, "angulo", 0, 380, 1)
    .name("Ângulo")
    .listen().onChange(() => {
      config.angle = config.angulo * Math.PI / 180;
      rerender(config.angle);
    });

  elementGui
    .add(config, "SelectRender", config.SelectRender)
    .name("Renderização")
    .listen()
    .onChange(() => {
      config.tipoRender = config.SelectRender;
      rerender();
    }); 

};

const createGuiCamera = () => {
  if (cameraGui) {
    cameraGui.destroy();
  }
  cameraGui = new dat.GUI();

  cameraGui
    .add(config, "zoom", 0, 180, 1)
    .name("Zoom")
    .listen().onChange(() => (config.fieldOfView = 180 - config.zoom));

  cameraGui.add(config, "AddCamera").name("Adicionar Cam");
//  lightGui.add(config, "AddLight").name("Adicionar Luz");
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