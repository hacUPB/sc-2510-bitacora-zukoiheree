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


