Reto 3
---
Escribe un programa en lenguaje ensamblador que implemente el programa anterior.
```
// Inicializar variables
@i
M=1      // i = 1
@sum
M=0      // sum = 0

(LOOP)
    // Comparar si i > 100
    @i
    D=M      // D = i
    @100
    D=D-A    // D = i - 100
    @END
    D;JGT    // Si i > 100, salir del bucle

    // sum = sum + i
    @sum
    D=M      // D = sum
    @i
    D=D+M    // D = sum + i
    @sum
    M=D      // Guardar nuevo valor en sum

    // i++
    @i
    M=M+1    // i = i + 1

    @LOOP
    0;JMP    // Repetir el ciclo

(END)
    @END
    0;JMP    // Bucle infinito al final
```

**Inicialización**:
- i = 1
- sum = 0

**Ciclo for**:
- Comprueba si i > 100. Si si salta a (END).
- Suma i a sum.
- Incrementa i (El incremento de i es lo que permite avanzar en el ciclo. Es como un contador que va subiendo para que el programa sepa cuántas veces ha hecho la suma y cuándo debe detenerse (cuando llega a 100)).
- Vuelve a la etiqueta (LOOP).

**Fin**:
- Cuando i > 100, salta a (END), donde se entra en un bucle parar el programa.
