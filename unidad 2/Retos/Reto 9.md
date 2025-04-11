Reto 9
---
Considera que el punto de entrada del siguiente programa es la función main, es decir, el programa inicia llamando la función main. 
Vas a proponer una posible traducción a lenguaje ensamblador de la función suma, cómo llamar a suma y cómo regresar a std::cout << "El valor de c es: " << c << std::endl; una vez suma termine.

```cpp
#include <iostream>

int suma(int a, int b) {
   int var = a + b;
   return var;
}


int main() {
   int c = suma(6, 9);
   std::cout << "El valor de c es: " << c << std::endl;
   return 0;
}
```

## En lenguaje ensamblador

```
// Sección de la función suma(a, b)
(SUMA)
    @ARG0     // ARG[0] = a
    D=M
    @ARG1   // ARG[1] = b
    D=D+M    // D = a + b
    @var
    M=D      // var = a + b

    @var
    D=M      // D = var
    @RETURN  // Retorno a main
    0;JMP

// Punto de entrada al programa (main)
(MAIN)
    // Pasar argumentos a la función suma (a = 6, b = 9)
    @6
    D=A
    @ARG0
    M=D      // ARG[0] = 6

    @9
    D=A
    @ARG1
    M=D      // ARG[1] = 9

    @SUMA    // Llamar a la función suma
    0;JMP

(RETURN)
    @var
    D=M      // D = resultado de suma
    @c
    M=D      // c = resultado de suma

    // Simular std::cout << "El valor de c es: " << c << std::endl;
    @MSG
    D=A
    @SCREEN
    M=D      // Muestra mensaje en pantalla

    // Bucle infinito para detener el programa
(END)
    @END
    0;JMP

// Simulación de cout
// (conceptual porque esto no se representa directamente en Nand2Tetris)
@C
D=M
// Imprimir "El valor de c es: ", luego el valor contenido en D
```
### Etiqueta	Uso
- ARG0	Lugar para guardar el primer argumento (a)
- ARG1	Lugar para guardar el segundo argumento (b)
- RET	Dirección de retorno (a dónde volver después de terminar suma)
- RESULT	Variable donde se guarda el valor que devuelve la función suma
- C	Variable local para main donde se guarda el resultado de suma

