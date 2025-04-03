// Bucle principal para verificar si se presiona una tecla
(LOOP)
    @24576       // Dirección del teclado
    D=M          // Leer el valor del teclado
    @ENCENDER    // Si se presionó una tecla (D != 0), salta a ENCENDER
    D;JNE

    @LOOP        // Si no se presionó ninguna tecla, sigue verificando
    0;JMP

// Rutina para encender un píxel en la pantalla
(ENCENDER)
    @16384       // Dirección inicial de la pantalla (primer píxel)
    M=-1         // Encender el píxel (escribir -1 en la dirección de memoria)

    @LOOP        // Regresa al bucle principal para seguir verificando teclas
    0;JMP

