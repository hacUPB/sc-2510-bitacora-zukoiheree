// Dirección base de la pantalla
@SCREEN
D=A
@base
M=D  // Guardamos la dirección base de la pantalla

// Bucle principal
(LOOP)
    // Verificar si la tecla 'd' (código ASCII 100) está presionada
    @KBD
    D=M
    @DRAW
    D;JEQ  // Si no hay tecla presionada, saltar
    @100  // Código ASCII de 'd'
    D=D-A
    @DRAW
    D;JEQ  // Si la tecla presionada es 'd', saltar a dibujar
    @LOOP
    0;JMP  // Repetir el bucle

// Dibujar el bitmap
(DRAW)
    @base
    D=M
    @12
    AD=D+A  // Desplazamiento de línea
    @8
    D=D+A  // Desplazamiento de píxel
    A=D
    M=-1  // Dibujar un bloque de píxeles
    
    @32
    AD=D+A
    A=D
    M=-1
    
    @2048
    AD=D+A
    A=D
    M=-1
    
    @2
    AD=D+A
    A=D
    M=-1
    
    @30
    AD=D+A
    @8201
    D=D+A
    A=D
    M=-1
    
    @4096
    AD=D+A
    A=D
    M=-1
    
    @33
    AD=D+A
    A=D
    M=-1
    
    @5600
    AD=D+A
    A=D
    M=-1
    
    @LOOP
    0;JMP  // Regresar al bucle principal








