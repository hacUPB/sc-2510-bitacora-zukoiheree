Reto 5
---
Traduce este programa a lenguaje ensamblador:
```
// int a = 10;
@10
D=A
@16    // Dirección de 'a'
M=D    // a = 10

// p = &a;
@16
D=A
@17    // Dirección de 'p'
M=D    // p = dirección de a

// *p = 20;
@20
D=A         // D = 20
@17
A=M         // A = p (carga la dirección guardada en p)
M=D         // *p = 20 (guarda 20 en la dirección apuntada por p)
```
