Reto
---
**Video:** https://drive.google.com/file/d/1W-GJt28ZyKCjBNqvoie2GPgaafhrKCjv/view?usp=sharing
**ofApp.h**
```cpp
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    
    void keyPressed(int key);
    void mousePressed(int x, int y, int button);

    void convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint);

private:
    ofEasyCam cam;

    vector<glm::vec3> spherePositions;
    glm::vec3 selectedSphere;
    bool sphereSelected = false;

    float xStep = 60;
    float yStep = 60;
    float distDiv = 100.0;
    float amplitud = 100.0;
};
```
**ofApp.cpp**
```cpp
#include "ofApp.h"

void ofApp::setup() {
    ofBackground(10);
    ofSetFrameRate(60);

    // Generar la cuadrícula de esferas
    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
        }
    }
}

void ofApp::update() {}

void ofApp::draw() {
    cam.begin();

    for (auto& pos : spherePositions) {
        if (sphereSelected && pos == selectedSphere) {
            ofSetColor(255, 0, 0);  // Esfera seleccionada en rojo
            ofDrawSphere(pos, 6);
        } else {
            ofSetColor(0, 100, 255);
            ofDrawSphere(pos, 4);
        }
    }

    cam.end();

    // Mostrar coordenadas de la esfera seleccionada
    if (sphereSelected) {
        ofSetColor(255);
        std::string info = "Esfera seleccionada: x=" + ofToString(selectedSphere.x) +
                           ", y=" + ofToString(selectedSphere.y) +
                           ", z=" + ofToString(selectedSphere.z);
        ofDrawBitmapStringHighlight(info, 20, 20);
    }
}

void ofApp::mousePressed(int x, int y, int button) {
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    sphereSelected = false;
    for (auto& pos : spherePositions) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, 6.0, intersectionPoint)) {
            selectedSphere = pos;
            sphereSelected = true;
            break;
        }
    }
}

void ofApp::keyPressed(int key) {
    if (key == OF_KEY_UP) amplitud += 5;
    if (key == OF_KEY_DOWN) amplitud -= 5;
    if (key == OF_KEY_RIGHT) distDiv += 5;
    if (key == OF_KEY_LEFT) distDiv -= 5;
    if (key == '+') xStep += 5, yStep += 5;
    if (key == '-') xStep = max(10.0f, xStep - 5), yStep = max(10.0f, yStep - 5);

    // Volver a generar las posiciones con los nuevos parámetros
    spherePositions.clear();
    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
        }
    }
}

void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f);
    glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);

    glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
    glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd = glm::vec3(rayEndWorld);
}

bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir,
                                const glm::vec3& sphereCenter, float sphereRadius,
                                glm::vec3& intersectionPoint) {
    glm::vec3 oc = rayStart - sphereCenter;

    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b * b - 4 * a * c;

    if (discriminant < 0) return false;

    float t = (-b - sqrt(discriminant)) / (2.0f * a);
    intersectionPoint = rayStart + t * rayDir;
    return true;
}
```
---
### Informe: Análisis del Manejo de Memoria

### 1. **Investigación – ¿Cómo se gestionan los vectores de `ofVec3f` en C++?**

En C++, la clase `std::vector<ofVec3f>` (como `spherePositions`) se encarga automáticamente de la gestión dinámica de memoria. Esto significa que:

- El **vector en sí** (el objeto `std::vector`) se almacena en el *stack* si se declara como variable local (como en nuestro caso).
- Pero los **elementos que contiene** (`ofVec3f`) se almacenan en el *heap*, porque `std::vector` reserva dinámicamente la memoria a medida que crece.
- `ofVec3f` es un tipo que encapsula tres valores `float` (`x`, `y`, `z`), y su estructura se almacena secuencialmente en la memoria del `vector`.

**En resumen:**
- `spherePositions` → en el *stack*
- Elementos `ofVec3f` → en el *heap* (la parte dinámica de la memoria)

---

### 2. **Experimentación – ¿Dónde se encuentra cada dato en memoria?**

Usando el depurador de **Visual Studio**, puedes hacer lo siguiente:

1. Coloca un **breakpoint** en la línea donde se genera la cuadrícula de esferas (`setup()` o después de una tecla presionada).
2. Abre la ventana de **Watch** y observa `&spherePositions`.
3. Abre la ventana de **Memory > Memory 1** y escribe la dirección de un `ofVec3f` dentro del vector.

#### Observaciones:

- `spherePositions` tiene una dirección de tipo stack (normalmente baja, por ejemplo: `0x00AFF4C4`).
- Los elementos internos (`ofVec3f`) tienen direcciones más altas, lo que indica que están en el heap (por ejemplo: `0x00400080`).
- Si agregas más esferas (por ejemplo, cambiando `xStep` o `amplitud`), puedes ver cómo el `vector` se **realoca** en el heap (el bloque de memoria cambia de lugar).

---

### 3. **Documentación – Conclusiones**

- Los **datos clave** como las posiciones de las esferas (`spherePositions`) son gestionados dinámicamente en el *heap* por `std::vector`.
- El uso del heap permite que la aplicación escale fácilmente en cantidad de esferas sin necesidad de reservar manualmente memoria.
- El **vector en sí mismo** vive en el *stack*, lo que hace su acceso muy rápido.
- La selección de esferas mediante el mouse se basa en cálculos de intersección, pero no requiere crear objetos nuevos, lo cual optimiza aún más el uso de memoria.
- Visual Studio permite verificar la ubicación exacta de los datos en memoria para confirmar que esta arquitectura está funcionando correctamente.

---

¿Quieres que prepare esto también como un PDF para incluirlo en tu entrega o agregarle capturas del depurador de Visual Studio?
