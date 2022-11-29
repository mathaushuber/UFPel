var elementGui = new dat.GUI();
var squareGui = new dat.GUI();
var config = {
  speed: 0.5,
  naveHeight: 1,
  naveMove: 0.01,
  naveMove2: 0.01,
  naveMove3: 0.01,
  naveMove4: 0.01,
  naveMove5: 0.01,
  naveMove6: 0.01,
  naveMove7: 0.01,
  naveMove8: 0.01,
  playerPosition: 0.05,
  navePosition: 0.05,
  navePosition2: -0.15,
  navePosition3: 0.25,
  navePosition4: 0.45,
  navePosition5: -0.15,
  navePosition6: 0.05,
  navePosition7: 0.25,
  navePosition8: 0.45,
  drawSquare: true,
  drawSquare2: true,
  drawSquare3: true,
  drawSquare4: true,
  drawSquare5: true,
  drawSquare6: true,
  drawSquare7: true,
  drawSquare8: true,
  balaHeight: 1,
  balaHeight2: 1,
  balaPosition: 0.05,
  balaPosition2: -0.15,
  balaPosition3: 0.25,
  balaPosition4: 0.45,
  balaPosition5: -0.15,
  balaPosition6: 0.05,
  balaPosition7: 0.25,
  balaPosition8: 0.45,
  balaPlayerWidth: 0.05,
  balaPlayerHeight: -1,
  naveBala: false,
  tap: false,
  naveFrst: true,
  dificulty: ['easy', 'normal', 'hard'],
  balaSpeed: 0.05,
  balaSpeedPlayer: 0.05,
};

const loadGUI = () => {
  objectGui();
  createSquare();
};

const objectGui = () => {
  if (elementGui) {
    elementGui.destroy();
  }
  elementGui = new dat.GUI();

  elementGui
    .add(config, "speed", 0, 3, 0.1)
    .name("Velocidade")
    .listen().onChange(() => {
    config.speed;
    });

  elementGui
    .add(config, "naveHeight", 0, 1.5, 0.1)
    .name("Altura Naves")
    .listen().onChange(() => {
    config.naveHeight;
    });

  elementGui
    .add(config, "dificulty", config.dificulty)
    .name("Dificuldade")
    .listen().onChange(() => {
      if(config.dificulty == 'easy'){
        config.speed = 0.3;
        config.balaSpeed = 0.02;
        config.balaSpeedPlayer = 0.1;
      }
      else if(config.dificulty == 'normal'){
        config.speed = 0.8;
        config.balaSpeed = 0.05;
        config.balaSpeedPlayer = 0.5;
      }
      else{
        config.speed = 3;
        config.balaSpeed = 0.1;
        config.balaSpeedPlayer = 0.1;
      }

    });

const PositionRandomGui = elementGui.addFolder("Alea Movimento");
  
  PositionRandomGui
    .add(config, "naveMove", 0, 1, 0.1)
    .name("NaveRandom1")
    .listen().onChange(() => {
    config.naveMove;
    });

  PositionRandomGui
    .add(config, "naveMove2", 0, 1, 0.1)
    .name("NaveRandom2")
    .listen().onChange(() => {
    config.naveMove2;
    });

  PositionRandomGui
    .add(config, "naveMove3", 0, 1, 0.1)
    .name("NaveRandom3")
    .listen().onChange(() => {
    config.naveMove3;
    });

  PositionRandomGui
    .add(config, "naveMove4", 0, 1, 0.1)
    .name("NaveRandom3")
    .listen().onChange(() => {
    config.naveMove4;
    });

  PositionRandomGui
    .add(config, "naveMove5", 0, 1, 0.1)
    .name("NaveRandom3")
    .listen().onChange(() => {
    config.naveMove5;
    });

  PositionRandomGui
    .add(config, "naveMove6", 0, 1, 0.1)
    .name("NaveRandom6")
    .listen().onChange(() => {
    config.naveMove6;
    });

  PositionRandomGui
    .add(config, "naveMove7", 0, 1, 0.1)
    .name("NaveRandom7")
    .listen().onChange(() => {
    config.naveMove7;
    });

  PositionRandomGui
    .add(config, "naveMove8", 0, 1, 0.1)
    .name("NaveRandom8")
    .listen().onChange(() => {
    config.naveMove8;
    });

const PositionSquareGui = elementGui.addFolder("Posições");
  
  PositionSquareGui
    .add(config, "navePosition", -2, 2, 0.1)
    .name("navePosition")
    .listen().onChange(() => {
    config.navePosition;
    });

  PositionSquareGui
    .add(config, "navePosition2", -2, 2, 0.1)
    .name("navePosition2")
    .listen().onChange(() => {
    config.navePosition2;
    });

  PositionSquareGui
    .add(config, "navePosition3", -2, 2, 0.1)
    .name("navePosition3")
    .listen().onChange(() => {
    config.navePosition3;
    });

  PositionSquareGui
    .add(config, "navePosition4", -2, 2, 0.1)
    .name("navePosition4")
    .listen().onChange(() => {
    config.navePosition4;
    });

  PositionSquareGui
    .add(config, "navePosition5", -2, 2, 0.1)
    .name("navePosition5")
    .listen().onChange(() => {
    config.navePosition5;
    });

  PositionSquareGui
    .add(config, "navePosition6", -2, 2, 0.1)
    .name("navePosition6")
    .listen().onChange(() => {
    config.navePosition6;
    });

  PositionSquareGui
    .add(config, "navePosition7", -2, 2, 0.1)
    .name("navePosition7")
    .listen().onChange(() => {
    config.navePosition7;
    });

  PositionSquareGui
    .add(config, "navePosition8", -2, 2, 0.1)
    .name("navePosition8")
    .listen().onChange(() => {
    config.navePosition8;
    });
};

const createSquare = () => {
  if (squareGui) {
    squareGui.destroy();
  }
  squareGui = new dat.GUI();

  squareGui
    .add(config, "drawSquare", config.drawSquare)
    .name("Nave 1")
    .listen().onChange(() => {
    config.drawSquare;
    });

  squareGui
    .add(config, "drawSquare2", config.drawSquare2)
    .name("Nave 2")
    .listen().onChange(() => {
    config.drawSquare2;
    }); 

  squareGui
    .add(config, "drawSquare3", config.drawSquare3)
    .name("Nave 3")
    .listen().onChange(() => {
    config.drawSquare3;
    });

  squareGui
    .add(config, "drawSquare4", config.drawSquare4)
    .name("Nave 4")
    .listen().onChange(() => {
    config.drawSquare4;
    });

  squareGui
    .add(config, "drawSquare5", config.drawSquare5)
    .name("Nave 5")
    .listen().onChange(() => {
    config.drawSquare5;
    }); 

  squareGui
    .add(config, "drawSquare6", config.drawSquare6)
    .name("Nave 6")
    .listen().onChange(() => {
    config.drawSquare6;
    });

  squareGui
    .add(config, "drawSquare7", config.drawSquare7)
    .name("Nave 7")
    .listen().onChange(() => {
    config.drawSquare7;
    });               

  squareGui
    .add(config, "drawSquare8", config.drawSquare8)
    .name("Nave 8")
    .listen().onChange(() => {
    config.drawSquare8;
    });        
};