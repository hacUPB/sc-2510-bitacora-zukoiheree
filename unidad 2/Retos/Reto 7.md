Reto 7
---
Traduce este programa a lenguaje ensamblador:
```
// Asignación de valores iniciales
@10
D=A
@a
M=D    // a = 10

@5
D=A
@b
M=D    // b = 5

// Asignar la dirección de 'a' al puntero 'p'
@a
D=A    // D = dirección de a
@p
M=D    // p = &a

// Asignar el valor de 'a' a 'b' a través de 'p'
@p
D=M    // D = p (dirección de a)
A=D    // A = dirección de a
D=M    // D = valor de a (10)
@b
M=D    // b = *p (b = 10)

// Fin del programa
(END)
@END
0;JMP
```
