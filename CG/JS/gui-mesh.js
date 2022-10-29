var cameraGui = new dat.GUI();
var elementGui = new dat.GUI();
var config = {
  	AddCamera: () => {
      config.SelectCameras.push(cameras.length);
      addCamera();
      createGuiCamera();
    	},
    AddVertice: () => {
      config.SelectVertices.push(vertices.length);
    },
  	AddElem: () => {
  	createGuiElement();
  	},
  	SelectCameras: [],
    SelectVertices: [],
    SelectRender: ['TRIANGLES', 'LINES'],
    selected: false,
    tipoRender: 'TRIANGLES',
    triangleTranslation: 0,
  	index: 0,
    value: 5,
  	zoom: 120,
  	subdivisao: 0,
    angulo: 120,
    angle: 0,
    count: 2,
  	fieldOfView: 60,
    tessellationGrad: 5,
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
    .add(config, "subdivisao", 0, 9, 1)
    .name("Subdivisão")
    .listen().onChange(() => {
    config.tesselationGrad = config.subdivisao;
    rerender();
    });

  elementGui
  .add(config, "AddVertice")
  .name("Add Vértice")
  .listen().onChange(() => {
    config.count++;
    console.log('count', config.count);
    createVertices();
    rerender();
  });

  elementGui
    .add(config, "angulo", 0, 380, 1)
    .name("Rotação")
    .listen().onChange(() => {
      config.angle = config.angulo * Math.PI / 180;
      rerender(config.angle);
    });
    elementGui
    .add(config, "triangleTranslation", 0, 380, 1)
    .name("Translação")
    .listen().onChange(() => {
      config.triangleTranslation;
    });

  elementGui
    .add(config, "SelectRender", config.SelectRender)
    .name("Renderização")
    .listen()
    .onChange(() => {
       config.tipoRender = config.SelectRender;
       config.selected = true;
       if(config.selected == false){
        config.tipoRender = 'LINES';
       }
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

  cameraGui.add(config, "AddCamera").name("Add Câmera");
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