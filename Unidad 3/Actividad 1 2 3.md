**Actividad 1**
¿Cuál es el resultado que se obtiene al ejecutar este programa?
- Se obtiene un puntero

**Actividad 2**
¿Qué incluimos en el archivo .h?
- Declaración de la clase `ofApp` con métodos públicos (`setup()`, `update()`, `draw()`, `mouseMoved()`, `mousePressed()`) y variables privadas (`particles`, `particleColor`).

¿Cómo funciona la aplicación?
- La aplicación crea una ventana gráfica donde se pueden agregar partículas al mover el ratón. El color de las partículas cambia al presionar un botón del ratón.

¿Qué hace la función mouseMoved?
- Agrega una partícula en la posición actual del ratón y elimina la primera partícula si supera el límite de 100 partículas.

¿Qué hace la función mousePressed?
- Cambia el color de las partículas a un color aleatorio.

¿Qué hace la función setup?
- Configura el fondo de la ventana a negro y establece el color inicial de las partículas en blanco.

¿Qué hace la función update?
- Actualmente no realiza nada, pero se puede usar para actualizar el estado de la aplicación.

¿Qué hace la función draw?
- Dibuja cada partícula almacenada como un círculo en la pantalla.

**Actividad 3** 

*Declaraciones y Métodos**

```cpp
class ofApp : public ofBaseApp{
    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:
        vector particles;
        ofColor particleColor;
};
```

- **`setup()`, `update()`, `draw()`**: Son métodos básicos de OpenFrameworks para configurar, actualizar y dibujar la aplicación.
- **`mouseMoved(int x, int y)` y `mousePressed(int x, int y, int button)`**: Manejan eventos del ratón.
- **`vector particles`**: Almacena posiciones de partículas.
- **`ofColor particleColor`**: Almacena el color de las partículas.

*Implementación de Métodos*
--------------------------------------
#### `setup()`

```cpp
void ofApp::setup(){
    ofBackground(0);
    particleColor = ofColor::white;
}
```

- **`ofBackground(0)`**: Establece el fondo de la ventana a negro.
- **`particleColor = ofColor::white`**: Establece el color inicial de las partículas en blanco.

---------------------------------------
#### `update()`

```cpp
void ofApp::update(){
    // Actualmente vacío, pero se puede usar para actualizar el estado de la aplicación.
}


- Actualmente no realiza nada, pero se puede utilizar para actualizar variables o realizar cálculos.
---------------------------------------

#### `draw()`

```cpp
void ofApp::draw(){
    for(auto &pos: particles){
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}
```

- **`for(auto &pos: particles)`**: Itera sobre cada posición de partícula en el vector `particles`.
- **`ofSetColor(particleColor)`**: Establece el color de las partículas.
- **`ofDrawCircle(pos.x, pos.y, 50)`**: Dibuja un círculo en la posición `pos` con un radio de 50 píxeles.
---------------------------------------

#### `mouseMoved(int x, int y)`

```cpp
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}
```

- **`particles.push_back(ofVec2f(x, y))`**: Agrega una nueva partícula en la posición actual del ratón.
- **`if (particles.size() > 100)`**: Si hay más de 100 partículas, elimina la primera partícula agregada.
---------------------------------------

#### `mousePressed(int x, int y, int button)`

```cpp
void ofApp::mousePressed(int x, int y, int button){
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
```

- **`particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255))`**: Cambia el color de las partículas a un color aleatorio.
---------------------------------------


**Experimento**: Cambiar el tamaño de las partículas en función de la posición del ratón.

*Modificación*

En el método `mouseMoved(int x, int y)`, en lugar de agregar siempre un círculo de tamaño fijo, vamos a variar el tamaño del círculo en función de la posición `y` del ratón. Esto hará que los círculos sean más grandes cuanto más abajo se encuentren en la pantalla.

```cpp
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

// Modificación en draw()
void ofApp::draw(){
    for(auto &pos: particles){
        ofSetColor(particleColor);
        // Calcula el radio en función de la posición y
        float radius = ofMap(pos.y, 0, ofGetHeight(), 10, 50);
        ofDrawCircle(pos.x, pos.y, radius);
    }
}
```

En este ejemplo, `ofMap(pos.y, 0, ofGetHeight(), 10, 50)` mapea la posición `y` del ratón desde el rango `[0, altura de la ventana]` al rango ``, lo que significa que los círculos serán más pequeños en la parte superior de la pantalla y más grandes en la parte inferior.

**Resultado**: La aplicación ahora dibuja círculos con tamaños variables en función de la posición vertical del ratón.

---
Respuesta de Perplexity: pplx.ai/share




