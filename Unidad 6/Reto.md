**Reto**
---
https://www.canva.com/design/DAGm5oOBCRI/s4ZEdexb9UrgBjKAhCAzpg/edit?utm_content=DAGm5oOBCRI&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
### `ofapp.h`
```cpp
#pragma once
#include "ofMain.h"
#include <string>
#include <vector>

// -------- Observer --------
class Observer {
public:
	virtual void onNotify(const std::string & event) = 0;
};

// -------- Subject --------
class Subject {
public:
	void addObserver(Observer * o);
	void removeObserver(Observer * o);

protected:
	void notify(const std::string & event);

private:
	std::vector<Observer *> observers;
};

// Adelanto
class Firefly;

// -------- State --------
class State {
public:
	virtual void update(Firefly * firefly) = 0;
	virtual void onEnter(Firefly * firefly) { };
	virtual void onExit(Firefly * firefly) { };
	virtual ~State() { }
};

// -------- Firefly --------
class Firefly : public Observer {
public:
	Firefly();
	void update();
	void draw();
	void onNotify(const std::string & event) override;
	void setState(State * newState);
	ofVec2f getPosition();
	void setPosition(const ofVec2f & newPos); 

private:
	ofVec2f position;
	ofVec2f velocity;
	State * currentState;
	ofColor color;
	float radius;
	float brightness;
};



// -------- States --------
class NormalState : public State {
public:
	void update(Firefly * firefly) override;
};

class GlowState : public State {
public:
	void onEnter(Firefly * firefly) override;
	void update(Firefly * firefly) override;
};

class StopState : public State {
public:
	void update(Firefly * firefly) override;
};

// -------- Factory --------
class FireflyFactory {
public:
	static Firefly * createFirefly();
};

// -------- App --------
class ofApp : public ofBaseApp, public Subject {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);

private:
	std::vector<Firefly *> fireflies;
};

```

### `ofapp.cpp`
```cpp

#include "ofApp.h"

void ofApp::setup() {
	ofBackground(0);
	for (int i = 0; i < 5; ++i) {
		Firefly * f = FireflyFactory::createFirefly();
		fireflies.push_back(f);
		addObserver(f);
	}
}

void ofApp::update() {
	for (auto * f : fireflies) {
		f->update();
	}
}

void ofApp::draw() {
	for (auto * f : fireflies) {
		f->draw();
	}

	ofSetColor(255);
	ofDrawBitmapString("Teclas: [n] normal, [g] glow, [s] stop, [a] agregar luciérnaga", 10, 20);
}

void ofApp::keyPressed(int key) {
	if (key == 'n')
		notify("normal");
	else if (key == 'g')
		notify("glow");
	else if (key == 's')
		notify("stop");
	else if (key == 'a') {
		Firefly * f = FireflyFactory::createFirefly();
		fireflies.push_back(f);
		addObserver(f);
	}
}

// -------- Subject -----------
void Subject::addObserver(Observer * o) {
	observers.push_back(o);
}

void Subject::removeObserver(Observer * o) {
	observers.erase(std::remove(observers.begin(), observers.end(), o), observers.end());
}

void Subject::notify(const std::string & event) {
	for (auto & o : observers) {
		o->onNotify(event);
	}
}

// -------- Firefly ----------
Firefly::Firefly() {
	position.set(ofRandomWidth(), ofRandomHeight());
	velocity.set(ofRandom(-2, 2), ofRandom(-2, 2));
	color = ofColor::yellow;
	radius = 5;
	brightness = 255;
	currentState = new NormalState();
}

void Firefly::update() {
	if (currentState) currentState->update(this);
}

void Firefly::draw() {
	ofSetColor(color, brightness);
	ofDrawCircle(position, radius);
}

void Firefly::onNotify(const std::string & event) {
	if (event == "normal")
		setState(new NormalState());
	else if (event == "glow")
		setState(new GlowState());
	else if (event == "stop")
		setState(new StopState());
}

void Firefly::setState(State * newState) {
	if (currentState) {
		currentState->onExit(this);
		delete currentState;
	}
	currentState = newState;
	if (currentState) currentState->onEnter(this);
}

void Firefly::setPosition(const ofVec2f & newPos) {
	position = newPos;
}


ofVec2f Firefly::getPosition() {
	return position;
}


// -------- States --------

void NormalState::update(Firefly * firefly) {
	ofVec2f pos = firefly->getPosition(); // Copia válida
	pos += ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1)); // Movimiento aleatorio
	firefly->setPosition(pos); // Actualiza la posición real
}

void GlowState::onEnter(Firefly * firefly) {
	firefly->setState(new GlowState());
}

void GlowState::update(Firefly * firefly) {
	firefly->draw();
}

void StopState::update(Firefly * firefly) {
	// No se mueve
}

// -------- Factory ----------
Firefly * FireflyFactory::createFirefly() {
	return new Firefly();
}

```

