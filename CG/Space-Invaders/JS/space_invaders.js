var countEnemyDefeated = 0;
var flag = 0;
var random = 0;

window.onload = function init() {
    const {gl, spaceProgram} = initializeWorld();
    loadGUI();
    gl.viewport( 0, 0, gl.canvas.width, gl.canvas.height );
    //gl.clearColor( 0, 0, 0, 1.0 );
    //Deixei comentado o clearColor para poder mostrar o background do canvas que é uma imagem do espaço

    render();
};

window.addEventListener("keydown", getKey, false);

var buttonInput = 0;

function getKey(key) {
  if (key.key == "ArrowLeft"){//mover para a esquerda.
    buttonInput = 1;
  }
  else if (key.key == "ArrowRight"){//mover para a direita.
    buttonInput = 2;
  }
  else if (key.key == "r"){//reiniciar o jogo.
    buttonInput = 4;
  }
  else if (key.key == " "){//atirar.
    buttonInput = 3;
  }
  else{
    buttonInput = 0;
  }
}

function render() {

/*
Geometria das naves inimigas.
*/
    var enemy = [
      //nave inimiga 1 (segundo bot a direita)
      vec2 (config.navePosition-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition, config.naveHeight-0.2),
      vec2 (config.navePosition, config.naveHeight-0.3),
      vec2 (config.navePosition-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition, config.naveHeight-0.3),
      vec2 (config.navePosition-0.1, config.naveHeight-0.3),

      //nave inimiga 2 (primeiro bot a esquerda)
      vec2 (config.navePosition2-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition2, config.naveHeight-0.2),
      vec2 (config.navePosition2, config.naveHeight-0.3),
      vec2 (config.navePosition2-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition2, config.naveHeight-0.3),
      vec2 (config.navePosition2-0.1, config.naveHeight-0.3),

      //nave inimiga 3
      vec2 (config.navePosition3-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition3, config.naveHeight-0.2),
      vec2 (config.navePosition3, config.naveHeight-0.3),
      vec2 (config.navePosition3-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition3, config.naveHeight-0.3),
      vec2 (config.navePosition3-0.1, config.naveHeight-0.3),

      //nave inimiga 4
      vec2 (config.navePosition4-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition4, config.naveHeight-0.2),
      vec2 (config.navePosition4, config.naveHeight-0.3),
      vec2 (config.navePosition4-0.1, config.naveHeight-0.2),
      vec2 (config.navePosition4, config.naveHeight-0.3),
      vec2 (config.navePosition4-0.1, config.naveHeight-0.3),

      //nave inimiga 5
      vec2 (config.navePosition5-0.1, config.naveHeight),
      vec2 (config.navePosition5, config.naveHeight),
      vec2 (config.navePosition5, config.naveHeight-0.1),
      vec2 (config.navePosition5-0.1, config.naveHeight),
      vec2 (config.navePosition5, config.naveHeight-0.1),
      vec2 (config.navePosition5-0.1, config.naveHeight-0.1),

      //nave inimiga 6
      vec2 (config.navePosition6-0.1, config.naveHeight),
      vec2 (config.navePosition6, config.naveHeight),
      vec2 (config.navePosition6, config.naveHeight-0.1),
      vec2 (config.navePosition6-0.1, config.naveHeight),
      vec2 (config.navePosition6, config.naveHeight-0.1),
      vec2 (config.navePosition6-0.1, config.naveHeight-0.1),

      //nave inimiga 7
      vec2 (config.navePosition7-0.1, config.naveHeight),
      vec2 (config.navePosition7, config.naveHeight),
      vec2 (config.navePosition7, config.naveHeight-0.1),
      vec2 (config.navePosition7-0.1, config.naveHeight),
      vec2 (config.navePosition7, config.naveHeight-0.1),
      vec2 (config.navePosition7-0.1, config.naveHeight-0.1),

      //nave inimiga 8
      vec2 (config.navePosition8-0.1, config.naveHeight),
      vec2 (config.navePosition8, config.naveHeight),
      vec2 (config.navePosition8, config.naveHeight-0.1),
      vec2 (config.navePosition8-0.1, config.naveHeight),
      vec2 (config.navePosition8, config.naveHeight-0.1),
      vec2 (config.navePosition8-0.1, config.naveHeight-0.1)
    ];

/*
Geometria da nave do jogador.
*/
    var player = [
      vec2 (config.playerPosition-0.1, -0.9),
      vec2 (config.playerPosition, -0.9),
      vec2 (config.playerPosition, -1),
      vec2 (config.playerPosition-0.1, -0.9),
      vec2 (config.playerPosition, -1),
      vec2 (config.playerPosition-0.1, -1)
    ];

/*
Geometria das balas das naves inimigas.
*/
    var balaEnemy = [
      //bala da nave 1
      vec2 (config.balaPosition-0.08, config.balaHeight-0.3),
      vec2 (config.balaPosition-0.02, config.balaHeight-0.3),
      vec2 (config.balaPosition-0.05, config.balaHeight-0.35),

      //bala da nave 2
      vec2 (config.balaPosition2-0.08, config.balaHeight-0.3),
      vec2 (config.balaPosition2-0.02, config.balaHeight-0.3),
      vec2 (config.balaPosition2-0.05, config.balaHeight-0.35),

      //bala da nave 3
      vec2 (config.balaPosition3-0.08, config.balaHeight-0.3),
      vec2 (config.balaPosition3-0.02, config.balaHeight-0.3),
      vec2 (config.balaPosition3-0.05, config.balaHeight-0.35),

      //bala da nave 4
      vec2 (config.balaPosition4-0.08, config.balaHeight-0.3),
      vec2 (config.balaPosition4-0.02, config.balaHeight-0.3),
      vec2 (config.balaPosition4-0.05, config.balaHeight-0.35),

      //bala da nave 5
      vec2 (config.balaPosition5-0.08, config.balaHeight2-0.1),
      vec2 (config.balaPosition5-0.02, config.balaHeight2-0.1),
      vec2 (config.balaPosition5-0.05, config.balaHeight2-0.15),

      //bala da nave 6
      vec2 (config.balaPosition6-0.08, config.balaHeight2-0.1),
      vec2 (config.balaPosition6-0.02, config.balaHeight2-0.1),
      vec2 (config.balaPosition6-0.05, config.balaHeight2-0.15),

      //bala da nave 7
      vec2 (config.balaPosition7-0.08, config.balaHeight2-0.1),
      vec2 (config.balaPosition7-0.02, config.balaHeight2-0.1),
      vec2 (config.balaPosition7-0.05, config.balaHeight2-0.15),

      //bala da nave 8
      vec2 (config.balaPosition8-0.08, config.balaHeight2-0.1),
      vec2 (config.balaPosition8-0.02, config.balaHeight2-0.1),
      vec2 (config.balaPosition8-0.05, config.balaHeight2-0.15)
    ];

/*
Geometria da bala do jogador.
*/
    var balaPlayer = [
      vec2 (config.balaPlayerWidth-0.08, config.balaPlayerHeight),
      vec2 (config.balaPlayerWidth-0.02, config.balaPlayerHeight),
      vec2 (config.balaPlayerWidth-0.05, config.balaPlayerHeight+0.05)
    ];

/*
Condição de vitória, a cada nave derrotada aumenta um no contador de naves inimigas derrotadas, como são 8 naves inimigas,
quando o contador chega a 8 é exibido o alerta de vitória.
*/
    if (countEnemyDefeated == 8){
      Swal.fire({icon: 'success', title: 'Vitória', text: 'Ameaça alienígena neutralizada, a raça humana vive mais um dia!'});
      countEnemyDefeated++;
    }

    if (buttonInput == 4){
      document.location.reload();
    }

/*
Flag para aumentar a velocidade do jogo conforme o tempo, ou seja, cai em 0.1 a altura das naves inimigas em relação
a nave do jogador e a cada 250 ciclos também aumenta a velocidade das naves inimigas
*/
    if (flag == 250){
      config.naveHeight = config.naveHeight - 0.1;
      flag = 0;
      config.speed = config.speed + 0.1;
    }
    flag++;

/*
Movimento aleatório para cada nave inimiga
*/
    random = Math.random();
    if (random > 0.98){ 
      config.naveMove = config.naveMove * -1;
    }
    config.navePosition = config.navePosition + (config.naveMove * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove2 = config.naveMove2 * -1;
    }
    config.navePosition2 = config.navePosition2 + (config.naveMove2 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove3 = config.naveMove3 * -1;
    }
    config.navePosition3 = config.navePosition3 + (config.naveMove3 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove4 = config.naveMove4 * -1;
    }
    config.navePosition4 = config.navePosition4 + (config.naveMove4 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove5 = config.naveMove5 * -1;
    }
    config.navePosition5 = config.navePosition5 + (config.naveMove5 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove6 = config.naveMove6 * -1;
    }
    config.navePosition6 = config.navePosition6 + (config.naveMove6 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove7 = config.naveMove7 * -1;
    }
    config.navePosition7 = config.navePosition7 + (config.naveMove7 * config.speed);

    random = Math.random();
    if (random > 0.98){
      config.naveMove8 = config.naveMove8 * -1;
    }
    config.navePosition8 = config.navePosition8 + (config.naveMove8 * config.speed);

/*
Colisão com base nas bordas externas
*/
    if (config.navePosition > 1){
      config.naveMove = -0.01;
    }
    if (config.navePosition < -0.9){
      config.naveMove = 0.01;
    }

    if (config.navePosition2 > 1){
      config.naveMove2 = -0.01;
    }
    if (config.navePosition2 < -0.9){
      config.naveMove2 = 0.01;
    }

    if (config.navePosition3 > 1){
      config.naveMove3 = -0.01;
    }
    if (config.navePosition3 < -0.9){
      config.naveMove3 = 0.01;
    }

    if (config.navePosition4 > 1){
      config.naveMove4 = -0.01;
    }
    if (config.navePosition4 < -0.9){
      config.naveMove4 = 0.01;
    }

    if (config.navePosition5 > 1){
      config.naveMove5 = -0.01;
    }
    if (config.navePosition5 < -0.9){
      config.naveMove5 = 0.01;
    }

    if (config.navePosition6 > 1){
      config.naveMove6 = -0.01;
    }
    if (config.navePosition6 < -0.9){
      config.naveMove6 = 0.01;
    }

    if (config.navePosition7 > 1){
      config.naveMove7 = -0.01;
    }
    if (config.navePosition7 < -0.9){
      config.naveMove7 = 0.01;
    }

    if (config.navePosition8 > 1){
      config.naveMove8 = -0.01;
    }
    if (config.navePosition8 < -0.9){
      config.naveMove8 = 0.01;
    }

/*
Colisão com outros inimigos
*/
    if (config.navePosition > config.navePosition3-0.15){
      config.naveMove = -0.01;
      config.naveMove3 = 0.01;
    }
    if (config.navePosition2 > config.navePosition-0.15){
      config.naveMove2 = -0.01
      config.naveMove = 0.01
    }
    if(config.navePosition3 > config.navePosition4-0.15){
      config.naveMove3 = -0.01;
      config.naveMove4 = 0.01;
    }
    if (config.navePosition5 > config.navePosition6-0.15){
      config.naveMove5 = -0.01;
      config.naveMove6 = 0.01;
    }
    if (config.navePosition6 > config.navePosition7-0.15){
      config.naveMove6 = -0.01
      config.naveMove7 = 0.01
    }
    if(config.navePosition7 > config.navePosition8-0.15){
      config.naveMove7 = -0.01;
      config.naveMove8 = 0.01;
    }

/*
Condições para quando uma nave chegar ao fundo voltar ao topo.
*/
    if (config.naveHeight <= -0.6){
      if (countEnemyDefeated != -1){
        Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
        countEnemyDefeated = -1;
      }
      document.location.reload();
    }

/*
Configuração das balas inimigas, quem atira primeiro é quem está mais ao topo, ou seja, as naves na linha de frente.
*/
    if (config.drawSquare || config.drawSquare2 || config.drawSquare3 || config.drawSquare4){
      config.balaHeight = config.balaHeight - config.balaSpeed;
      if (config.balaHeight < -1){
        config.balaHeight = config.naveHeight;
        config.balaPosition = config.navePosition;
        config.balaPosition2 = config.navePosition2;
        config.balaPosition3 = config.navePosition3;
        config.balaPosition4 = config.navePosition4;
      }
    }
    //A linha superior não dispara até que todos os quadrados da linha inferior sejam destruídos.
    else{
      config.tap = true;
      if (config.naveFrst){
        config.balaHeight2 = config.naveHeight;
        config.balaPosition5 = config.navePosition5;
        config.balaPosition6 = config.navePosition6;
        config.balaPosition7 = config.navePosition7;
        config.balaPosition8 = config.navePosition8;
        config.naveFrst = false;
      }
      config.balaHeight2 = config.balaHeight2 - config.balaSpeedPlayer;
      if (config.balaHeight2 < -1){
        config.balaHeight2 = config.naveHeight;
        config.balaPosition5 = config.navePosition5;
        config.balaPosition6 = config.navePosition6;
        config.balaPosition7 = config.navePosition7;
        config.balaPosition8 = config.navePosition8;
      }
    }

/*
Detecção de colisão das balas com o jogador.
*/
    if(config.balaHeight < -0.65 && config.balaHeight > -0.75){
      if(config.drawSquare){
        if(config.balaPosition-0.05 < config.playerPosition && config.balaPosition-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare2){
        if(config.balaPosition2-0.05 < config.playerPosition && config.balaPosition2-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare3){
        if(config.balaPosition3-0.05 < config.playerPosition && config.balaPosition3-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare4){
        if(config.balaPosition4-0.05 < config.playerPosition && config.balaPosition4-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
    }
    if(config.balaHeight2 < -0.6){
      if(config.drawSquare5){
        if(config.balaPosition5-0.05 < config.playerPosition && config.balaPosition5-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare6){
        if(config.balaPosition6-0.05 < config.playerPosition && config.balaPosition6-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare7){
        if(config.balaPosition7-0.05 < config.playerPosition && config.balaPosition7-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
      if(config.drawSquare8){
        if(config.balaPosition8-0.05 < config.playerPosition && config.balaPosition8-0.05 > config.playerPosition-0.1){
          if (countEnemyDefeated != -1){
            Swal.fire({icon: 'error', title: 'Derrota', text: 'Nave eliminada, alienígenas dominaram a terra!'});
            countEnemyDefeated = -1;
          }
        }
      }
    }

/*
Movimento da nave do jogador.
*/
    if(buttonInput == 1){
      config.playerPosition = config.playerPosition - 0.05;
      if (config.playerPosition <= -1){
        config.playerPosition = config.playerPosition + 2;
      }
      buttonInput = 0;
    }
    if(buttonInput == 2){
      config.playerPosition = config.playerPosition + 0.05;
      if (config.playerPosition >= 1){
        config.playerPosition = config.playerPosition - 2;
      }
      buttonInput = 0;
    }

/*
Configuração da bala do jogador, depois que o jogador aperta o botão de espaço para atirar, é ativada a flag e o botão
que faz basicamente um skip, no intuito de não deixar o jogador atirar várias vezes ao mesmo tempo.
*/
    if (buttonInput == 3){
      config.naveBala = true;
      buttonInput = 0;
    }
    if (!config.naveBala){
      config.balaPlayerWidth = config.playerPosition;
    }
    else{
      config.balaPlayerHeight = config.balaPlayerHeight + 0.05;
    }
    if (config.balaPlayerHeight > 1){
      config.naveBala = false;
      config.balaPlayerWidth = config.playerPosition;
      config.balaPlayerHeight = -1;
    }

/*
Detecção de colisão da bala do jogador com a nave inimiga
*/
    if ((config.balaPlayerHeight < config.naveHeight-0.2) && (config.balaPlayerHeight > config.naveHeight-0.3)){
      if (config.drawSquare && config.balaPlayerWidth-0.05 < config.navePosition && config.balaPlayerWidth-0.05 > config.navePosition-0.1){
        countEnemyDefeated++;
        config.drawSquare = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare2 && config.balaPlayerWidth-0.05 < config.navePosition2 && config.balaPlayerWidth-0.05 > config.navePosition2-0.1){
        countEnemyDefeated++;
        config.drawSquare2 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare3 && config.balaPlayerWidth-0.05 < config.navePosition3 && config.balaPlayerWidth-0.05 > config.navePosition3-0.1){
        countEnemyDefeated++;
        config.drawSquare3 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare4 && config.balaPlayerWidth-0.05 < config.navePosition4 && config.balaPlayerWidth-0.05 > config.navePosition4-0.1){
        countEnemyDefeated++;
        config.drawSquare4 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
    }
    if ((config.balaPlayerHeight < config.naveHeight) && (config.balaPlayerHeight > config.naveHeight-0.1)){
      if (config.drawSquare5 && config.balaPlayerWidth-0.05 < config.navePosition5 && config.balaPlayerWidth-0.05 > config.navePosition5-0.1){
        countEnemyDefeated++;
        config.drawSquare5 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare6 && config.balaPlayerWidth-0.05 < config.navePosition6 && config.balaPlayerWidth-0.05 > config.navePosition6-0.1){
        countEnemyDefeated++;
        config.drawSquare6 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare7 && config.balaPlayerWidth-0.05 < config.navePosition7 && config.balaPlayerWidth-0.05 > config.navePosition7-0.1){
        countEnemyDefeated++;
        config.drawSquare7 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
      if (config.drawSquare8 && config.balaPlayerWidth-0.05 < config.navePosition8 && config.balaPlayerWidth-0.05 > config.navePosition8-0.1){
        countEnemyDefeated++;
        config.drawSquare8 = false;
        config.balaPlayerHeight = -1;
        config.naveBala = false;
        config.balaPlayerWidth = config.playerPosition;
      }
    }

    const {gl, spaceProgram} = initializeWorld();
    gl.useProgram( spaceProgram.program );
    var fColorLocation = gl.getUniformLocation(spaceProgram.program, "a_color");

/*
Desenhando as naves inimigas.
*/
    var bufferId = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(enemy), gl.STATIC_DRAW );

    var vPosition = gl.getAttribLocation( spaceProgram.program, "a_position" );
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, true, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

    gl.uniform4f(fColorLocation, 1.0, 0.0, 0.0, 1.0);

    gl.clear( gl.COLOR_BUFFER_BIT );
    if(config.drawSquare){
      gl.drawArrays( gl.TRIANGLES, 0, 6 );
    }
    if(config.drawSquare2){
      gl.drawArrays( gl.TRIANGLES, 6, 6 );
    }
    if(config.drawSquare3){
      gl.drawArrays( gl.TRIANGLES, 12, 6 );
    }
    if(config.drawSquare4){
      gl.drawArrays( gl.TRIANGLES, 18, 6 );
    }
    if(config.drawSquare5){
      gl.drawArrays( gl.TRIANGLES, 24, 6 );
    }
    if(config.drawSquare6){
      gl.drawArrays( gl.TRIANGLES, 30, 6 );
    }
    if(config.drawSquare7){
      gl.drawArrays( gl.TRIANGLES, 36, 6 );
    }
    if(config.drawSquare8){
      gl.drawArrays( gl.TRIANGLES, 42, 6 );
    }

/*
Desenhando as balas das naves inimigas.
*/
    var bufferId = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(balaEnemy), gl.STATIC_DRAW );

    var vPosition = gl.getAttribLocation( spaceProgram.program, "a_position" );
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, true, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

    gl.uniform4f(fColorLocation, 1.0, 0.0, 0.0, 1.0);//red

    if(config.drawSquare){
      gl.drawArrays( gl.TRIANGLES, 0, 3);
    }
    if(config.drawSquare2){
      gl.drawArrays( gl.TRIANGLES, 3, 3);
    }
    if(config.drawSquare3){
      gl.drawArrays( gl.TRIANGLES, 6, 3);
    }
    if(config.drawSquare4){
      gl.drawArrays( gl.TRIANGLES, 9, 3);
    }
    if(config.tap && config.drawSquare5){
      gl.drawArrays( gl.TRIANGLES, 12, 3);
    }
    if(config.tap && config.drawSquare6){
      gl.drawArrays( gl.TRIANGLES, 15, 3);
    }
    if(config.tap && config.drawSquare7){
      gl.drawArrays( gl.TRIANGLES, 18, 3);
    }
    if(config.tap && config.drawSquare8){
      gl.drawArrays( gl.TRIANGLES, 21, 3);
    }

/*
Desenhando a nave do jogador.
*/
    var bufferId = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(player), gl.STATIC_DRAW );

    var vPosition = gl.getAttribLocation( spaceProgram.program, "a_position" );
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, true, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

    gl.uniform4f(fColorLocation, 0.0, 1.0, 0.0, 1.0);

    gl.drawArrays( gl.TRIANGLES, 0, 6 );

/*
Desenhando a bala do jogador.
*/
    var bufferId = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(balaPlayer), gl.STATIC_DRAW );

    var vPosition = gl.getAttribLocation( spaceProgram.program, "a_position" );
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, true, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

    gl.uniform4f(fColorLocation, 0.0, 1.0, 0.0, 1.0);//green

    gl.drawArrays( gl.TRIANGLES, 0, 3);

/*
Chamando animação.
*/
    requestAnimationFrame(render);
}
