/*
-- Variáveis globais.
*/
const {gl, meshProgram} = initializeWorld();
var canvas;
var points = []; //array vazio, colocamos os pontos aqui enquanto fazemos a subdivisão
var vertices;
var countPoints = 9; 
var flagSubdivision = false;
/*
var data = new Uint8Array([
      100,  77, 3,
      120, 54,   9,
        97, 24, 58,
    ]);
*/
/*
-- Função main.
*/
window.onload = function main()
{
    twgl.resizeCanvasToDisplaySize(gl.canvas);
    gl.useProgram(meshProgram.program)

    initializeVertices();
    loadGUI();
   
    subdivision(vertices[0], vertices[1], vertices[2], config.subdivision);
    translate(vertices[0], vertices[1], vertices[2]);
    // Configurando o  WebGL
    gl.viewport( 0, 0, gl.canvas.width, gl.canvas.height );
    gl.clearColor( 0.0, 0.0, 0.0, 1.0 );

    // Carregando os dados na GPU
    var bufferId = gl.createBuffer();
    gl.bindBuffer( gl.ARRAY_BUFFER, bufferId );
    gl.bufferData( gl.ARRAY_BUFFER, flatten(vertices), gl.STATIC_DRAW );


    // Associando as variáveis de saída dos shaders com nosso buffer de dados
    var vPosition = gl.getAttribLocation( meshProgram.program, "a_position" );
    var texcoordAttributeLocation = gl.getAttribLocation(meshProgram.program, "a_texcoord");
    var textureLocation = gl.getUniformLocation(meshProgram.program, "u_texture");
    var matrixLocation = gl.getUniformLocation(meshProgram.program, "u_matrix");
    var colorLocation = gl.getUniformLocation(meshProgram.program, "u_colorMult");
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, true, 0, 0 );
    gl.enableVertexAttribArray( vPosition );
/*
    var texcoordBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, texcoordBuffer);

    // Tell the attribute how to get data out of texcoordBuffer (ARRAY_BUFFER)
    var size = 2;          // 2 components per iteration
    var type = gl.FLOAT;   // the data is 32bit floating point values
    var normalize = true;  // convert from 0-255 to 0.0-1.0
    var stride = 0;        // 0 = move forward size * sizeof(type) each iteration to get the next color
    var offset = 0;        // start at the beginning of the buffer
    gl.vertexAttribPointer(
    texcoordAttributeLocation, size, type, normalize, stride, offset);
    gl.enableVertexAttribArray(texcoordAttributeLocation);
    var texture = gl.createTexture();

    gl.activeTexture(gl.TEXTURE0 + 0);

    gl.bindTexture(gl.TEXTURE_2D, texture);

    {
    const level = 0;
    const internalFormat = gl.R8;
    const width = 3;
    const height = 2;
    const border = 0;
    const format = gl.RED;
    const type = gl.UNSIGNED_BYTE;
    gl.pixelStorei(gl.UNPACK_ALIGNMENT, 1);
    gl.texImage2D(gl.TEXTURE_2D, level, internalFormat, width, height, border,
                  format, type, data);

    // set the filtering so we don't need mips
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
  }

   gl.uniform1i(textureLocation, 0);
   */
   
    render();
};

/*
-- Iniciando os vértices.
*/
function initializeVertices(){
    vertices = [
        vec4(config.Vp1x, config.Vp1y, config.Vp1z, 1), 
        vec4(config.Vp2x, config.Vp2y, config.Vp2z, 1),  
        vec4(config.Vp3x, config.Vp3y, config.Vp3z, 1)
    ]; 

    
    config.angle = config.angleMesh * Math.PI / 180;
    if(config.selected == false){
        config.typeRender = 'TRIANGLES';
    }
    else{
        config.typeRender = config.SelectRender;
    }
    config.degreeSubdivision = config.subdivision;
    console.log(points.length);
    console.log(vertices.length)
}

/*
-- Gerando curvas.
A curva se dá pela rotação nesse caso, quanto mais subdivisões temos a sensação de curva ao rotacionarmos o objeto. É uma gambiarra que achei no stackoverflow, sei que não está correto!
Para obter x' e y' multiplicamos a matriz de transformação pela coordenada atual (x,y), uma vez que normalizamos.
*/
function curveOfRotation(vector){
    var x = vector[0],
        y = vector[1],
        d = Math.sqrt(x * x + y * y),
        sinAngle = Math.sin(d * config.angle),
        cosAngle = Math.cos(d * config.angle);
        /*
            x' = x cos(d0) - y sin(d0)
            y' = x sin(d0) + y cos(d0)

        */

        return [x * cosAngle - y * sinAngle, x * sinAngle + y * cosAngle];
}

/*
-- Criando novos vértices.
O número de pontos a cada subdivisão é o número de vértices. O triângulo inicia com 3 vértices, o array "points" é renderizado 2x.
Para cada subdivisão temos um novo triângulo dentro de outro triângulo. Para isso a equação seria V *= 4, considerando V como o número de vértices. Com isso, quando aplicamos um passo
na subdivisão, partindo de 3 vértices chegamos a 12.
Ex: Passo 0 = 3 * 1 -> 3
    Passo 1 = 3 * 4 -> 12
    Passo 2 = 12 * 4 -> 48
    Passo 3 = 48 * 4 -> 192
    Passo 4 = 192 * 4 -> 768
    Passo 5 = 768 * 4 -> 3072
    Passo 6 = 3072 * 4 -> 12288
    Passo 7 = 12288 * 4 -> 49152
    Passo 8 = 49152 * 4 -> 196608
    Passo 9 = 196608 * 4 -> 786432
Nota-se que a subdivisão é feita através de recursão, podemos fazer quantos passos de recursão quisermos, contudo, o custo computacional aumentará exponencialmente. 
*/
function createVertices(){
    newVertice = vec4(Math.random(), Math.random(), Math.random(), Math.random());
    points.push(newVertice);
    countPoints++;
    if(countPoints == 12 || 
       countPoints == 48 ||
       countPoints == 192 ||
       countPoints == 768 ||
       countPoints == 3072 ||
       countPoints == 12288 ||
       countPoints == 49152 ||
       countPoints == 196608 ||
       countPoints == 786432){
        config.subdivision++;
        flagSubdivision = true;
    }
  console.log('countPoints', countPoints);
  console.log('flag', flagSubdivision);   
}

/*
-- Removendo vértices, sempre do final.
A flag serve basicamente para não decrementarmos a subdivisão desnecessariamente.
*/
function removeVertices(){
    countPoints--;
    if(countPoints < 12 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 12 && countPoints < 48 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 48 && countPoints < 192 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 192 && countPoints < 768 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 768 && countPoints < 3072 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 3072 && countPoints < 12288 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 12288 && countPoints < 49152 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 49152 && countPoints < 196608 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    else if(countPoints > 196608 && countPoints < 786432 && flagSubdivision == true){
        config.subdivision--;
        flagSubdivision = false;
    }
    points.pop();
    console.log('countPoints', countPoints);
    console.log('flag', flagSubdivision);
}

/*
-- Construindo o triângulo.
*/
function triangle (a, b, c){

    a = curveOfRotation(a), b = curveOfRotation(b), c = curveOfRotation(c);

    if(config.typeRender=="TRIANGLES"){
        points.push(a, b, c);
    } else {
        points.push(a, b);
        points.push(b, c);
        points.push(a, c);
    }
}

/*
-- Criando o triângulo transladado.
Cada vértice recebe o retorno da função de translação com as novas posições.
*/
function triangleTranslate (a, b, c)
{

    a = translate(a), b = translate(b), c = translate(c);

    if(config.typeRender=="TRIANGLES"){
        points.push(a, b, c);
    } else {
        points.push(a, b);
        points.push(b, c);
        points.push(a, c);
    }
}

/*
Estou fazendo uma triangulação que nada mais é do que uma subdivisão de um triângulo em simplexos. Neste caso os triângulos da triangulação são obrigados a cumprir aresta-por-aresta e vértice-a-vértice.
Diferentes tipos de triangulação podem ser definidos, dependendo tanto do objeto geométrico que será subdividido como da forma como a subdivisão é determinada. No nosso caso, como temos
um triângulo e queremos dar a sensação de que, com vários triângulos teremos uma figura geométrica fechada (sem buracos) mesmo quando renderizada a partir de linhas, lembremos que
tudo em WEBGL é uma linha, ponto ou triângulo, temos a opção de na interface renderizarmos como linha ou triângulo, de forma a enxergar melhor a subdivisão, com isso quanto mais 
passos de subdivisão teremos a sensação de estarmos renderizando em forma de triângulos, pois várias triângulações tapariam cada vez mais os buracos. 
Em geral a ideia é que cada simplexo fique no centro de cada triângulo, com isso passamos os três vértices (a,b,c) e a posição em que cada simplexo ficará na triângulação.
*/
function subdivision(a, b, c, count){
    if(count===0){
        //quando estamos no final da recursão, empurramos os triângulos para o array
        triangle(a,b,c);


    } else {
        //bipartindo os lados
        var ab = bisec( a, b, 0.5 );
        var ac = bisec( a, c, 0.5 );
        var bc = bisec( b, c, 0.5 );

        --count;

        //criando novos triângulos 
        subdivision(a, ab, ac, count);
        subdivision(c, ac, bc, count);
        subdivision(b, bc, ab, count);
        subdivision(ac, bc, ab, count);

    }

}

/*
-- Renderizando novamente com os vértices atualizados.
*/
function rerender(){
    points = [];
    subdivision(vertices[0], vertices[1], vertices[2], config.subdivision);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(points), gl.STATIC_DRAW );
    render();
}

/*
-- Renderizando.
*/
function render() {
    gl.clear( gl.COLOR_BUFFER_BIT );
    if(config.typeRender=="TRIANGLES"){
        gl.drawArrays( gl.TRIANGLES, 0, points.length );
    }
    else {
        gl.drawArrays( gl.LINES, 0, points.length );   
    }
}

/*
-- Para calcular o centro do triângulo a maneira mais fácil que achei nos fóruns foi usando uma interpolação linear entre a e b
 utilizando um valor s para ponderar os valores entre eles. 
 a -> vértice do início do intervalo de onde interpolar
 b -> vértice do fim do intervalo de onde interpolar
 s -> o valor a ser usado para interpolar a e b

 tem o exemplo da mesma função em OpenGL em: https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml 
*/
function bisec(a,b,s){
    if ( typeof s !== "number" ) {
        throw "bisec: o último parâmetro" + s + "deve ser um número";
    }

    if ( a.length != b.length ) {
        throw "vetores não tem a mesma dimensão";
    }

    var result = [];
    for ( var i = 0; i < a.length; ++i ) {
        result.push( (1.0 - s) * a[i] + s * b[i] );
    }

    return result;
}

/*
-- Efetuando a translação.
Movendo todas as coordenadas dos objetos ao longo dos eixos coordenados.
*/
function translate(vector){
    if ( Array.isArray(vector) && vector.length == 4 ) {
        z = vector[2];
        y = vector[1];
        x = vector[0];
    }

    var result = mat4();
    result[0][3] = x;
    result[1][3] = y;
    result[2][3] = z;

    return result;
}

/*
-- Criando um objeto com as informações do triângulo para posteriormente exportar.
*/
function createObj(){
    const triangleMesh = {
    angleMesh: config.angle,
    typeRender: config.typeRender,
    vertices: vertices,
    subdivision: config.subdivision,
    };
    
    downloadObjectAsJson(triangleMesh);
}

/*
-- Exportando o objeto.
*/
function downloadObjectAsJson(exportObj){
    var exportName = "mesh";
    var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(exportObj));
    var downloadAnchorNode = document.createElement('a');
    downloadAnchorNode.setAttribute("href",     dataStr);
    downloadAnchorNode.setAttribute("download", exportName + ".json");
    document.body.appendChild(downloadAnchorNode); // para funcionar no firefox.
    
    downloadAnchorNode.click();
    downloadAnchorNode.remove();
}

