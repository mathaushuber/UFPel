const {gl, meshProgram} = initializeWorld();
var canvas;
var points = []; //empty array, we put the points here as we do the subdivision
var tessellationGrade;
var angle;
var renderType;
var vertices;
var radios;

window.onload = function init()
{
    twgl.resizeCanvasToDisplaySize(gl.canvas);
    /*gl.clearColor(0, 0, 0, 0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
    gl.enable(gl.DEPTH_TEST);
    gl.enable(gl.CULL_FACE);  */
    gl.useProgram(meshProgram.program)

    initVars();
    initUI();
    loadGUI();
   
    //tessellation
    tessellation(vertices[0], vertices[1], vertices[2], tessellationGrade);

    //  Configure WebGL
    gl.viewport( 0, 0, gl.canvas.width, gl.canvas.height );
    gl.clearColor( 0.0, 0.0, 0.0, 1.0 );

    //  Load shaders and initialize attribute buffers
    //var program = initShaders( gl, "vertex-shader", "fragment-shader" );
    //gl.useProgram( program );

    // Load the data into the GPU
    var bufferId = gl.createBuffer();
    gl.bindBuffer( gl.ARRAY_BUFFER, bufferId );
    gl.bufferData( gl.ARRAY_BUFFER, flatten(points), gl.STATIC_DRAW );


    // Associate out shader variables with our data buffer
    var vPosition = gl.getAttribLocation( meshProgram.program, "a_position" );
    var colorLocation = gl.getUniformLocation(meshProgram.program, "u_colorMult");
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, false, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

     // Compute the camera's matrix using look at.
    var cameraPosition = [0, 0, 200];
    var target = [0, 0, 0];
    var up = [0, 1, 0];
    if (config.elementTarget !== "none") {
      const targetIndex = config.elements.indexOf(
        parseInt(config.elementTarget)
      );
      target = [
        points[targetIndex].translation.x,
        points[targetIndex].translation.y,
        points[targetIndex].translation.z,
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
    

    // Make a view matrix from the camera matrix.
    var viewMatrix = m4.inverse(cameraMatrix);

    render();
};

function initVars(){

    vertices = [
        vec4(-0.44, -0.77, 0.3, 0.88), // left-down corner
        vec4(-0.69, 0.54, 0.9, -0.14),  // center-up corner
        vec4(0.97, 0.24, -0.58, -0.69) // right-down corner
    ]; 

    // Twist Angle
    var angleValue = document.getElementById("slider-angle").value;
    angle = angleValue * Math.PI / 180;

    //Render Type
    radios = document.getElementsByName('render-type');
    for (var i = 0, length = radios.length; i < length; i++) {
        if (radios[i].checked) {
            renderType = radios[i].value;
            break;
        }
    }

    //Tessellation Grade
    tessellationGrade = document.getElementById("slider-tessellation").value;


}

function initUI(){

    // Twist UI
    document.getElementById("slider-angle").addEventListener("input", function(e){
            angle = this.value * Math.PI / 180;
            rerender();
    }, false);

    // Render Type UI
    for (var i = 0, length = radios.length; i < length; i++) {
       radios[i].onclick = function() {
            renderType = this.value;
            rerender();
        };
    }

    // Tessellation Grade UI
    document.getElementById("slider-tessellation").addEventListener("input", function(e){
            tessellationGrade = this.value;
            rerender();
    }, false);


}

function twist(vector){
    var x = vector[0],
        y = vector[1],
        d = Math.sqrt(x * x + y * y),
        sinAngle = Math.sin(d * angle),
        cosAngle = Math.cos(d * angle);
        /*
            x' = x cos(d0) - y sin(d0)
            y' = x sin(d0) + y cos(d0)

        */

        return [x * cosAngle - y * sinAngle, x * sinAngle + y * cosAngle];
}

function triangle (a, b, c){

    a = twist(a), b = twist(b), c = twist(c);

    if(renderType=="TRIANGLES"){
        points.push(a, b, c);
    } else {
        points.push(a, b);
        points.push(b, c);
        points.push(a, c);
    }
}

function tessellation(a, b, c, count){

    if(count===0){
        //when we are at the end of the recursion we push 
        //the triangles to the array
        triangle(a,b,c);


    } else {
        //bisect the sides
        var ab = mix( a, b, 0.5 );
        var ac = mix( a, c, 0.5 );
        var bc = mix( b, c, 0.5 );

        --count;

        //new triangles
        tessellation(a, ab, ac, count);
        tessellation(c, ac, bc, count);
        tessellation(b, bc, ab, count);
        tessellation(ac, bc, ab, count);

    }

}

function rerender(){
    points = [];
    tessellation(vertices[0], vertices[1], vertices[2], tessellationGrade);
    gl.bufferData( gl.ARRAY_BUFFER, flatten(points), gl.STATIC_DRAW );
    render();
}

function render() {
    gl.clear( gl.COLOR_BUFFER_BIT );
    if(renderType=="TRIANGLES"){
        gl.drawArrays( gl.TRIANGLES, 0, points.length );
    }
    else {
        gl.drawArrays( gl.LINES, 0, points.length );   
    }
}