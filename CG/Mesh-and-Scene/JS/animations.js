methodAnimation = [];
methodAnimationCamera = [];
methodAnimationLight = []; 

function animation(objects){
    objects.forEach((object) => {
        switch (methodAnimation[0].movementType) {
            case 'translation':
                switch (methodAnimation[0].axysType) {
                    case 'x':
                        object.translation.x += methodAnimation[0].value;
                        break;
                    case 'y':
                        object.translation.y += methodAnimation[0].value;
                        break;
                    case 'z':
                        object.translation.z += methodAnimation[0].value;
                        break;
                }
                break;
            case 'rotation':
                switch (methodAnimation[0].axysType) {
                    case 'x':
                        object.rotation.x += methodAnimation[0].value;
                        break;
                    case 'y':
                        object.rotation.y += methodAnimation[0].value;
                        break;
                    case 'z':
                        object.rotation.z += methodAnimation[0].value;
                        break;
                }
                break;
            case 'default':
                break;
        }
    });
}

function animationCamera(){
    switch (methodAnimationCamera[0].movementType) {
        case 'translation':
            switch (methodAnimationCamera[0].axysType) {
                case 'x':
                    cameras[config.index].translation.x += methodAnimationCamera[0].value;
                    break;
                case 'y':
                    cameras[config.index].translation.y += methodAnimationCamera[0].value;
                    break;
                case 'z':
                    cameras[config.index].translation.z += methodAnimationCamera[0].value;
                    break;
            }
            break;
        case 'rotation':
            switch (methodAnimationCamera[0].axysType) {
                case 'x':
                    cameras[config.index].rotation.x += methodAnimationCamera[0].value;
                    break;
                case 'y':
                    cameras[config.index].rotation.y += methodAnimationCamera[0].value;
                    break;
                case 'z':
                    cameras[config.index].rotation.z += methodAnimationCamera[0].value;
                    break;
            }
            break;

        case 'fieldVision':
            config.fieldVision += methodAnimationCamera[0].value;
        case 'default':
            break;
    }
}

function animationLight(){
    switch(methodAnimationLight[0].movementType){
        case 'x':
            config.lDirectionX += methodAnimationLight[0].value;
            break;
        case 'y':
            config.lDirectionY += methodAnimationLight[0].value;
            break;
        case 'z':
            config.lDirectionZ += methodAnimationLight[0].value;
            break;
    }
}




function animationObj1(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimation.push({ steps: 5, movementType: 'translation', axysType: 'z', value: 5 });
            methodAnimation.push({ steps: 0, movementType: 'translation', axysType: 'z', value: 0 });
            methodAnimation.push({ steps: 10, movementType: 'rotation', axysType: 'x', value: 10 });
            methodAnimation.push({ steps: 10, movementType: 'rotation', axysType: 'x', value: -10 });
        }
    }
}

function animationObj2(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimation.push({ steps: 8, movementType: 'translation', axysType: 'y', value: 8 });
            methodAnimation.push({ steps: 3, movementType: 'rotation', axysType: 'x', value: 3 });
            methodAnimation.push({ steps: 3, movementType: 'translation', axysType: 'x', value: 3 });
            methodAnimation.push({ steps: 8, movementType: 'translation', axysType: 'y', value: -8 });
        }
    }
}

function animationObj3(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimation.push({ steps: 15, movementType: 'translation', axysType: 'z', value: 15 });
            methodAnimation.push({ steps: 8, movementType: 'rotation', axysType: 'y', value: 8 });
            methodAnimation.push({ steps: 15, movementType: 'translation', axysType: 'z', value: -15 });
        }
    }
}

function animationCam1(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'translation', axysType: 'x', value: 10 });
            methodAnimationCamera.push({ stepsCamera: 100, movementType: 'rotation', axysType: 'y', value: 100 });
            methodAnimationCamera.push({ stepsCamera: 0, movementType: 'rotation', axysType: 'x', value: 0 });
            methodAnimationCamera.push({ stepsCamera: 100, movementType: 'rotation', axysType: 'y', value: -100 });
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'translation', axysType: 'x', value: -10 });
        }
    }
}

function animationCam2(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimationCamera.push({ stepsCamera: 35, movementType: 'translation', axysType: 'z', value: -35 });
            methodAnimationCamera.push({ stepsCamera: 35, movementType: 'translation', axysType: 'z', value: 35 });
            methodAnimationCamera.push({ stepsCamera: 20, movementType: 'rotation', axysType: 'y', value: 20 });
            methodAnimationCamera.push({ stepsCamera: 20, movementType: 'rotation', axysType: 'y', value: -20 });
        }
    }
}

function animationCam3(){
    for (let i = 0; i < 10; i++) {
        if(config.stopAnimation == false){
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'fieldVision', value: 15 });
            methodAnimationCamera.push({ stepsCamera: 30, movementType: 'rotation', axysType: 'x', value: -30 });
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'translation', axysType: 'y', value: -10 });
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'translation', axysType: 'y', value: 10 });
            methodAnimationCamera.push({ stepsCamera: 30, movementType: 'rotation', axysType: 'x', value: 30 });
            methodAnimationCamera.push({ stepsCamera: 10, movementType: 'fieldVision', value: -15 });
        }
    }
}


function animationLight1 (){
    for (let i = 0; i < 10; i++){
        if(config.stopAnimation == false){
            methodAnimationLight.push({ stepsLight: 0.1, movementType: 'x', value: 0.1});
            methodAnimationLight.push({ stepsLight: 0.1, movementType: 'x', value: -0.1 });
            methodAnimationLight.push({ stepsLight: 0.2, movementType: 'z', value: 0.2 });
            methodAnimationLight.push({ stepsLight: 0.3, movementType: 'y', value: -0.3 });
        }
    }
}

function animationLight2(){
    for (let i = 0; i < 10; i++){
        if(config.stopAnimation == false){
            methodAnimationLight.push({ stepsLight: 1, movementType: 'y', value: 1});
            methodAnimationLight.push({ stepsLight: 1, movementType: 'y', value: 1 });
            methodAnimationLight.push({ stepsLight: 0.5, movementType: 'z', value: -0.5});
            methodAnimationLight.push({ stepsLight: 0.3, movementType: 'x', value: 0.3});
            methodAnimationLight.push({ stepsLight: 0.6, movementType: 'y', value: 0.6});
        }
    }
}

function animationLight3(){
    for (let i = 0; i < 10; i++){
        if(config.stopAnimation == false){
            methodAnimationLight.push({ stepsLight: 1.5, movementType: 'z', value: 1.5});
            methodAnimationLight.push({ stepsLight: 1.5, movementType: 'z', value: -1.5 });
            methodAnimationLight.push({ stepsLight: 1.5, movementType: 'x', value: -0.5 });
            methodAnimationLight.push({ stepsLight: 1.5, movementType: 'x', value: 0.5 });
        }
    }
}