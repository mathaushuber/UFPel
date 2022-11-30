var reverseLightDirectionLocation; 

/*
-- Função main.
*/
window.onload = function main() {

  function computeMatrix(viewProjectionMatrix, translation, rotation, scale) {
    var matrix;
    matrix = m4.translate(
      viewProjectionMatrix,
      translation.x,
      translation.y,
      translation.z
    );
    matrix = m4.xRotate(matrix, rotation.x);
    matrix = m4.yRotate(matrix, rotation.y);
    matrix = m4.zRotate(matrix, rotation.z);
    matrix = m4.scale(matrix, scale.x, scale.y, scale.z);
    return matrix;
  }

  initializeGui();
  loadAnimationGUI();
  /*
  -- Renderizando.
  */
  function render() {  
    // Configurando o WebGL.
    twgl.resizeCanvasToDisplaySize(gl.canvas);
    gl.clearColor(0, 0, 0, 0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
    gl.enable(gl.DEPTH_TEST);
    gl.enable(gl.CULL_FACE);  
    gl.useProgram(sceneProgram.program);

    //Recebendo a localização de uma variável de atributo em um dado passado pelos shaders.
    var positionAttributeLocation = gl.getAttribLocation(sceneProgram.program, "a_position");
    var normalAttributeLocation = gl.getAttribLocation(sceneProgram.program, "a_normal");
    
    /*
    Recebendo a localização de uma variável uniforme específica passado pelos shaders.
    A variável uniforme é retornada como um objeto, que é um identificador opaco usado para especificar onde na memória da GPU tá localizada essa variável.
    */
    var worldViewProjectionLocation =
      gl.getUniformLocation(sceneProgram.program, "u_matrix");
    var worldInverseTransposeLocation =
      gl.getUniformLocation(sceneProgram.program, "u_worldInverseTranspose");
    var colorLocation = gl.getUniformLocation(sceneProgram.program, "u_colorMult");
    reverseLightDirectionLocation =
      gl.getUniformLocation(sceneProgram.program, "u_reverseLightDirection");
    
    //Cria e inicializa um WebGLBuffer armazenando dados dos vértices
    var positionBuffer = gl.createBuffer();
    var vao = gl.createVertexArray();

    gl.bindVertexArray(vao);

    // Vinculando a variável de posições a um buffer
    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);

    // Ativando o atributo das posições
    gl.enableVertexAttribArray(positionAttributeLocation);

    // Cria o buffer das normais, torna-o o ARRAY_BUFFER atual e copie os valores normais
    var normalBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, normalBuffer);
   
    // Ativando o atributo das normais
    gl.enableVertexAttribArray(normalAttributeLocation);

    // Criando as variáveis para obter os dados do buffer 
    var size = 3;          
    var type = gl.FLOAT;   
    var normalize = true; // normalizando os dados
    var stride = 0;       
    var offset = 0;        
    gl.vertexAttribPointer(
        normalAttributeLocation, size, type, normalize, stride, offset);

    /*
    -- Câmera.
    Precisamos efetivamente mover o mundo na frente da câmera. A maneira mais fácil de fazer isso é usar uma matriz inversa.
    Uma vez que tenhamos a matriz que nos diz como mover e girar a câmera da origem para onde queremos, podemos calcular seu inverso, 
    o que nos dará uma matriz que nos diz como mover e girar todo o resto na quantidade oposta que efetivamente faça com que a câmera 
    esteja em (0, 0, 0) e movemos todos os objetos na cena na frente dela.
    */
    var fieldVisionRadians = degToRad(60);
    var fRotationRadians = 0;
    var fieldVisionRadians = degToRad(config.fieldVision);
    var aspect = gl.canvas.clientWidth / gl.canvas.clientHeight;
    var zNear = 1;
    var zFar = 2000;
    var projectionMatrix = m4.perspective(fieldVisionRadians, aspect, zNear, zFar);

    // Calculando a matriz da câmera usando look at
    var cameraPosition = [0, 0, 200];
    var target = [0, 0, 0];
    var up = [0, 1, 0];
    if (config.elementTarget !== "none") {
      const targetIndex = config.elements.indexOf(
        parseInt(config.elementTarget)
      );
      target = [
        objects[targetIndex].translation.x,
        objects[targetIndex].translation.y,
        objects[targetIndex].translation.z,
      ];
    }

    var cameraLookAt = m4.lookAt(cameraPosition, target, up);
    const camRotationX = m4.xRotation(
      degToRad(cameras[guiCameras.index].rotation.x)
    );
    const camRotationY = m4.yRotation(
      degToRad(cameras[guiCameras.index].rotation.y)
    );
    const camRotationZ = m4.zRotation(
      degToRad(cameras[guiCameras.index].rotation.z)
    );
    cameraMatrix = m4.multiply(
      cameraLookAt,
      m4.multiply(camRotationX, m4.multiply(camRotationY, camRotationZ))
    );
    cameraMatrix = m4.translate(
      cameraMatrix,
      cameras[guiCameras.index].translation.x,
      cameras[guiCameras.index].translation.y,
      cameras[guiCameras.index].translation.z
    );
    

    // Matriz de visualização da matriz da câmera.
    var viewMatrix = m4.inverse(cameraMatrix);

    var viewProjectionMatrix = m4.multiply(projectionMatrix, viewMatrix);

    var worldMatrix = m4.yRotation(objects);
    var worldViewProjectionMatrix = m4.multiply(viewProjectionMatrix, worldMatrix);
    var worldInverseMatrix = m4.inverse(worldMatrix);
    var worldInverseTransposeMatrix = m4.transpose(worldInverseMatrix);

    /*
    -- Curva de Bezier.
    Tentei usar uma implementação que achei na internet da curva de bezier, basicamente testei nas cordenadas de um cubo, que na minha visão era mais fácil.
    */
    if(config.bezier == true){
      var posObj = Bezier(objects,[config.Bp1x,config.Bp1y],[config.Bp2x,config.Bp2y],[config.Bp3x,config.Bp3y],[config.Bp4x,config.Bp4y]);
      var objTX = posObj[0];
      var objTY = posObj[1];
    }
    else{
      objTX = config.objTX;
      objTY = config.objTY;
    }

    // Setando as matrizes
    gl.uniformMatrix4fv(
        worldViewProjectionLocation, false,
        worldViewProjectionMatrix);
    gl.uniformMatrix4fv(
        worldInverseTransposeLocation, false,
        worldInverseTransposeMatrix);

    // Setando a direção da luz
    gl.uniform3fv(reverseLightDirectionLocation, m4.normalize([config.lDirectionX, config.lDirectionY, config.lDirectionZ]));

    var matrix = m4.xRotation(Math.PI);
    matrix = m4.translate(matrix, -50, -75, -15);

    objects.forEach((object) => {
      object.uniforms.u_matrix = computeMatrix(
        viewProjectionMatrix,
        object.translation,
        object.rotation,
        object.scale
      );
    });

    drawElements.forEach(function (object) {
      const programInfo = object.programInfo;
      gl.useProgram(programInfo.program);
      // Configurando todos os atributos necessários.
      gl.bindVertexArray(object.vertexArray);
      // Definindo os uniformes que acabamos de calcular
      twgl.setUniforms(programInfo, object.uniforms);
      twgl.drawBufferInfo(gl, object.bufferInfo);
    });

    if (methodAnimation.length || methodAnimationCamera.length || methodAnimationLight.length) {
      if (methodAnimation.length) {
        if (methodAnimation[0].steps > 0) {
          setTimeout(() => {
            requestAnimationFrame(render);
            methodAnimation[0].steps--;
            animation(objects);
          }, 200 / config.fps);
        }
        else {
          methodAnimation.shift();
          requestAnimationFrame(render);
        }
      }
      if(methodAnimationCamera.length){
        if (methodAnimationCamera[0].stepsCamera > 0) {
          setTimeout(() => {
            requestAnimationFrame(render);
            methodAnimationCamera[0].stepsCamera--;
            animationCamera(cameras);
          }, 200 / config.fps);
        }
        else {
          methodAnimationCamera.shift();
          requestAnimationFrame(render);
        }
      }
      if(methodAnimationLight.length){
        if (methodAnimationLight[0].stepsLight > 0) {
          setTimeout(() => {
            requestAnimationFrame(render);
            methodAnimationLight[0].stepsLight--;
            animationLight();
          }, 200 / config.fps);
        }
        else {
          methodAnimationLight.shift();
          requestAnimationFrame(render);
        }
      }
    } else {
      requestAnimationFrame(render);
    }
  }

  requestAnimationFrame(render);
}

/*
-- Criando um objeto com as informações do triângulo para posteriormente exportar.
*/
function createObj(){
    const objScene = {
    elements: objects,
    cameras: cameras,
    animation: animation,
    animationCamera: animationCamera,
    };
    downloadObjectAsJson(objScene);
}

/*
-- Exportando o objeto.
*/
function downloadObjectAsJson(exportObj){
    var exportName = "scene";
    var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(exportObj));
    var downloadAnchorNode = document.createElement('a');
    downloadAnchorNode.setAttribute("href",     dataStr);
    downloadAnchorNode.setAttribute("download", exportName + ".json");
    document.body.appendChild(downloadAnchorNode); // required for firefox
    downloadAnchorNode.click();
    downloadAnchorNode.remove();
}