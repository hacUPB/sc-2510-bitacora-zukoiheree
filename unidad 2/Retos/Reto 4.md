Reto 4
---
Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:

- ¿Cómo se declara un puntero en C++? `int *p;`. `p` es una variable que almacenará la dirección de un variable que almacena enteros.

- ¿Cómo se define un puntero en C++? `p = &a;`. Definir el puntero es inicializar el valor del puntero, es decir, guardar la dirección de una variable. En este caso `p` contendrá la dirección de `a`.

- ¿Cómo se almacena en C++ la dirección de memoria de una variable? Con el operador `&`. `p = &a;`

- ¿Cómo se escribe el contenido de la variable a la que apunta un puntero? Con el operador ``. `p = 20;`. En este caso como `p` contiene la dirección de `a` entonces `p` a la izquierda del igual indica que quieres actualizar el valor de la variable `a`.

 ```cpp
int a = 10;
int *p;
p = &a;
*p = 20;
```
---
```cpp
#include <iostream>

int main() {
    int a = 10;  // Declaración e inicialización de la variable a
    int *p;      // Declaración del puntero p
    p = &a;      // p almacena la dirección de a
    *p = 20;     // Se modifica el valor de a a través del puntero

    std::cout << "Valor de a: " << a << std::endl; // Debería imprimir 20
    return 0;
}
```
- Se declara una variable entera a y se le asigna el valor 10.

- int *p; declara un puntero a un entero.
- Un puntero almacena la dirección de memoria de otra variable.

- `p = &a;` significa que p ahora contiene la dirección de a.

- `*p = 20;`
- `*p` accede al contenido de la dirección almacenada en p. 
- Como p apunta a `a`, la asignación `*p = 20;` modifica el valor de a a 20.

- Valor de a: 20
