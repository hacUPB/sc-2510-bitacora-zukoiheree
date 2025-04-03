**Reto 2**
---
Transforma el programa en alto nivel anterior para que utilice un ciclo for en vez de un ciclo while.

```
#include <iostream>

int main() {
   int sum = 0;
   
   // Ciclo for en lugar de while
   for (int i = 1; i <= 100; i++) {
       sum += i;
   }

   std::cout << "La suma de los números del 1 al 100 es: " << sum << std::endl;
   return 0;
}
```
Un ciclo for que repite la operación 100 veces, desde i = 1 hasta i = 100.

En cada iteración, el valor de i se suma a sum.
```
i = 1 → sum = 0 + 1 = 1
i = 2 → sum = 1 + 2 = 3
i = 3 → sum = 3 + 3 = 6
i = 4 → sum = 6 + 4 = 10
...
i = 100 → sum = 5050
```
