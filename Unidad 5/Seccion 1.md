Sesión 1: la naturaleza de los objetos en C++
---
### Introducción a los Objetos
```cpp
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```
### - ¿Qué representa la clase Particle?
La clase Particle es una plantilla o molde que define:

- Qué datos tiene una partícula (en este caso, x y y, sus coordenadas en el espacio).

- Qué acciones o comportamientos puede realizar (en este caso, el método move que cambia su posición).

Podemos decir que Particle define cómo debería comportarse y qué debería tener cualquier objeto que sea una partícula.

  
### - ¿Cómo interactúan sus atributos y métodos?
- **Atributos**: son variables que representan el **estado** de un objeto. En este caso:
  - `x`: posición horizontal de la partícula.
  - `y`: posición vertical de la partícula.

- **Métodos**: son funciones definidas dentro de una clase. Representan **acciones** que el objeto puede realizar.
  - `move(float dx, float dy)`: mueve la partícula cambiando sus coordenadas `x` y `y`.

¿Cómo interactúan en la práctica?

Supongamos este código:

```cpp
Particle p;
p.x = 100;
p.y = 50;

p.move(10, -5);
```

1. **Se crea un objeto `p`** de tipo `Particle`. En memoria, se asignan dos espacios `float` para `x` y `y`:
   - Inicialmente, `x = 100` y `y = 50`.

2. **Se llama al método `move(10, -5)`**, lo que hace que se ejecute este código:

   ```cpp
   x += dx;  // x = x + dx → x = 100 + 10 = 110
   y += dy;  // y = y + dy → y = 50 + (-5) = 45
   ```

   Aquí es donde ocurre la interacción directa:
   - El método `move` modifica los atributos `x` y `y` del objeto `p`.
   - `dx` y `dy` son argumentos que se pasan temporalmente al método, y se usan para modificar el estado del objeto.


### - Explícame en detalle qué es un objeto en C++ y cómo se relaciona con una clase. Usa el ejemplo de una clase Particle con atributos `x` y `y` y un método `move`.

**¿Qué es un objeto?**
Un objeto es una instancia concreta de una clase. Es decir, es una versión real, creada en memoria, de ese molde que definimos con class.

Cuando declaras:
   ```cpp
Particle p1;
   ```
Estás creando un objeto llamado p1 en memoria. Este objeto tiene su propia copia de los atributos x y y, y puede ejecutar su propio comportamiento con move.

---
### Explorando la memoria

Considera los siguientes pasos:

1. Crear instancias:

```cpp
Particle p1;
Particle p2;
```

2. Explorar la memoria usando punteros:

```cpp
std::cout << "Dirección de p1: " << &p1 << std::endl;
std::cout << "Dirección de p2: " << &p2 << std::endl;
```

3. Determinar el tamaño del objeto:

```cpp
std::cout << "Tamaño de Particle: " << sizeof(Particle) << " bytes" << std::endl;
```

4. Imprimir direcciones de atributos:

```cpp
std::cout << "Dirección de p1.x: " << &(p1.x) << std::endl;
std::cout << "Dirección de p1.y: " << &(p1.y) << std::endl;
```

### - ¿Los atributos están almacenados de forma contigua?
Sí, en la mayoría de los casos los atributos de una clase en C++ están almacenados de forma contigua en memoria, en el mismo orden en que fueron declarados.

Si `sizeof(float) = 4`, entonces:

- Si la dirección de `x` es 0x1000

- La dirección de `y` será 0x1004

Esto es porque `x` y `y` están uno al lado del otro en la memoria dentro del mismo objeto.

### - ¿Qué indica el tamaño del objeto sobre su estructura interna?
El valor de sizeof(Particle) nos dice cuántos bytes ocupa en memoria una instancia de Particle. También da pistas sobre:

Cuántos atributos tiene y qué tipos son
- Si hay padding (espacio agregado por alineación de memoria)
- Si hay herencia (el tamaño incluiría miembros de la clase base)
- Si hay objetos como atributos (el tamaño incluiría los tamaños de esos objetos)
- `sizeof(Particle)` debería ser 8 bytes (4 por `x` + 4 por `y`).
- Si ves un tamaño mayor, puede ser por alineación/padding.

### - ¿Cómo se almacenan los objetos en memoria en C++? Si tengo dos instancias de Particle, ¿Cómo se relacionan sus direcciones de memoria? ¿Los atributos están contiguos?

1. Ubicación en memoria:
Si creas una instancia así: Particle p1;, se almacena en el stack.

Si usas new: Particle* p1 = new Particle();, se almacena en el heap.

2. Cada objeto tiene su espacio independiente:
Cuando haces:
```cpp
Particle p1;
Particle p2;
Se crean dos regiones de memoria separadas para p1 y p2.
```
Sus direcciones &p1 y &p2 serán distintas.

Sus atributos (p1.x, p1.y, p2.x, p2.y) también están separados.

3. ¿Están los atributos contiguos?
Sí, dentro de cada objeto, los atributos suelen estar contiguos (aunque puede haber pequeños espacios de padding por razones de alineación del procesador).

Visualización (hipotética):
```scss
p1 (en dirección 0x1000):
  x → 0x1000
  y → 0x1004

p2 (en dirección 0x1010):
  x → 0x1010
  y → 0x1014
```
---
### Análisis de diferencias

Objetivo: comparar cómo diferentes clases afectan el uso de memoria.

Considera los siguientes pasos:

1. Crear clases con diferentes atributos y métodos:

```cpp
class Simple {
public:
    int a;
};

class Complex {
public:
    int a, b, c;
    void method1() {}
    void method2() {}
};
```

2. Compara los tamaños:

```cpp
std::cout << "Tamaño de Simple: " << sizeof(Simple) << " bytes" << std::endl;
std::cout << "Tamaño de Complex: " << sizeof(Complex) << " bytes" << std::endl;
```

3. Agregar datos estáticos y dinámicos:

```cpp
class StaticData {
public:
    static int s;
    int a;
};

int StaticData::s = 0;

class DynamicData {
public:
    int* ptr;
    DynamicData() {
        ptr = new int[10];
    }
    ~DynamicData() {
        delete[] ptr;
    }
};
```
### - ¿Cómo afectan los datos estáticos al tamaño de la instancia?

**No lo afectan.**  
Las variables **estáticas** pertenecen **a la clase, no a cada objeto**, por lo tanto:

- Solo hay **una copia compartida** de la variable estática en toda la aplicación.
- **No se almacenan dentro del objeto**, así que no cuentan en el `sizeof(objeto)`.

Solo `valor` ocupa espacio en la instancia. `contador` vive aparte, en la **zona de memoria global o estática**.


### - ¿Qué diferencias hay entre datos estáticos y dinámicos en términos de memoria?

| Característica            | Variable Estática                  | Variable Dinámica                         |
|--------------------------|------------------------------------|-------------------------------------------|
| ¿Dónde se guarda?         | En la **zona estática** (global)   | En el **heap**                            |
| ¿Pertenece a...?          | A la **clase**                     | A una **instancia** (vía puntero)         |
| ¿Incluida en sizeof()?    | **No**                             | **Solo el puntero**                       |
| ¿Quién la gestiona?       | El sistema                         | **Tú debes liberar con `delete`**         |
| ¿Cuántas copias existen?  | Solo **una**                       | Una por **cada new**                      |


### - Explícame cómo el uso de variables estáticas y dinámicas en una clase afecta el tamaño de sus instancias. ¿Las variables estáticas ocupan espacio en cada objeto?

Las **variables estáticas** pertenecen a la clase y **no se almacenan dentro de cada objeto**, por lo tanto, **no afectan el tamaño de las instancias**. Solo existe una copia compartida de la variable estática, que vive en la **zona de datos estática** del programa.

Las **variables dinámicas**, en cambio, implican el uso de punteros. El puntero sí forma parte del objeto y ocupa espacio (por ejemplo, 8 bytes en sistemas de 64 bits). Sin embargo, **los datos reales que apunta el puntero viven en el heap**, y su tamaño no se refleja directamente en `sizeof()`.

**En resumen:**
- Las variables estáticas **no afectan** el tamaño del objeto.
- Las dinámicas lo afectan **indirectamente**, solo con el espacio del puntero.

---
