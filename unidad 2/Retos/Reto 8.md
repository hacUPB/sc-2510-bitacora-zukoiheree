Reto 8
---
### ¿Qué hace esto int *pvar;?

- Declara una **variable puntero a entero** llamada `pvar`.  
Esto significa que `pvar` no guarda un número como tal, sino una **dirección de memoria** que apunta a un entero.


### ¿Qué hace esto pvar = var;?

- Esto **es incorrecto**, *a menos que `var` sea una dirección de memoria* (otro puntero).  
Si `var` es un entero (como `int var = 10;`), entonces `pvar = var;` intenta guardar el número 10 como si fuera una dirección, lo cual es un error lógico y probablemente también de compilación.

**Lo correcto sería:** `pvar = &var;`  


### ¿Qué hace esto var2 = *pvar;?

- Esta línea accede al **valor al que apunta `pvar`** y lo guarda en `var2`.
*pvar significa: "ve a la dirección que guarda `pvar` y lee el número que hay ahí".

### ¿Qué hace esto `pvar = &var3;?

-Guarda en `pvar` la **dirección de memoria de `var3`**.  
Es decir, ahora `pvar` está apuntando a la variable `var3`.
