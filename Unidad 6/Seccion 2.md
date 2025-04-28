**Sección 2: análisis de un caso de estudio**
---
### Preguntas
- **¿Qué hace el patrón observer en este caso?**

En este caso se utiliza para notificar a las particulas cuando ocurre algun evento como presionar una tecla que cambie su comportamiento 
("detenerse", "atraer", "repeler"). La clase ofApp es el sujeto (Subject) y las partículas son los observadores que reaccionan a estos eventos. 

- **¿Qué hace el patrón factory en este caso?**

El patrón Factory se emplea en la clase **ParticleFactory** para crear distintos tipos de partículas (estrella, estrella fugaz, planeta) 
con propiedades específicas (tamaño, color, velocidad) sin que el código cliente tenga que preocuparse por la creación detallada de estas partículas.

- **¿Qué hace el patrón state en este caso?**
  
El patrón State se usa para cambiar dinámicamente el comportamiento de las partículas a través de diferentes estados (Normal, Attract, Repel, Stop).
Cada estado encapsula la lógica para actualizar la partícula, lo que permite un comportamiento flexible y fácilmente modificable sin cambiar el código de la clase Particle.

---
### **Experimentación**
Para experimentar con el código, se pueden realizar algunas modificaciones como las siguientes:

1. **Nuevo tipo de partícula**: Añadir un tipo de partícula adicional en la fábrica de partículas. Por ejemplo, una partícula tipo "cometa":
   
   En `ParticleFactory`:
```cpp
   else if (type == "comet") {
       particle->size = ofRandom(5, 10);
       particle->color = ofColor(255, 255, 0);
       particle->velocity *= 1.5; // Velocidad mayor
   }
 ```

2. **Nuevo estado**: Agregar un nuevo estado llamado `BounceState` que haga que la partícula rebote en direcciones opuestas. Para esto, definimos un nuevo estado con un comportamiento específico.

   En `RandomState`:
```cpp
   class RandomState : public State {
public:
    void update(Particle* particle) override {
        // Movimiento aleatorio en todas las direcciones
        particle->velocity += ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1));
        
        // Limitar la velocidad de la partícula
        ofClamp(particle->velocity.length(), 0, 3);

        // Actualizar la posición de la partícula
        particle->position += particle->velocity * 0.2;
    }
};

   ```

   Luego, en `Particle::onNotify`:
   ```cpp
      else if (event == "random") {
        setState(new RandomState());
    }
   ```

3. **Modificar comportamiento de las partículas**: Cambiar la lógica de actualización de la partícula en `NormalState`, por ejemplo, haciéndolas moverse más rápido:
   
   En `NormalState`:
```cpp
   void NormalState::update(Particle* particle) {
       particle->position += particle->velocity * 1.5; // Velocidad mayor
   }
```

### Completo

`ofApp.h`
```cpp
#pragma once

#include "ofMain.h"
#include <vector>
#include <string>

class Observer {
public:
    virtual void onNotify(const std::string& event) = 0;
};

class Subject {
public:
    void addObserver(Observer* observer);
    void removeObserver(Observer* observer);
protected:
    void notify(const std::string& event);
private:
    std::vector<Observer*> observers;
};

class Particle;

class State {
public:
    virtual void update(Particle* particle) = 0;
    virtual void onEnter(Particle* particle) {}
    virtual void onExit(Particle* particle) {}
    virtual ~State() = default;
};

class Particle : public Observer {
public:
    Particle();
    ~Particle();

    void update();
    void draw();
    void onNotify(const std::string& event) override;
    void setState(State* newState);

    ofVec2f position;
    ofVec2f velocity;
    float size;
    ofColor color;

private:
    State* state;
};

class NormalState : public State {
public:
    void update(Particle* particle) override;
    virtual void onEnter(Particle* particle) override;
};

class AttractState : public State {
public:
    void update(Particle* particle) override;
};

class RepelState : public State {
public:
    void update(Particle* particle) override;
};

class StopState : public State {
public:
    void update(Particle* particle) override;
};

class RandomState : public State {
public:
    void update(Particle* particle) override {
        // Movimiento aleatorio en todas las direcciones
        particle->velocity += ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1));

        // Limitar la velocidad de la partícula
        ofClamp(particle->velocity.length(), 0, 3);

        // Actualizar la posición de la partícula
        particle->position += particle->velocity * 0.2;
    }
};

class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};

class ofApp : public ofBaseApp, public Subject {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);
private:
    std::vector<Particle*> particles;
};
```

`ofApp.cpp`
```cpp
#include "ofApp.h"

void Subject::addObserver(Observer* observer) {
    observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (Observer* observer : observers) {
        observer->onNotify(event);
    }
}

Particle::Particle() {
    // Inicializar propiedades
    position = ofVec2f(ofRandomWidth(), ofRandomHeight());
    velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
    size = ofRandom(2, 5);
    color = ofColor(255);

    state = new NormalState();
}

Particle::~Particle() {
    delete state;
}

void Particle::setState(State* newState) {
    if (state != nullptr) {
        state->onExit(this);
        delete state;
    }
    state = newState;
    if (state != nullptr) {
        state->onEnter(this);
    }
}

void Particle::update() {
    if (state != nullptr) {
        state->update(this);
    }
    // Mantener las partículas dentro de la ventana
    if (position.x < 0 || position.x > ofGetWidth()) velocity.x *= -1;
    if (position.y < 0 || position.y > ofGetHeight()) velocity.y *= -1;
}

void Particle::draw() {
    ofSetColor(color);
    ofDrawCircle(position, size);
}

void Particle::onNotify(const std::string& event) {
    if (event == "attract") {
        setState(new AttractState());
    }
    else if (event == "repel") {
        setState(new RepelState());
    }
    else if (event == "stop") {
        setState(new StopState());
    }
    else if (event == "normal") {
        setState(new NormalState());
    }
    else if (event == "random") {
        setState(new RandomState());
    }
}

void NormalState::update(Particle* particle) {
    particle->position += particle->velocity * 1.5; // Velocidad mayor
}


void NormalState::onEnter(Particle* particle) {
    particle->velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

void AttractState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = mousePosition - particle->position;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void RepelState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void StopState::update(Particle* particle) {
    particle->velocity.x = 0;
    particle->velocity.y = 0;
}

Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 0, 0);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    else if (type == "comet") {
        particle->size = ofRandom(5, 10);
        particle->color = ofColor(255, 255, 255);
        particle->velocity *= 1.5; // Velocidad mayor
    }
    return particle;
}


void ofApp::setup() {
    ofBackground(0);
    // Crear partículas usando la fábrica
    for (int i = 0; i < 100; ++i) {
        Particle* p = ParticleFactory::createParticle("star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 5; ++i) {
        Particle* p = ParticleFactory::createParticle("shooting_star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 10; ++i) {
        Particle* p = ParticleFactory::createParticle("planet");
        particles.push_back(p);
        addObserver(p);
    }
}


void ofApp::update() {
    for (Particle* p : particles) {
        p->update();
    }
}


void ofApp::draw() {
    for (Particle* p : particles) {
        p->draw();
    }
}

void ofApp::keyPressed(int key) {
    if (key == 's') {
        notify("stop");
    }
    else if (key == 'a') {
        notify("attract");
    }
    else if (key == 'r') {
        notify("repel");
    }
    else if (key == 'n') {
        notify("normal");
    }
    else if (key == 'm') {  // Activar el estado Random
        notify("random");
    }
}
```

