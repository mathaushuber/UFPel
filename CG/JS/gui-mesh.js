var elementGui = new dat.GUI();
var config = {
    AddVertice: () => {
      config.SelectVertices.push(vertices.length);
    },
    RmVertice: () => {
      config.SelectVertices.pop();
    },
  	AddElem: () => {
  	createGuiElement();
  	},
    //-0.44, -0.77, 0.3
    //-0.69, 0.54, 0.9
    //0.97, 0.24, -0.58
  	SelectCameras: [],
    SelectVertices: [],
    SelectRender: ['TRIANGLES', 'LINES'],
    selected: false,
    typeRender: 'TRIANGLES',
    triangleTranslation: 0,
  	index: 0,
    value: 5,
    Vp1x: -0.44,
    Vp1y: -0.77,
    Vp1z: 0.3,
    Vp2x: -0.69,
    Vp2y: 0.54,
    Vp2z: 0.9,
    Vp3x: 0.97, 
    Vp3y: 0.24,
    Vp3z: -0.58,
  	zoom: 120,
  	subdivision: 0,
    angleMesh: 120,
    angle: 0,
    count: 2,
  	fieldVision: 60,
    tessellationGrad: 5,
  	elements: [],
  	elementTarget: "none",
};

const loadGUI = () => {
  config.AddElem();
};

const createGuiElement = () => {
  if (elementGui) {
    elementGui.destroy();
  }
  elementGui = new dat.GUI();

  elementGui
    .add(config, "subdivision", 0, 9, 1)
    .name("Subdivisão")
    .listen().onChange(() => {
    config.degreeSubdivision = config.subdivision;
    rerender();
    });

  elementGui
  .add(config, "AddVertice")
  .name("Add Vértice")
  .listen().onChange(() => {
    config.count++;
    createVertices();
    rerender();
  });

  elementGui
  .add(config, "AddVertice")
  .name("RM Vértice")
  .listen().onChange(() => {
    config.count--;
    removeVertices();
    rerender();
  });

  elementGui
    .add(config, "angleMesh", 0, 380, 1)
    .name("Ângulo")
    .listen().onChange(() => {
      config.angle = config.angleMesh * Math.PI / 180;
      rerender(config.angle);
    });

  elementGui
    .add(config, "SelectRender", config.SelectRender)
    .name("Renderização")
    .listen()
    .onChange(() => {
       config.typeRender = config.SelectRender;
       config.selected = true;
       if(config.selected == false){
        config.typeRender = 'LINES';
       }
       rerender();
    });

  const verticePositionGui = elementGui.addFolder("Vertices");
    verticePositionGui
    .add(config, "Vp1x", -1, 1, 0.1)
    .name("Vértice X1")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp1x);
    });

    verticePositionGui
    .add(config, "Vp1y", -1, 1, 0.1)
    .name("Vértice Y1")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp1y);
    });

    verticePositionGui
    .add(config, "Vp1z", -1, 1, 0.1)
    .name("Vértice Z1")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp1z);
    });

    verticePositionGui
    .add(config, "Vp2x", -1, 1, 0.1)
    .name("Vértice X2")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp2x);
    });

    verticePositionGui
    .add(config, "Vp2y", -1, 1, 0.1)
    .name("Vértice Y2")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp2y);
    });

    verticePositionGui
    .add(config, "Vp2z", -1, 1, 0.1)
    .name("Vértice Z2")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp2z);
    });

    verticePositionGui
    .add(config, "Vp3x", -1, 1, 0.1)
    .name("Vértice X3")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp3x);
    });

    verticePositionGui
    .add(config, "Vp3y", -1, 1, 0.1)
    .name("Vértice Y3")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp3y);
    });

    verticePositionGui
    .add(config, "Vp3z", -1, 1, 0.1)
    .name("Vértice Z3")
    .listen().onChange(() => {
      initializeVertices();
      rerender(config.Vp3z);
    });




};
