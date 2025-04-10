Reto
---
- Una **lista enlazada** para representar partículas dinámicas en movimiento.
- Una **pila** para almacenar las estelas del cursor.
- Interacción mediante el **mouse** (genera partículas) y el **teclado** (`c` para limpiar estelas, `x` para eliminar partículas).
- Gestión manual de memoria con `new` y `delete`.

---

### ofApp.h
```cpp
#pragma once
#include "ofMain.h"

class Particle {
public:
    ofVec2f position, velocity;
    Particle* next;

    Particle(float x, float y) {
        position.set(x, y);
        velocity.set(ofRandom(-2, 2), ofRandom(-2, 2));
        next = nullptr;
    }

    void update() {
        position += velocity;
    }

    void draw() {
        ofDrawCircle(position, 5);
    }
};

class TrailNode {
public:
    ofVec2f position;
    TrailNode* next;

    TrailNode(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }

    void draw() {
        ofSetColor(255, 100);
        ofDrawCircle(position, 10);
    }
};

class ParticleList {
public:
    Particle* head;

    ParticleList() {
        head = nullptr;
    }

    ~ParticleList() {
        clear();
    }

    void add(float x, float y) {
        Particle* newNode = new Particle(x, y);
        newNode->next = head;
        head = newNode;
    }

    void updateAndDraw() {
        Particle* current = head;
        while (current) {
            current->update();
            current->draw();
            current = current->next;
        }
    }

    void clear() {
        while (head) {
            Particle* temp = head;
            head = head->next;
            delete temp;
        }
    }
};

class TrailStack {
public:
    TrailNode* top;

    TrailStack() {
        top = nullptr;
    }

    ~TrailStack() {
        clear();
    }

    void push(float x, float y) {
        TrailNode* newNode = new TrailNode(x, y);
        newNode->next = top;
        top = newNode;
    }

    void pop() {
        if (top) {
            TrailNode* temp = top;
            top = top->next;
            delete temp;
        }
    }

    void display() {
        TrailNode* current = top;
        while (current) {
            current->draw();
            current = current->next;
        }
    }

    void clear() {
        while (top) {
            pop();
        }
    }
};

class ofApp : public ofBaseApp {
public:
    ParticleList particles;
    TrailStack trail;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
    void mouseMoved(int x, int y);
    void mousePressed(int x, int y, int button);
};
```

---

### ofApp.cpp
```cpp
#include "ofApp.h"

void ofApp::setup() {
    ofSetBackgroundColor(10, 10, 30);
}

void ofApp::update() {
    // Sin lógica especial
}

void ofApp::draw() {
    ofSetColor(0, 255, 255);
    particles.updateAndDraw();

    trail.display();
}

void ofApp::keyPressed(int key) {
    if (key == 'c') {
        trail.clear();
    } else if (key == 'x') {
        particles.clear();
    }
}

void ofApp::mouseMoved(int x, int y) {
    trail.push(x, y);

    // Limitar longitud de la estela
    int limit = 50;
    TrailNode* temp = trail.top;
    int count = 0;
    while (temp) {
        count++;
        temp = temp->next;
    }

    while (count > limit) {
        trail.pop();
        count--;
    }
}

void ofApp::mousePressed(int x, int y, int button) {
    particles.add(x, y);
}
```

---

### Reflexión sobre los Requisitos

**1. Combinación de estructuras:**
- Lista enlazada: `ParticleList`
- Pila: `TrailStack`

**2. Interactividad:**
- Click genera partículas.
- Movimiento del mouse genera estelas.
- Tecla `c` borra estela, `x` borra partículas.

**3. Gestión de memoria:**
- Uso de `new` al crear nodos.
- Uso de `delete` en `clear()` y destructores para liberar memoria.
