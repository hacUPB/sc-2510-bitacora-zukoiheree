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

//11. Considera el siguiente programa: - ¿Qué hace este programa?
//- ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
//- ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
//- ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
//- ¿Qué son CONT y LOOP?
//- ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?
i = 1000
LOOP:
if (i == 0) goto CONT
i = i - 1
goto LOOP
CONT:
//- Decrementa la variable `i` desde 1000 hasta 0, y cuando llega a 0, salta a CONT.
//- La variable i está almacenada en la RAM. La dirección exacta no se especifica, pero probablemente sea a partir de la dirección 16 en adelante.
//- Los comentarios no se almacenan en memoria; son solo anotaciones.
//- La primera instrucción es @1000. Esta se ejecuta desde la ROM en la dirección 0.
//- Son etiquetas que marcan puntos específicos en el código. LOOP es el inicio del ciclo, y CONT es el punto al que se salta cuando i == 0.
//- i es una variable almacenada en memoria, mientras que CONT es una etiqueta que define una ubicación en el código.

//12. Implemente en ensamblador:
R4 = R1 + R2 + 69

@1
D=M          
@2
D=D+M        
@4
M=D
@4
D=M          
@69
D=D+A        
@4
M=D

//13. Implementa en ensamblador:
if R0 >= 0 then R1 = 1
else R1 = –1

(LOOP)
goto LOOP

@0
D=M          
D;GE         
M=-1         
0;JMP        
@1
D=A          
@R1
M=D          
0;JMP 

//14. Implementa en ensamblador:
R4 = RAM[R1]

@R1
D=M         
A=D         
D=M          
@R4
M=D          

//15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. 
En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.//






