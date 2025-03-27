Actividad 9
---
- 1. ¿Qué sucede cuando presionas la tecla “f”?
- 2. Analiza detalladamente esta parte del código:
  
```
if(!heapObjects.empty()) {
    delete heapObjects.back();
    heapObjects.pop_back();
}
```
---
1. En keyPressed(int key) Cada vez que presionas la tecla 'f', el código elimina el último objeto almacenado en el heap y lo remueve de la lista *heapObjects*.

2.
```
if (!heapObjects.empty()) {
```
-Antes de eliminar un objeto, el programa verifica si el vector heapObjects no está vacío.
-Esto previene errores al intentar eliminar algo de un vector vacío.

```
delete heapObjects.back();
```
-heapObjects.back() obtiene el último puntero almacenado en el vector.
-delete libera la memoria reservada en el heap para este objeto.
-Esto evita fugas de memoria.

```
heapObjects.pop_back();
```
-pop_back() elimina el puntero del vector heapObjects.
-Es importante hacer esto después del delete, porque si solo se eliminara el puntero del vector sin liberar la memoria, habría una fuga de memoria.



