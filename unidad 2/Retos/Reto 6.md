Reto 6
---
Ahora vas a usar un puntero para leer la posición de memoria a la que este apunta, es decir, vas a leer por medio del puntero la variable cuya dirección está almacenada en él.
```
    int a = 10;
    int b = 5;
    int *p;
    p = &a;
    b = *p;
 ```
En este caso `b = *p;` hace que el valor de `b` cambie de 5 a 10 porque `p` apunta a la la variable `a` y con `*p` a la derecha del igual estás leyendo el contenido de la variable apuntada.

---
`int a = 10;`   Declaras 'a' con valor 10
`int b = 5;`    Declaras 'b' con valor 5
`int *p;`       Declaras un puntero a int llamado 'p'
`p = &a;`       Guardas la dirección de 'a' en 'p'
`b = *p;`       Accedes al contenido de la dirección apuntada por 'p', o sea, a

**Línea clave**
```
b = *p;
```
- *p significa: "ve a la dirección guardada en p y trae el valor que hay ahí".

- Como p apunta a a, *p es lo mismo que a.

- Entonces, b termina teniendo el mismo valor que a, que es 10.
