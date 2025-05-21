Actividad 4
---
![image](https://github.com/user-attachments/assets/3d3cc41f-2475-450a-9d52-fb2bb81ee595)

### - ¿Qué hace el código del ejemplo?

El código crea un plano 2D que ocupa toda la pantalla y deforma sus vértices dependiendo de la distancia al puntero del mouse, generando un relieve en forma de esfera. Además, el color del plano cambia dinámicamente con base en la posición horizontal del mouse, interpolando entre magenta y azul.

---

### - ¿Cómo funciona la comunicación entre la app y los shaders?

La comunicación entre la **aplicación (C++)** y los **shaders (GLSL)** se da por medio de **variables `uniform`**. El flujo general es:

1. **Inicialización:**

   * Se carga el shader según el tipo de renderizador (`GL2` o `GL3`).
   * Se crea un plano con subdivisiones (malla de triángulos).

2. **En cada `draw()`:**

   * Se inicia el shader con `shader.begin()`.
   * Se calculan y envían datos al shader con funciones como:

     * `setUniform1f("mouseRange", 150)`
     * `setUniform2f("mousePos", mx, my)`
     * `setUniform4fv("mouseColor", mouseColor)`
   * Se dibuja la malla deformada (`plane.drawWireframe()`).
   * Se termina el shader con `shader.end()`.

3. **En los shaders:**

   * El **vertex shader** recibe la posición del mouse y deforma los vértices cercanos.
   * El **fragment shader** usa `mouseColor` para colorear todos los píxeles.

---

### - Realiza modificaciones a ofApp.cpp y al vertex shader para conseguir otros comportamientos.

**Cambios en `ofApp.cpp`**

Cambia el gradiente de color para que vaya de **verde** a **rojo** en lugar de magenta a azul:

```cpp
// color cambia de verde a rojo según la posición horizontal del mouse
ofFloatColor colorLeft = ofColor::green;
ofFloatColor colorRight = ofColor::red;
ofFloatColor colorMix = colorLeft.getLerped(colorRight, percentX);
```

También puedes aumentar el `mouseRange` para que el efecto abarque más área:

```cpp
shader.setUniform1f("mouseRange", 250); // antes: 150
```
**Cambios en el `vertex shader` (GL2 y GL3)**

Modifica la intensidad del desplazamiento para que varíe **con un patrón de onda** (más expresivo visualmente):

**Resultado en contexto (`shader.vert` para GL3):**

```glsl
...
if(dist > 0.0 && dist < mouseRange) {
    float distNorm = dist / mouseRange;
    distNorm = 1.0 - distNorm;

    //parte modificada
    float intensity = sin(distNorm * 3.1415);
    dir *= distNorm * intensity * 2.0; // <- nueva intensidad dinámica
    
    pos.x += dir.x;
    pos.y += dir.y;
}
...
```
---
### - Realiza modificaciones al fragment shader para conseguir otros comportamientos.

```glsl
#version 150

// Recibe el color calculado en el vertex shader
in vec4 vColor;

// Salida final del color del píxel
out vec4 outputColor;

void main()
{
    // Usamos directamente el color interpolado que vino del vertex shader
    outputColor = vColor;
}
```
Basicamente hace lo mismo pero:
- El vertex shader calcula un color (vColor) según la distancia del vértice al mouse.

- Ese color se interpola automáticamente entre los vértices durante el rasterizado.

- El fragment shader simplemente recoge ese color interpolado y lo usa como color del píxel (outputColor).
  
https://www.canva.com/design/DAGoC1ipviQ/9IWVrRfcF-PLiyvHDxcwQA/edit?utm_content=DAGoC1ipviQ&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
