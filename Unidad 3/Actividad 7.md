**Actividad 7** 
--------------
- ¿Qué sucede cuando presionas la tecla “c”?

Cuando presionas la tecla "c", se crea un objeto Sphere en la pila *stack* y se almacena su dirección en globalVector. Sin embargo, cuando la función termina, el objeto se borra automáticamente, dejando un puntero inválido en *globalVector*

---
Realiza esta modificación a la función createObjectInStack donde claramente se está creando un objeto, pero se está creando en el heap y no en el stack, así que no te dejes confundir por el nombre de la función.

- ¿Qué sucede cuando presionas la tecla “c”?
- ¿Por qué ocurre esto?
  
Cuando presionas la tecla "c", se crea un nuevo objeto *Sphere* en el *heap* usando +new*. Luego, un puntero a este objeto se almacena en el vector *globalVector*. La esfera se dibuja y se registra su posición en la consola con *ofLog()*. Como el objeto está en el heap, no se elimina automáticamente cuando la función termina, evitando así el problema de acceder a memoria inválida.
  

  

