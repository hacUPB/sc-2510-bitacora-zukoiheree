@SCREEN   // Dirección base de la pantalla
D=A
@addr     // Guarda en una variable temporal
M=D

(LOOP)
@KBD      // Lee el teclado
D=M
@DRAW
D;JNE     // Si alguna tecla está presionada, ir a DRAW
@CLEAR
0;JMP     // Si no, ir a CLEAR

(DRAW)
@addr
D=M
@32
D=D+A     // Avanza una fila en la pantalla
@addr
M=D
A=D
M=-1      // Pinta 16 píxeles en negro
@LOOP
0;JMP     // Repetir

(CLEAR)
@addr
D=M
@32
D=D+A
@addr
M=D
A=D
M=0       // Borra 16 píxeles
@LOOP
0;JMP
