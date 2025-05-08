Reto
---
https://drive.google.com/file/d/1rzIn3-psAoBjDiN5jUxqJ_R_ZD-rz7BA/view?usp=sharing

Este programa, desarrollado con C++ y openFrameworks, crea un sistema visual dinámico basado en partículas que se comportan de diferentes maneras. 
Al iniciar, se generan 100 partículas, de dos tipos:

- FollowerParticle: partículas que siguen suavemente el mouse.
- BouncingParticle: partículas que rebotan en los bordes de la pantalla.

Cada partícula se mueve y se dibuja de forma independiente, pero todas comparten una interfaz común gracias al uso de herencia.

#### `ofApp.h`

```cpp
#pragma once

#include "ofMain.h"

// Clase base
class Particle {
protected:
    ofVec2f position;
    ofVec2f velocity;
    ofColor color;

public:
    Particle(ofVec2f startPosition);
    virtual void update();
    virtual void draw();
    ofVec2f getPosition() const;
};

// Partícula que sigue al mouse
class FollowerParticle : public Particle {
public:
    FollowerParticle(ofVec2f startPosition);
    void update() override;
};

// Partícula que rebota
class BouncingParticle : public Particle {
public:
    BouncingParticle(ofVec2f startPosition);
    void update() override;
};

// Clase principal openFrameworks
class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    vector<Particle*> particles;
};

```
---

#### `ofApp.cpp`
```cpp
#include "ofApp.h"

// ---------- Clase Particle ----------

Particle::Particle(ofVec2f startPosition) {
    position = startPosition;
    velocity = ofVec2f(ofRandom(-2, 2), ofRandom(-2, 2));
    color = ofColor::fromHsb(ofRandom(255), 200, 255);
}

void Particle::update() {
    position += velocity;
}

void Particle::draw() {
    ofSetColor(color);
    ofDrawCircle(position, 5);
}

ofVec2f Particle::getPosition() const {
    return position;
}

// ---------- FollowerParticle ----------

FollowerParticle::FollowerParticle(ofVec2f startPosition) : Particle(startPosition) {}

void FollowerParticle::update() {
    ofVec2f mousePos(ofGetMouseX(), ofGetMouseY());
    velocity += (mousePos - position) * 0.01;
    velocity *= 0.95;
    position += velocity;
}

// ---------- BouncingParticle ----------

BouncingParticle::BouncingParticle(ofVec2f startPosition) : Particle(startPosition) {}

void BouncingParticle::update() {
    position += velocity;

    if (position.x < 0 || position.x > ofGetWidth()) {
        velocity.x *= -1;
    }
    if (position.y < 0 || position.y > ofGetHeight()) {
        velocity.y *= -1;
    }
}

// ---------- ofApp ----------

void ofApp::setup() {
    ofBackground(0);
    for (int i = 0; i < 100; i++) {
        if (i % 2 == 0) {
            particles.push_back(new FollowerParticle(ofVec2f(ofRandomWidth(), ofRandomHeight())));
        } else {
            particles.push_back(new BouncingParticle(ofVec2f(ofRandomWidth(), ofRandomHeight())));
        }
    }
}

void ofApp::update() {
    for (auto p : particles) {
        p->update();
    }
}

void ofApp::draw() {
    for (auto p : particles) {
        p->draw();
    }
}
```

### Explicación de las funciones:

- **`setup()`**: Aquí creamos las partículas y las añadimos al vector `particles`. Dependiendo de la iteración, creamos partículas de tipo `FollowerParticle` o `BouncingParticle`.
  
- **`update()`**: Llamamos al método `update()` de cada partícula en el vector. Debido al polimorfismo, se ejecutará el método correcto de cada tipo de partícula, ya sea `FollowerParticle` o `BouncingParticle`.
  
- **`draw()`**: Se dibujan todas las partículas en la pantalla.
  
- **`exit()`**: Limpiamos la memoria y eliminamos las partículas creadas dinámicamente.

---

###  **Archivos adicionales en openFrameworks**:

Si estás usando openFrameworks, también tendrás otros archivos como:

- **`main.cpp`**: Este archivo ya está configurado en openFrameworks para iniciar la aplicación y ejecutar el ciclo de vida de la misma. No es necesario que modifiques este archivo, ya que el código de tu aplicación va en `ofApp.cpp` y `ofApp.h`.

---

### Resumen:

- El código de las clases `Particle`, `FollowerParticle` y `BouncingParticle` va en **`ofApp.h`** (declaraciones) y **`ofApp.cpp`** (implementación).
- El ciclo de vida de la aplicación (setup, update, draw y exit) va en **`ofApp.cpp`**.
- La memoria dinámica se maneja en **`exit()`** para liberar las partículas cuando la aplicación termine.

Este es el esqueleto básico para tu proyecto de arte generativo en C++ con openFrameworks utilizando encapsulamiento, herencia y polimorfismo. Puedes agregar más comportamientos y animaciones a medida que avances.
