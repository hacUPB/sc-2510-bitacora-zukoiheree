**Actividad 3**
---
![image](https://github.com/user-attachments/assets/ba3388ea-be40-4882-93be-e0e23aee79ac)
---
### ¿Qué es un `uniform`?

Un **uniform** es una variable en los shaders que tiene un valor constante durante todo el procesamiento de un dibujo (es decir, durante la ejecución de un solo renderizado). Se puede enviar desde la CPU (en este caso desde openFrameworks) al GPU antes de que se ejecute el shader, y su valor se usa por todos los vértices o fragmentos procesados.

### ¿Cómo funciona el código de aplicación y los shaders? ¿Cómo se comunican?

En el código de aplicación:

* **Configuración inicial**: La aplicación carga el shader y envía datos (como el tiempo) a los shaders mediante las funciones `setUniform*`.
* **Shaders**: El **vertex shader** procesa los vértices, y el **fragment shader** procesa los píxeles. La comunicación se hace usando variables `uniform`, `attribute` y `varying`.

### Modificación para personalizar el color en el fragment shader:

Para cambiar el color de cada píxel de la pantalla, puedes modificar el fragment shader como sigue:

#### Modificación en `shader.frag`:

**`shadersGL2`**
```glsl
uniform float time;

void main()
{
    float red = 0.5 + 0.5 * sin(time);
    float green = 0.5 + 0.5 * cos(time);
    float blue = 0.5 + 0.5 * sin(time + 3.14159);

    gl_FragColor = vec4(red, green, blue, 1.0);
}

```

**`shadersGL3`**
```glsl
uniform float time;

out vec4 outputColor;

void main()
{
    float red = 0.5 + 0.5 * sin(time);
    float green = 0.5 + 0.5 * cos(time);
    float blue = 0.5 + 0.5 * sin(time + 3.14159);

    outputColor = vec4(red, green, blue, 1.0);
}
```
En este código, el color de cada píxel cambiará con el tiempo, creando una animación de colores basada en las funciones seno y coseno. La variable `time` se pasa al shader desde la aplicación.

**Video de prueba:** https://www.canva.com/design/DAGnjYurDRw/TOf0pmMiDv8J8vP29AustQ/edit?utm_content=DAGnjYurDRw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

