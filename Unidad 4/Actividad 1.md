Actividad 1
---

### **3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?**

Una **lista enlazada** es una estructura de datos compuesta por nodos, donde cada nodo contiene un valor y un puntero al siguiente nodo. A diferencia de un arreglo:

- Los elementos **no están contiguos en memoria**, se encuentran dispersos y conectados por punteros.
- No necesitas declarar un tamaño fijo desde el inicio como en los arreglos.
- La inserción y eliminación de elementos es más eficiente en posiciones intermedias.

---

### **4. ¿Cómo se vinculan los nodos entre sí en una lista enlazada?**

Se vinculan utilizando **punteros**. Cada nodo tiene un puntero (`Node* next`) que apunta al siguiente nodo en la lista. Así se crea una cadena de elementos.

---

### **5. ¿Cómo se gestiona la memoria en una lista enlazada con `new` y `delete`?**

Cuando se agrega un nuevo nodo, se usa `new` para reservar memoria en el **heap**:

```cpp
Node* newNode = new Node(x, y);
```

Cuando ya no se necesita, se libera esa memoria con `delete`:

```cpp
delete current;
```

Esto previene fugas de memoria y permite un control explícito sobre el ciclo de vida de cada nodo.

---

### **6. ¿Qué ventajas tiene una lista enlazada al insertar o eliminar elementos intermedios?**

En una lista enlazada:

- **Insertar/eliminar** un nodo no requiere mover los demás elementos.
- Basta con cambiar algunos punteros, lo cual es más eficiente que en un arreglo, donde habría que desplazar muchos elementos.

---

### **7. ¿Cómo se evita la fuga de memoria en el código? ¿Qué hace el destructor en `LinkedList`?**

El destructor (`~LinkedList`) llama a `clear()`, que recorre cada nodo y lo elimina con `delete`. Así se libera toda la memoria reservada.

Esto garantiza que no queden nodos "huérfanos" en el heap cuando el objeto se destruye.

---

### **8. ¿Qué sucede en memoria cuando se invoca `clear()`?**

Paso a paso:

1. Se toma el puntero al primer nodo.
2. Se guarda el siguiente nodo en una variable temporal.
3. Se elimina el nodo actual con `delete`.
4. Se repite el proceso con el nodo siguiente.

Así, uno por uno, se eliminan todos los nodos y se libera su memoria del heap.

---

### **9. ¿Cómo cambia la estructura al agregar un nodo al final? ¿Afecta al rendimiento?**

- Se crea un nuevo nodo con `new`.
- El puntero `tail->next` apunta al nuevo nodo.
- Se actualiza `tail` para que apunte al nuevo nodo.

Esto es eficiente si tienes una referencia a `tail`, como en tu código. Si no, habría que recorrer toda la lista para llegar al final, lo cual **sí afecta al rendimiento**.

---

### **10. ¿Cuándo usarías una lista enlazada en lugar de un arreglo?**

Ejemplo: una app donde los elementos (como partículas o nodos visuales) se añaden y eliminan frecuentemente en distintas posiciones.

Una lista enlazada permite modificar la estructura sin necesidad de mover o redimensionar grandes bloques de memoria, como ocurre con los arreglos.

---

### **11. ¿Cómo usarías este conocimiento en una aplicación creativa?**

Si diseñara una estructura personalizada, como una línea viva o una cadena animada:

- Usaría una lista enlazada para representar elementos móviles conectados.
- Controlaría bien los `new` y `delete` en cada ciclo para evitar fugas.
- Consideraría usar `std::unique_ptr` o `shared_ptr` si quiero seguridad extra en memoria.

---

### **12. ¿Diferencias de C++ vs C# en gestión de memoria?**

- En C++, tú manejas todo: reservas y liberas memoria con `new` y `delete`.
- En C#, la recolección de basura (GC) hace esto automáticamente.

**Ventaja en C++:** más control y eficiencia si sabes lo que haces.  
**Desventaja:** más riesgo de errores (fugas, `dangling pointers`, `double delete`...).

---

### **13. ¿Cómo optimizarías una obra generativa que usa listas enlazadas?**

- Evitaría usar `new` y `delete` en cada frame. Podría usar **pools de nodos** (reutilizables).
- Usaría `clear()` solo cuando sea necesario, no cada ciclo.
- Supervisaría el uso de memoria con el depurador.
- Agregaría lógica para evitar nodos huérfanos si la animación se detiene de golpe.

---

¿Quieres que te ayude a escribir esto como un informe o necesitas algún dibujo de cómo se ve la memoria con nodos enlazados?
