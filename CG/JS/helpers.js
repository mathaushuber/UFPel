const degToRad = (d) => (d * Math.PI) / 180;

const radToDeg = (r) => (r * 180) / Math.PI;

function sleepFor(sleepDuration){
    var now = new Date().getTime();
    while(new Date().getTime() < now + sleepDuration){ 
        /* Do nothing */ 
    }
}

function Bezier(t, p1, p2, p3, p4) { 
  var invT = (1 - t)
  var px = ((p1[0]) * invT * invT * invT) +
            ((p2[0]) * 3 * t * invT * invT) +
            (p3[0] * 3 * invT * t * t) +
            (p4[0] * t * t * t);
  var py = ((p1[1]) * invT * invT * invT) +
            (p2[1] * 3 * t * invT * invT) +
            (p3[1] * 3 * invT * t * t) +
            ((p4[1]) * t * t * t);
  return [px, py];
}