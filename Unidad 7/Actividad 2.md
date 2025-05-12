**Actividad 2**
---
![image](https://github.com/user-attachments/assets/92cc136f-ba3a-44c5-aca1-3dd1ad0e0783)
---

### ¿Cómo funciona?

Este programa dibuja un rectángulo del tamaño de la ventana y le aplica un shader personalizado. El shader se ejecuta en la GPU y modifica la apariencia del rectángulo en tiempo real, lo cual permite efectos visuales que serían costosos o imposibles de hacer solo con la CPU.

---

### ¿Qué resultados obtuviste?

Una ventana completamente coloreada con un degradado de los colores azules
---

### ¿Estás usando un vertex shader?

Sí. Incluso si solo transforma las coordenadas sin cambios, el archivo `.vert` es obligatorio para OpenGL moderno (el uso de un vertex shader es obligatorio porque ya no se incluyen los shaders fijos (fixed-function pipeline) que antes se encargaban automáticamente de transformar vértices.). El vertex shader procesa cada vértice del rectángulo.

---

### ¿Estás usando un fragment shader?

Sí. El archivo `.frag` define cómo se colorea cada fragmento (píxel) del rectángulo. Es el encargado del color final que ves en pantalla.

---

### Analiza el código de los shaders. ¿Qué hace cada uno?

**Vertex Shader (`shader.vert`)**:

* Toma la posición del vértice y la pasa sin cambios (común en shaders simples).
* Su propósito es posicionar los vértices del rectángulo en la pantalla.

**Fragment Shader (`shader.frag`)**:

* Define el color de cada píxel.
* En el caso del tutorial básico, suele devolver un color sólido como `gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);` (azul).
