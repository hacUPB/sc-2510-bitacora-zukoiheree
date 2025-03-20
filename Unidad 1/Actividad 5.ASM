//1. Carga en D el valor 1978.
@1978
D=A

//2. Guarda en la posición 100 de la RAM el número 69.
@69
D=A
@100
M=D

//3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
@24
D=M
@200
M=D

//4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.
@100
D=M
@15
D=D-A
@100
M=D

//5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.
@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

//6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.
@100
D;JEQ

//7. Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
@100 
D=M
@100
D=D-A
@20
D;JLT

//8. Considera el siguiente programa: - ¿Qué hace este programa?
- En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?//
@var1
D = M
@var2
D = D + M
@var3
M = D
//- Este programa toma el valor de almacenamiento de dos lugares aleatorios (var1 y var2) y los suma a la RAM para despues mover el resultado a la posicion var3.
- Por que se encuentran en la posicion 16, 17 y 18, lo que indica que los espacios del 0 al 15 se encuentran en la RAM//

//9. Considera el siguiente programa: - ¿Qué hace este programa?
- ¿En qué parte de la memoria RAM está la variable `i` y `sum`? ¿Por qué en esas posiciones?//
i = 1
sum = 0
sum = sum + i
i = i + 1
//- Suma la cantidad existente de la primera variable a la segunda de la RAM
- Por lo que i y sum son las variables 16 y 17//
//Optimizacion:
i=i + 1
@i
M=M+1

//10. Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico R0 a R15. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.
@0
D=M
@4
M=D
@4
D=D+M
@1
M=D

//11. Considera el siguiente programa:
- ¿Qué hace este programa?
- ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
- ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
- ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
- ¿Qué son CONT y LOOP?
- ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?//
// i = 1000
@1000
D=A
@i
M=D
(LOOP)
// if (i == 0) goto CONT
@i
D=M
@CONT
D;JEQ
// i = i - 1
@i
M=M-1
// goto LOOP
@LOOP
0;JMP
(CONT)

//- Decrementa la variable i desde 1000 hasta 0, y cuando llega a 0, salta a CONT para acabar el bucle.
//- La variable i está almacenada en la RAM. La dirección exacta no se especifica, pero probablemente sea a partir de la dirección 16 en adelante.
//- @0, @1, @2 y @3
//- La primera instrucción es @1000. Esta se ejecuta desde la ROM en la dirección 0.
//- Son etiquetas que marcan puntos específicos en el código. LOOP es el inicio del ciclo, y CONT es el punto al que se salta cuando i == 0.
//- i es una variable almacenada en memoria, mientras que CONT es una etiqueta que define una ubicación en el código.

//12. Implemente en ensamblador:
R4 = R1 + R2 + 69 

@R2
D=M 
@R3 
M=D 
@R2 
D=M 
@3 
D=D+M 
@69 
D=D+A 
@R4 
M=D 

//13. Implementa en ensamblador:
if R0 >= 0 then R1 = 1
else R1 = –1

(LOOP)
goto LOOP

@0 
D=M 
@9 
D;JLT 
@1 
D=A 
@1 
M=D 
@0
0;JMP
@1 
D=A 
@2 
D=D-A 
@1 
M=D 
@0
0;JMP

//14. Implementa en ensamblador:
R4 = RAM[R1]

@R1  
D=M      // Cargar el valor de R1 (dirección de memoria) en D  
A=D      // Apuntar a la dirección almacenada en R1  
D=M      // Cargar en D el valor almacenado en esa dirección  
@R4  
M=D      // Guardar el valor en R4  
// Este código copia el contenido de la posición de memoria indicada en R1 y lo almacena en R4.


//15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. 
En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.//

@R1      
D=M       
@R0    
A=M       
M=-1    
@R0    
M=M+1     
D=D-1     
@2       
D;JGT

//Este programa llena un bloque de memoria con -1, comenzando desde la dirección almacenada en R0, y repitiéndose R1 veces.

//16. Implementa en lenguaje ensamblador el siguiente programa:
int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}

// Inicialización
@ARR      
D=A        // Dirección base del array
@J        
M=0        // j = 0
@SUM      
M=0        // sum = 0
(LOOP_SUM)
@J
D=M
@10
D=D-A
@END_SUM
D;JGE     // Si j >= 10, salir del bucle
@ARR
D=A
@J
A=D+M     // Acceder a arr[j]
D=M       // D = arr[j]
@SUM
M=M+D     // sum = sum + arr[j]
@J
M=M+1     // j++
@LOOP_SUM
0;JMP     // Repetir el bucle
(END_SUM)
@END_SUM
0;JMP     // Bucle infinito

// Variables
(ARR)   // Dirección base del array
@1000   
D=A
@ARR
M=D
(SUM)   // Variable sum
@0
M=0
(J)     // Índice j
@0
M=0


//17. Implementa en lenguaje ensamblador: if ( (D - 7) == 0) goto a la instrucción en ROM[69]

@69
M=A 
@7
D=D-A
@69
D;JEQ
//guarda el dato 69 en la memroria 69, le resta 7 a D y si da 0 salta a la direccion 69

//18. Utiliza esta herramienta para dibujar un bitmap en la pantalla.

@16384 
D=A 
@12 
AD=D+M 
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

//19. Analiza el siguiente programa en lenguaje de máquina: ¿que hace este programa?

@16384        // 0100000000000000  
D=A           // 1110110000010000  
@16           // 0000000000010000  
M=D           // 1110001100001000 

@24576        // 0110000000000000  
D=M           // 1111110000010000  
@19           // 0000000000010011  
D;JEQ         // 1110001100000101  

@16           // 0000000000010000  
D=M           // 1111110000010000  
@16384        // 0100000000000000  
M=D           // 1110010011010000  

@4            // 0000000000000100  
D;JLT         // 1110001100000110  

@16           // 0000000000010000  
M=M+1         // 1111110010101000  

D=0           // 1110101010001000  
@4            // 0000000000000100 
D;JGT         // 1110101010000111  

@16           // 0000000000010000  
D=M           // 1111110000010000  

@24576        // 0110000000000000  
M=D           // 1110010011010000  

@4            // 0000000000000100  
D;JLE         // 1110001100000011 

@16           // 0000000000010000  
M=M-1         // 1111110000100000 

D=M           // 1110111010001000  

@16           // 0000000000010000  
M=M-1         // 1111110111001000  

@4            // 0000000000000100  
D;JGT         // 1110101010000111  

// Este programa parece implementar un contador basado en la entrada del teclado, actualizando la pantalla en consecuencia. 
Si se presiona una tecla, probablemente se altere el comportamiento del contador.//

//20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.










