Actividad 4
---
Ahora realizarás una nueva variación al programa de la actividad anterior. 
Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Solo si se presiona la letra “e” borrarás la imagen que se muestra en pantalla.
```
@16384        // Dirección base de la pantalla
D=A
@baseDir
M=D           // Guardar baseDir = 16384

(LOOP)
    // Leer el teclado
    @24576
    D=M
    @LOOP
    D;JEQ       // Si no hay tecla presionada, seguir en el loop

    @68         // Comparar con código ASCII de 'd'
    D=D-A
    @DRAW
    D;JEQ       // Si D == 68 (tecla 'd'), ir a dibujar

    @69         // Comparar con código ASCII de 'e'
    D=D-A
    @CLEAR
    D;JEQ       // Si D == 69 (tecla 'e'), ir a borrar

    @LOOP
    0;JMP       // Si se presionó otra tecla, ignorar

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
