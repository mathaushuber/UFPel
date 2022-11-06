animationType = [];
animationCameraType = [];

function animation(objects){
    objects.forEach((object) => {
        switch (animationType[0].movementType) {
            case 'translation':
                switch (animationType[0].axysType) {
                    case 'x':
                        object.translation.x += animationType[0].value;
                        break;
                    case 'y':
                        object.translation.y += animationType[0].value;
                        break;
                    case 'z':
                        object.translation.z += animationType[0].value;
                        break;
                }
                break;
            case 'rotation':
                switch (animationType[0].axysType) {
                    case 'x':
                        object.rotation.x += animationType[0].value;
                        break;
                    case 'y':
                        object.rotation.y += animationType[0].value;
                        break;
                    case 'z':
                        object.rotation.z += animationType[0].value;
                        break;
                }
                break;
            case 'default':
                break;
        }
    });
}

function animationCamera(){
    switch (animationCameraType[0].movementType) {
        case 'translation':
            switch (animationCameraType[0].axysType) {
                case 'x':
                    cameras[config.index].translation.x += animationCameraType[0].value;
                    break;
                case 'y':
                    cameras[config.index].translation.y += animationCameraType[0].value;
                    break;
                case 'z':
                    cameras[config.index].translation.z += animationCameraType[0].value;
                    break;
            }
            break;
        case 'rotation':
            switch (animationCameraType[0].axysType) {
                case 'x':
                    cameras[config.index].rotation.x += animationCameraType[0].value;
                    break;
                case 'y':
                    cameras[config.index].rotation.y += animationCameraType[0].value;
                    break;
                case 'z':
                    cameras[config.index].rotation.z += animationCameraType[0].value;
                    break;
            }
            break;

        case 'fieldVision':
            config.fieldVision += animationCameraType[0].value;
        case 'default':
            break;
    }
}




function animationObj1(){
    for (let i = 0; i < 10; i++) {
        animationType.push({ steps: 5, movementType: 'translation', axysType: 'z', value: 5 });
        animationType.push({ steps: 0, movementType: 'translation', axysType: 'z', value: 0 });
        animationType.push({ steps: 10, movementType: 'rotation', axysType: 'x', value: 10 });
        animationType.push({ steps: 10, movementType: 'rotation', axysType: 'x', value: -10 });
    }
}

function animationObj2(){
    for (let i = 0; i < 10; i++) {
        animationType.push({ steps: 8, movementType: 'translation', axysType: 'y', value: 8 });
        animationType.push({ steps: 3, movementType: 'rotation', axysType: 'x', value: 3 });
        animationType.push({ steps: 3, movementType: 'translation', axysType: 'x', value: 3 });
        animationType.push({ steps: 8, movementType: 'translation', axysType: 'y', value: -8 });
    }
}

function animationObj3(){
    for (let i = 0; i < 10; i++) {
        animationType.push({ steps: 15, movementType: 'translation', axysType: 'z', value: 15 });
        animationType.push({ steps: 8, movementType: 'rotation', axysType: 'y', value: 8 });
        animationType.push({ steps: 15, movementType: 'translation', axysType: 'z', value: -15 });
    }
}

function animationCam1(){
    for (let i = 0; i < 10; i++) {
        animationCameraType.push({ stepsCamera: 10, movementType: 'translation', axysType: 'x', value: 10 });
        animationCameraType.push({ stepsCamera: 100, movementType: 'rotation', axysType: 'y', value: 100 });
        animationCameraType.push({ stepsCamera: 0, movementType: 'rotation', axysType: 'x', value: 0 });
        animationCameraType.push({ stepsCamera: 100, movementType: 'rotation', axysType: 'y', value: -100 });
        animationCameraType.push({ stepsCamera: 10, movementType: 'translation', axysType: 'x', value: -10 });
    }
}

function animationCam2(){
    for (let i = 0; i < 10; i++) {
        animationCameraType.push({ stepsCamera: 35, movementType: 'translation', axysType: 'z', value: -35 });
        animationCameraType.push({ stepsCamera: 35, movementType: 'translation', axysType: 'z', value: 35 });
        animationCameraType.push({ stepsCamera: 20, movementType: 'rotation', axysType: 'y', value: 20 });
        animationCameraType.push({ stepsCamera: 20, movementType: 'rotation', axysType: 'y', value: -20 });
    }
}

function animationCam3(){
    for (let i = 0; i < 10; i++) {
        animationCameraType.push({ stepsCamera: 10, movementType: 'fieldVision', value: 15 });
        animationCameraType.push({ stepsCamera: 30, movementType: 'rotation', axysType: 'x', value: -30 });
        animationCameraType.push({ stepsCamera: 10, movementType: 'translation', axysType: 'y', value: -10 });
        animationCameraType.push({ stepsCamera: 10, movementType: 'translation', axysType: 'y', value: 10 });
        animationCameraType.push({ stepsCamera: 30, movementType: 'rotation', axysType: 'x', value: 30 });
        animationCameraType.push({ stepsCamera: 10, movementType: 'fieldVision', value: -15 });
    }
}


function animationLight1 (){
    for (let i = 0; i < 10; i++){
            sleepFor(1000);
            config.lDirectionX += 0.5;
    }
}

function animationLight2(){
    for (let i = 0; i < 20; i++){
            sleepFor(1000);
            config.lDirectionY += 0.5;
    }
}

function animationLight3(){
    for (let i = 0; i < 20; i++){
            sleepFor(1000);
         config.lDirectionZ += 0.5;
    }
}