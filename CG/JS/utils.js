const degToRad = (d) => (d * Math.PI) / 180;

const radToDeg = (r) => (r * 180) / Math.PI;

const orbitObjectX = (angle, object) => {
  var cos = Math.cos(degToRad(angle));
  var sen = Math.sin(degToRad(angle));

  const y = object.translation.y * cos - object.translation.z * sen;
  const z = object.translation.z * cos + object.translation.y * sen;

  object.translation.y = y;
  object.translation.z = z;

  return object;
};

const orbitObjectY = (angle, object) => {
  var cos = Math.cos(degToRad(angle));
  var sen = Math.sin(degToRad(angle));


  const x = object.translation.x * cos - object.translation.z * sen;

  const z = object.translation.z * cos + object.translation.x * sen;

  object.translation.x = x;
  object.translation.z = z;
  return object;
};

const orbitObjectsZ = (angle, objects) => {
  var cos = Math.cos(degToRad(angle));
  var sen = Math.sin(degToRad(angle));

  const x = objects.translation.x * cos - objects.translation.y * sen;

  const y = objects.translation.y * cos + objects.translation.x * sen;

  objects.translation.x = x;
  objects.translation.y = y;

  return objects;
};

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