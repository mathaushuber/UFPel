"use strict";

var canvas;
var gl;
var points = []; //empty array, we put the points here as we do the subdivision
var tessellationGrade;
var angle;
var renderType;
var vertices;
var radios;

window.onload = function init()
{
    canvas = document.getElementById( "gl-canvas" );

    gl = WebGLUtils.setupWebGL( canvas );
    if ( !gl ) { alert( "WebGL isn't available" ); }

    initVars();
    initUI();
   
    //tessellation
    tessellation(vertices[0], vertices[1], vertices[2], tessellationGrade);

    //  Configure WebGL
    gl.viewport( 0, 0, canvas.width, canvas.height );
    gl.clearColor( 0.0, 0.0, 0.0, 1.0 );

    //  Load shaders and initialize attribute buffers
    var program = initShaders( gl, "vertex-shader", "fragment-shader" );
    gl.useProgram( program );

    // Load the data into the GPU
    var bufferId = gl.createBuffer();
    gl.bindBuffer( gl.ARRAY_BUFFER, bufferId );
    gl.bufferData( gl.ARRAY_BUFFER, flatten(points), gl.STATIC_DRAW );


    // Associate out shader variables with our data buffer
    var vPosition = gl.getAttribLocation( program, "vPosition" );
    gl.vertexAttribPointer( vPosition, 2, gl.FLOAT, false, 0, 0 );
    gl.enableVertexAttribArray( vPosition );

    render();
};

function initVars(){

    vertices = [
        vec3(-0.40,-0.9, 0.2), // left-down corner
        vec3( 0,  0.1, 0.4),  // center-up corner
        vec3( 0.38, -0.44, 0.5) // right-down corner
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