**Reto**
---
### `ofapp.h`
```cpp
// ofApp.h
#pragma once

#include "ofMain.h"
#include <string>
#include <vector>

// ---------------- Observer Pattern ----------------
class Observer {
public:
	virtual void onNotify(const std::string & event) = 0;
};

class Subject {
public:
	void addObserver(Observer * observer);
	void removeObserver(Observer * observer);

protected:
	void notify(const std::string & event);

private:
	std::vector<Observer *> observers;
};

// ---------------- State Pattern ----------------
class Creature; // forward declaration

class State {
public:
	virtual void update(Creature * creature) = 0;
	virtual void onEnter(Creature * creature) { }
	virtual void onExit(Creature * creature) { }
	virtual ~State() = default;
};

// ---------------- Creature Base ----------------
class Creature : public Observer {
public:
	Creature();
	virtual ~Creature();

	virtual void update();
	virtual void draw();
	void setState(State * newState);
	void onNotify(const std::string & event) override;

	ofVec2f position;
	ofVec2f velocity;
	float size;
	ofColor color;

protected:
	State * state;
};

// ---------------- Concrete Creatures ----------------
class Insect : public Creature {
public:
	void draw() override;
};

class Fish : public Creature {
public:
	void draw() override;
};

class Bird : public Creature {
public:
	void draw() override;
};

// ---------------- Concrete States ----------------
class ActiveState : public State {
public:
	void update(Creature * creature) override;
};

class HiddenState : public State {
public:
	void update(Creature * creature) override;
	void onEnter(Creature * creature) override;
};

class AlertState : public State {
public:
	void update(Creature * creature) override;
};

class DreamingState : public State {
public:
	void update(Creature * creature) override;
	void onEnter(Creature * creature) override;
};

// ---------------- Factory Method ----------------
class CreatureFactory {
public:
	static Creature * createCreature(const std::string & type);
};

// ---------------- App ----------------
class ofApp : public ofBaseApp, public Subject {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);

private:
	std::vector<Creature *> creatures;
};

//---------------------------------
class Subject {
public:
	void addObserver(Observer * observer) {
		observers.push_back(observer);
	}

	void notify(const std::string & event) {
		for (auto & obs : observers) {
			obs->onNotify(event);
		}
	}

protected: 
	std::vector<Observer *> observers;
};
```

### `ofapp.cpp`
```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofBackground(10);

	for (int i = 0; i < 20; i++) {
		Creature * c = CreatureFactory::createCreature("insect");
		creatures.push_back(c);
		addObserver(c);
	}
	for (int i = 0; i < 15; i++) {
		Creature * c = CreatureFactory::createCreature("fish");
		creatures.push_back(c);
		addObserver(c);
	}
	for (int i = 0; i < 10; i++) {
		Creature * c = CreatureFactory::createCreature("bird");
		creatures.push_back(c);
		addObserver(c);
	}
}

//--------------------------------------------------------------
void ofApp::update() {
	for (auto & c : creatures) {
		c->update();
	}
}

//--------------------------------------------------------------
void ofApp::draw() {
	for (auto & c : creatures) {
		c->draw();
	}
	ofDrawBitmapStringHighlight("Teclas: [a]=alert, [h]=hide, [n]=normal, [d]=dream", 10, 20);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	switch (key) {
	case 'a':
		notify("alert");
		break;
	case 'h':
		notify("hide");
		break;
	case 'n':
		notify("normal");
		break;
	case 'd':
		notify("dream");
		break;
	case 's':
		notify("stop");
		break;
	case 'r':
		notify("repel");
		break;
	case 'b':
		notify("bounce");
		break;
	case 'f':
		notify("flicker");
		break;
	}
}
```

