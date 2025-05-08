Actividad 2
---
### 1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++?

En una implementación manual de un stack, la memoria para cada nodo se reserva dinámicamente con `new` al hacer `push`, y se libera con `delete` al hacer `pop` o `clear`. Esto permite que el stack crezca o disminuya dinámicamente en tiempo de ejecución sin un límite fijo.

**Impacto en rendimiento y seguridad:**
- **Rendimiento:** Usar `new` y `delete` implica operaciones en el heap, que son más costosas que usar memoria en la pila del programa (stack call). Si las operaciones son muy frecuentes, puede haber impacto en el rendimiento.
- **Seguridad:** Un mal manejo puede provocar fugas de memoria (no liberar) o errores por doble liberación o acceso a punteros colgantes.

---

### 2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo?

Cada vez que se desapila un nodo, se elimina un bloque de memoria asignado dinámicamente. Si no se libera, esa memoria queda ocupada sin ser utilizada, generando **fugas de memoria**.

**Consecuencias:**
- En una app de ejecución prolongada (como una instalación interactiva o una herramienta artística en tiempo real), las fugas pueden acumularse y agotar la memoria disponible.
- Puede causar ralentización, fallos del sistema o incluso que el programa sea terminado por el sistema operativo.

---

### 3. ¿Qué diferencias existen entre usar un stack de la STL (`std::stack`) y crear uno manualmente?

**`std::stack`:**
- Usa plantillas y estructuras como `std::deque` por debajo.
- La gestión de memoria está automatizada.
- Muy seguro y probado, ideal para código de producción.
- No tienes control sobre la forma exacta en que se almacenan los datos.

**Stack manual:**
- Tienes control total sobre cómo se almacenan y manejan los nodos.
- Puedes integrarlo directamente con la lógica visual (como en OpenFrameworks).
- Ideal para aprender cómo funciona la estructura a nivel de memoria.
- Más propenso a errores si no se maneja correctamente `new` y `delete`.

---

### 4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos?

Un stack implementa una política **LIFO** (Last In, First Out), lo que significa que el último elemento en entrar es el primero en salir.

**Implicaciones:**
- Ideal para problemas como deshacer acciones, recorrido de árboles (DFS), análisis de expresiones, backtracking.
- No permite acceso aleatorio directo a elementos del medio.
- Muy eficiente en tiempo constante (`O(1)`) para `push` y `pop`.

---

### 5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos?

Cambiamos la clase `Node` para que contenga, por ejemplo, una estructura o clase que tenga múltiples atributos:

```cpp
class Particle {
public:
    ofVec2f position;
    float radius;
    ofColor color;
};

class Node {
public:
    Particle data;
    Node* next;
};
```

**Consideraciones de memoria:**
- Si los objetos complejos contienen recursos dinámicos (como punteros o archivos), deberás asegurarte de liberar esos recursos en el destructor del nodo o usar **smart pointers** como `std::shared_ptr`.
- Usar clases con constructores y destructores bien definidos ayuda a prevenir errores de acceso a memoria no válida. 
