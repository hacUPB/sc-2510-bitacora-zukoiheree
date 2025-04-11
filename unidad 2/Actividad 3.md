Actividad 3
---
Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.

```
@16384   // Cargamos la dirección base de la pantalla
D=A      
@baseDir
M=D      // baseDir = 16384

(LOOP)
    // Leer el teclado
    @24576
    D=M
    @CLEAR
    D;JEQ       // Si no hay tecla presionada, ir a CLEAR

    @68         // Código ASCII de 'd'
    D=D-A
    @DRAW
    D;JEQ       // Si se presiona 'd', ir a dibujar

    @LOOP
    0;JMP       // Si no es 'd', seguir esperando

// ---- DIBUJAR IMAGEN ----
(DRAW)
    @baseDir
    D=M
    @12
    AD=D+A
    @8
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @16404
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @2048
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @2
    D=D+A
    A=D-A
    M=D-A

    D=A
    @30
    AD=D+A
    @8201
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @4096
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @33
    D=D+A
    A=D-A
    M=D-A

    D=A
    @30
    AD=D+A
    @5600
    D=D+A
    A=D-A
    M=D-A

    @LOOP
    0;JMP

// ---- BORRAR IMAGEN ----
(CLEAR)
    @baseDir
    D=M
    @12
    AD=D+A
    @8
    D=D+A
    A=D-A
    M=0

    D=A
    @32
    AD=D+A
    @16404
    D=D+A
    A=D-A
    M=0

    AD=A+1
    @2048
    D=D+A
    A=D-A
    M=0

    AD=A+1
    @2
    D=D+A
    A=D-A
    M=0

    D=A
    @30
    AD=D+A
    @8201
    D=D+A
    A=D-A
    M=0

    AD=A+1
    @4096
    D=D+A
    A=D-A
    M=0

    AD=A+1
    @33
    D=D+A
    A=D-A
    M=0

    D=A
    @30
    AD=D+A
    @5600
    D=D+A
    A=D-A
    M=0

    @LOOP
    0;JMP
```
- Se agregó una etiqueta CLEAR que borra exactamente las mismas posiciones que el bloque DRAW modificó.

- En LOOP, si el teclado está en 0 (KBD = 0), se salta a CLEAR.

- El dibujo solo aparece si se presiona la tecla 'd'.

