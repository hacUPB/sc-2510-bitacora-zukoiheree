// Dirección base de la pantalla
@SCREEN
D=A
@16384
M=D

// Bucle principal
(LOOP)
    // Leer entrada del teclado
    @24576
    D=M
    @CLEAR
    D;JEQ    // Si no hay tecla presionada, borrar pantalla

    // Comparar con la tecla 'd' (ASCII 68)
    @68
    D=D-A
    @DRAW
    D;JEQ    // Si es 'd', dibujar bitmap

    // Si no es 'd', volver al loop
    @LOOP
    0;JMP

// Rutina para borrar pantalla
(CLEAR)
    @16384
    D=A
    @i
    M=D  // i = 16384 (inicio de la pantalla)

(CLEAR_LOOP)
    @i
    D=M
    @24576
    D=D-A
    @LOOP
    D;JGE  // Si i >= 24576, volver al loop

    @i
    A=M
    M=0  // Poner el pixel en negro

    @i
    M=M+1  // i++
    @CLEAR_LOOP
    0;JMP  // Repetir

// Rutina para dibujar bitmap
(DRAW)
    @16384
    D=A

    // Primera fila
    @12
    AD=D+A
    @8
    D=D+A
    A=D
    M=-1  // Dibujar píxel (todos los bits en 1)

    // Segunda fila
    D=A
    @32
    AD=D+A
    @16404
    D=D+A
    A=D
    M=-1

    // Tercera fila
    AD=A+1
    @2048
    D=D+A
    A=D
    M=-1

    // Cuarta fila
    AD=A+1
    @2
    D=D+A
    A=D
    M=-1

    // Quinta fila
    D=A
    @30
    AD=D+A
    @8201
    D=D+A
    A=D
    M=-1

    // Sexta fila
    AD=A+1
    @4096
    D=D+A
    A=D
    M=-1

    // Séptima fila
    AD=A+1
    @33
    D=D+A
    A=D
    M=-1

    // Octava fila
    D=A
    @30
    AD=D+A
    @5600
    D=D+A
    A=D
    M=-1

    // Volver al bucle principal
    @LOOP
    0;JMP

