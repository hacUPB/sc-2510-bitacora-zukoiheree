Reto
---
https://www.canva.com/design/DAGoDzwfcmw/gZGCKnmxEQeTngwhSQPPcA/edit?utm_content=DAGoDzwfcmw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

`ofApp.h`
```cpp
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);
	void mouseMoved(int x, int y);

	ofPlanePrimitive plane;
	ofShader shader;

	float time;
	glm::vec2 mousePos;
};
```
`ofApp.cpp`
```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofBackground(0);
	ofSetFrameRate(60);
	// Cargar el shader según si es OpenGL moderno o no
	if (ofIsGLProgrammableRenderer()) {
		shader.load("shadersGL3/shader");
	} else {
		shader.load("shadersGL2/shader");
	}

	// Crear un plano con subdivisiones
	plane.set(ofGetWidth(), ofGetHeight(), 100, 100, OF_PRIMITIVE_TRIANGLES);
	plane.setPosition(ofGetWidth() / 2, ofGetHeight() / 2, 0);
}

//--------------------------------------------------------------
void ofApp::update() {
	time = ofGetElapsedTimef();
}

//--------------------------------------------------------------
void ofApp::draw() {
	shader.begin();
	// Pasar uniformes al shader
	shader.setUniform1f("u_time", time);
	shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
	shader.setUniform2f("mousePos", mouseX - ofGetWidth() / 2.0, mouseY - ofGetHeight() / 2.0);

	// Dibujar la malla
	plane.drawWireframe();

	shader.end();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	// Puedes añadir interacción con teclado si lo deseas
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
	mousePos = glm::vec2(x - ofGetWidth() / 2, y - ofGetHeight() / 2);
}
```
**shadersGL2**

`shader.vert`
```glsl
OF_GLSL_SHADER_HEADER

uniform float time;
uniform vec2 mousePos;

void main() {
    vec4 pos = gl_Vertex;
    vec2 dir = pos.xy - mousePos;
    float dist = length(dir);
    float range = 200.0;
    float influence = max(0.0, 1.0 - dist / range);

    // genera una onda que depende de la distancia al mouse y el tiempo
    pos.z += sin(dist * 0.1 - time * 2.0) * 50.0 * influence;

    gl_Position = gl_ModelViewProjectionMatrix * pos;
    gl_FrontColor = gl_Color;
}
```
`shader.frag`
```glsl
OF_GLSL_SHADER_HEADER

void main() {
    gl_FragColor = vec4(0.0, 0.7, 1.0, 1.0); // un azul brillante
}
```










