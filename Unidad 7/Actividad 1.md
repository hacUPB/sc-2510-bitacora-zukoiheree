**Actividad 1**
---
### **1. ¿Qué son los vértices?**

Los **vértices** son puntos en el espacio 3D que definen la forma de una geometría. Cada triángulo se compone de tres vértices. Un vértice también puede contener información adicional como color, coordenadas de textura o normales.

---

### **2. ¿Con qué figura geométrica se dibuja en 3D?**

La figura geométrica básica que usa la GPU para representar cualquier forma 3D es el **triángulo**. Las superficies curvas o complejas se aproximan usando muchos triángulos.

---

### **3. ¿Qué es un shader?**

Un **shader** es un pequeño programa que corre en la GPU. Sirve para controlar cómo se procesan los vértices y cómo se colorean los píxeles. Los dos tipos principales son: `vertex shader` y `fragment shader`.

---

### **4. ¿Cómo se les llama a los grupos de píxeles de un mismo triángulo?**

Se llaman **fragmentos**. Cada fragmento es un candidato a convertirse en un píxel final en pantalla, dependiendo del resultado del `fragment shader`.

---

### **5. ¿Qué es un fragment shader?**

Es un shader que se ejecuta por **cada fragmento**. Decide el color, la iluminación, la transparencia y otros efectos visuales de cada parte del triángulo que aparece en pantalla.

---

### **6. ¿Qué es un vertex shader?**

Es un shader que se ejecuta por **cada vértice**. Su función principal es transformar la posición del vértice desde el espacio del mundo 3D hasta el espacio de pantalla.

---

### **7. ¿Al proceso de determinar qué píxeles del display va a cubrir cada triángulo de una mesh se le llama?**

Este proceso se llama **rasterización**. Convierte geometría (triángulos) en fragmentos/píxeles.

---

### **8. ¿Qué es el render pipeline?**

Es la cadena de pasos por los que pasan los datos gráficos para convertirse en una imagen en pantalla. Incluye: entrada de vértices, transformación, rasterización, sombreado, y escritura en el framebuffer.

---

### **9. ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?**

Sí. Un **color** es un valor fijo por vértice o fragmento, mientras que una **textura** es una imagen que se “pega” sobre la superficie usando coordenadas UV.

---

### **10. ¿Cuál es la diferencia entre una textura y un material?**

* Una **textura** es una imagen usada como mapa (color, brillo, normales, etc.).
* Un **material** es una combinación de propiedades visuales (como textura, brillo, rugosidad, reflexión) que define cómo interactúa una superficie con la luz.

---

### **11. ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?**

* **World Transform** (posición del objeto en el mundo)
* **View Transform** (posición de la cámara)
* **Projection Transform** (perspectiva)
* **Viewport Transform** (adaptación a resolución de pantalla)

---

### **12. ¿Al proceso de convertir los triángulos en fragmentos se le llama?**

**Rasterización**.

---

### **13. ¿Qué es el framebuffer?**

Es la memoria de la GPU donde se almacenan temporalmente los píxeles que serán mostrados en pantalla. Puede incluir color, profundidad (Z-buffer), y otros datos.

---

### **14. ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?**

Para determinar qué fragmento está más cerca de la cámara. Permite que los objetos más cercanos oculten a los más lejanos correctamente.

---

### **15. ¿Por qué la GPU tiene que funcionar tan rápido y de manera paralela?**

Porque cada fotograma contiene **millones de vértices y fragmentos**, y deben calcularse **60 veces por segundo** o más. La GPU tiene miles de núcleos que procesan **en paralelo** para realizar estos cálculos simultáneamente y lograr una animación fluida.


