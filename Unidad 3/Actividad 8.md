Actividad 8
--------

Construye un experimento (un programa) en el que puedas crear y dibujar objetos que se almacenan:

- En el `heap`.
- En el `stack`.
- En memoria global.
  
¿Cuándo debo crear objetos en el heap y cuándo en memoria global?

----
```
#pragma once
#include "ofMain.h"

// Objeto global (memoria global)
class Circle {
public:
    float x, y, radius;
    ofColor color;
    
    Circle(float x, float y, float radius)
        : x(x), y(y), radius(radius), color(ofColor::fromHsb(ofRandom(255), 255, 255)) {}

    void draw() {
        ofSetColor(color);
        ofDrawCircle(x, y, radius);
    }
};

// Objeto global (dura toda la ejecución)
extern Circle globalCircle;

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);

    vector<Circle*> heapCircles;  // Almacena círculos creados en el heap
};
```
```
#include "ofApp.h"

// Inicialización del objeto global
Circle globalCircle(100, 100, 30);

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    // Dibuja el objeto en memoria global
    globalCircle.draw();

    // Dibuja los objetos en el heap
    for (auto circle : heapCircles) {
        circle->draw();
    }
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    if (key == 's') {  // STACK
        ofLog() << "Creating object in STACK";
        Circle stackCircle(ofRandomWidth(), ofRandomHeight(), 30);
        stackCircle.draw();  // Se dibuja, pero desaparece al salir de la función
    }
    
    if (key == 'h') {  // HEAP
        ofLog() << "Creating object in HEAP";
        Circle* heapCircle = new Circle(ofRandomWidth(), ofRandomHeight(), 30);
        heapCircles.push_back(heapCircle);  // Se almacena en el vector, persiste
    }
}
```
**Cómo funciona el código**

*Presiona 's'*:Se crea un círculo en el stack y se dibuja, pero desaparece inmediatamente. (Circle stackCircle(...);	Solo dentro de keyPressed)

*Presiona 'h'*:Se crea un círculo en el heap y se almacena en un vector, por lo que permanece visible hasta que el programa termine. (Heap	new Circle(...);	Persiste en heapCircles hasta el final del programa)

*Siempre visible*:Hay un círculo en memoria global que dura toda la ejecución del programa. (Global	Circle globalCircle(...);	Dura toda la ejecución)

```
Stack: Cuando un objeto solo se necesita temporalmente dentro de una función.

Heap: Cuando un objeto debe persistir más allá del alcance de una función.

Memoria global: Para objetos que deben existir durante toda la ejecución del programa.
```
