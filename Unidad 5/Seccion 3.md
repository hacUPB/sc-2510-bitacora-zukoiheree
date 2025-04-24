Sesión 3: implementación Interna de Encapsulamiento, Herencia y Polimorfismo
---
### Profundizando en el Encapsulamiento

El **encapsulamiento** es un concepto clave en la programación orientada a objetos (OOP) que asegura que los datos de una clase estén protegidos y solo sean accesibles de manera controlada. En C++, esto se implementa mediante los **modificadores de acceso**: `private`, `protected` y `public`.

#### Modificadores de acceso:
- **`private`**: Los miembros privados solo son accesibles dentro de la misma clase.
- **`protected`**: Los miembros protegidos son accesibles dentro de la misma clase y en clases derivadas.
- **`public`**: Los miembros públicos son accesibles desde cualquier parte del programa.

```cpp
class AccessControl {
private:
    int privateVar;   // Solo accesible dentro de la clase
protected:
    int protectedVar; // Accesible dentro de la clase y clases derivadas
public:
    int publicVar;    // Accesible desde cualquier parte del programa
    AccessControl() : privateVar(1), protectedVar(2), publicVar(3) {}
};
```
#### Explicación del Código:
- `privateVar`: Solo puede ser accedido desde dentro de la clase `AccessControl`.
- `protectedVar`: Puede ser accedido desde dentro de `AccessControl` o por clases derivadas.
- `publicVar`: Puede ser accedido desde cualquier parte del código.

### Intentar Acceder a los Miembros desde una Función Externa

```cpp
int main() {
    AccessControl ac;
    ac.publicVar = 10; // Válido, ya que publicVar es público
    // ac.protectedVar = 20; // Error de compilación, no accesible desde fuera de la clase y sin herencia
    // ac.privateVar = 30; // Error de compilación, no accesible fuera de la clase
    return 0;
}
```
- **`ac.publicVar = 10;`**: Válido, ya que `publicVar` es un miembro público.
- **`ac.protectedVar = 20;`**: Error de compilación, ya que `protectedVar` está protegido y no puede ser accedido directamente desde fuera de la clase (excepto en clases derivadas).
- **`ac.privateVar = 30;`**: Error de compilación, ya que `privateVar` es privado y solo accesible dentro de la clase `AccessControl`.

El encapsulamiento no es solo una cuestión de seguridad o restricción de acceso; también ayuda a modularizar el código y reducir la complejidad. Al usar modificadores de acceso correctamente, podemos evitar que se accedan o modifiquen datos críticos accidentalmente desde fuera de la clase.

### Reflexión:

1. **Encapsulamiento**: Es un principio de OOP que oculta los detalles internos de una clase y expone solo lo necesario, protegiendo el estado del objeto y facilitando el mantenimiento.

2. **Protección de datos**: Es importante para garantizar la integridad de los datos, evitar modificaciones erróneas y reducir la complejidad del código.

3. **reinterpret_cast**: Permite reinterpretar la dirección de un objeto como otro tipo de dato, lo que puede violar la seguridad del programa al permitir el acceso no autorizado a la memoria.

4. **Acceso a miembros privados**: Técnicas de bajo nivel como `reinterpret_cast` pueden eludir las restricciones de acceso del compilador, permitiendo acceder a datos privados directamente.

5. **Consecuencias**: El uso de estas técnicas puede causar errores difíciles de detectar, corrupción de datos, vulnerabilidades de seguridad y reducir la mantenibilidad del código.

6. **Implicaciones**: Aunque C++ proporciona encapsulamiento, técnicas avanzadas de bajo nivel pueden violarlo. Esto resalta la necesidad de usar controles adicionales para mantener la seguridad en sistemas críticos.

---
### **Herencia y la Relación en Memoria**

En C++, cuando creas un objeto de una clase derivada, la memoria para ese objeto se organiza de manera que los atributos de la clase base se almacenan antes que los de la clase derivada. Esta organización es importante para garantizar que las clases derivadas puedan acceder a los datos de sus clases base correctamente.

- **Atributos de la clase base**: Cuando un objeto de una clase derivada se crea, la memoria para los atributos de la clase base se asigna primero, antes de que se asignen los atributos específicos de la clase derivada. Esto asegura que la clase derivada tenga acceso a los datos de la clase base.
- **Atributos de la clase derivada**: Los atributos específicos de la clase derivada se colocan inmediatamente después de los atributos de la clase base en memoria.


### Explicación Detallada:

1. **Memoria para un objeto derivado**: En memoria, un objeto de una clase derivada comienza con los atributos de la clase base. Esto significa que cuando creamos un objeto de la clase `Derived`, en realidad, se crea un bloque de memoria que contiene tanto los atributos de la clase `Base` como los de la clase `Derived`.

   - Los **atributos de la clase base** son lo primero que se asigna, ya que la clase derivada hereda de la base y necesita acceder a esos atributos.
   - Los **atributos de la clase derivada** se almacenan después de los atributos de la clase base.

2. **Direcciones de memoria**:
   - La dirección de memoria de la clase derivada (`d`) muestra la ubicación completa del objeto, que incluye tanto los atributos de la clase base como los de la clase derivada.
   - La dirección de `d.baseVar` será anterior a la de `d.derivedVar` debido a que la memoria de la clase base es asignada primero en el layout de memoria.

### ¿Qué sucede si agregamos más niveles de herencia?

Si añades más niveles de herencia, la memoria se organizará de manera similar:

- **Clases base**: Los atributos de las clases base se almacenan de manera secuencial antes de los de las clases derivadas. 
- **Clases derivadas**: Los atributos de cada clase derivada se almacenan inmediatamente después de los atributos de la clase base de la que derivan.

### Ejemplo con más niveles de herencia:

```cpp
class A {
public:
    int varA;
};

class B : public A {
public:
    int varB;
};

class C : public B {
public:
    int varC;
};

int main() {
    C obj;
    std::cout << "Dirección de obj: " << &obj << std::endl;
    std::cout << "Dirección de obj.varA: " << &(obj.varA) << std::endl;
    std::cout << "Dirección de obj.varB: " << &(obj.varB) << std::endl;
    std::cout << "Dirección de obj.varC: " << &(obj.varC) << std::endl;
    return 0;
}
```
- La dirección de `obj.varA` será la más baja, seguida por `obj.varB` y luego `obj.varC`.

---
### **Polimorfismo y Vtables en detalle**

El **polimorfismo** en C++ permite que una misma interfaz se utilice para diferentes tipos de objetos. Esto se logra utilizando **métodos virtuales** y las **vtables** (tablas de funciones virtuales), que son estructuras que almacenan las direcciones de los métodos virtuales de una clase.

#### Cómo funciona:
1. **Jerarquía de clases:**
   - Se crea una clase base con métodos virtuales, y clases derivadas que sobrescriben esos métodos.
   
2. **Punteros de clase base:**
   - Un puntero de tipo base (`Animal*`) puede apuntar a objetos de clases derivadas (`Dog`, `Cat`).
   
3. **Vtable:**
   - El compilador crea una vtable para cada clase con métodos virtuales, que contiene direcciones a los métodos correspondientes. En tiempo de ejecución, se consulta la vtable para llamar al método adecuado según el tipo real del objeto.

#### Impacto en el rendimiento:
- El **acceso a la vtable** añade una ligera penalización en el rendimiento, ya que requiere una indirection para resolver las llamadas a los métodos virtuales.
- Los objetos con polimorfismo tienen un **puntero adicional a la vtable**, lo que aumenta su tamaño ligeramente.

---
### **Reflexión Individual**

#### Implementación Interna:
- **Encapsulamiento**: El compilador utiliza modificadores de acceso para restringir el acceso a los miembros privados. Aunque los miembros privados ocupan memoria, no se pueden acceder directamente desde fuera de la clase.
- **Herencia**: Los objetos derivados almacenan primero los atributos de la clase base, seguidos de los atributos de la clase derivada. Las vtables se utilizan para resolver métodos virtuales de manera dinámica.
- **Polimorfismo**: Se resuelve mediante vtables, donde las llamadas a métodos virtuales se dirigen a la función correcta según el tipo real del objeto.

#### Análisis de Ventajas y Desventajas:
- **Ventajas**: 
  - **Encapsulamiento**: Protege los datos y facilita el mantenimiento.
  - **Herencia**: Permite reutilizar código y crear jerarquías.
  - **Polimorfismo**: Facilita la flexibilidad y extensibilidad del código.
- **Desventajas**: 
  - **Eficiencia**: Uso de vtables y métodos virtuales puede afectar el rendimiento.
  - **Complejidad**: La herencia y el polimorfismo pueden hacer el código más complejo y difícil de mantener.

#### Conclusión:
Estos mecanismos mejoran la organización y flexibilidad del código, pero conllevan costos en términos de rendimiento y complejidad, que deben ser manejados con cuidado.

