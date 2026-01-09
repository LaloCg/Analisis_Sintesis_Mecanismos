# Análisis Cinemático de Mecanismos con MATLAB

Este repositorio contiene una colección de scripts en **MATLAB** desarrollados para la asignatura de **Análisis y Síntesis de Mecanismos**. Los códigos implementan métodos algebraicos y vectoriales para resolver la posición, velocidad y aceleración de diversos mecanismos planos.

**Autor:** Eduardo Cano García  
**Herramienta:** MATLAB  
**Enfoque:** Cinemática de Máquinas

---

## 📄 Documentación y Reportes

Además de los códigos fuente, este repositorio incluye el archivo **`Documentos.zip`**.

Dentro de este archivo comprimido encontrarás los **reportes detallados de los problemas resueltos**, los cuales contienen:
* El planteamiento teórico y matemático de cada mecanismo.
* Diagramas cinemáticos y esquemas.
* La interpretación de las gráficas y resultados obtenidos con los scripts.

---

---

## 📂 Descripción de los Scripts

El repositorio está organizado por tipo de análisis y topología del mecanismo:

### 1. Análisis de Posición (Fundamentos)
Scripts dedicados a resolver la geometría del mecanismo para diferentes ángulos de entrada ($\theta_2$).
* **`Analisis_Pos_Alg.m`**: Resolución mediante el **Método Algebraico**. Utiliza ecuaciones trigonométricas cerradas (Ley de Cosenos/Senos) para determinar los ángulos de transmisión.
* **`Analisis_Pos_Vect.m`**: Resolución mediante el **Método de Lazos Vectoriales** (Números Complejos). Plantea ecuaciones de cierre de circuito ($R_1 + R_2 + R_3 + R_4 = 0$) y resuelve las incógnitas geométricas.

### 2. Mecanismos de Cuatro Barras (4R)
* **`Analisis_Vel_M4L.m`**: Análisis de velocidad para un mecanismo de cuatro barras (4-Bar Linkage).
  * *Entrada:* Longitudes de eslabones y velocidad angular de entrada ($\omega_2$).
  * *Salida:* Velocidades angulares de acoplador ($\omega_3$) y balancín ($\omega_4$).

### 3. Mecanismo Manivela-Corredera (Slider-Crank)
* **`Manivela_Corredera.m`**: Análisis cinemático general de un sistema manivela-biela-corredera céntrico.
* **`An_Cin_MCD.m`**: Análisis de un **Mecanismo Corredera Desplazada (Offset)**. Incluye el cálculo de variaciones cuando el eje de la corredera no está alineado con el pivote de la manivela (excentricidad).

### 4. Mecanismos Multilazo (Avanzado)
* **`Ex_M6L.m`**: Resolución de un **Mecanismo de 6 Barras** . Este script aborda la complejidad de resolver múltiples lazos vectoriales simultáneos o en cascada.

### 5. Ejercicios de la Tarea 6
Resolución de problemas específicos asignados en la Tarea 6 :
* **`T6_E1.m`**: Solución al Ejercicio 1.
* **`T6_E2.m`**: Solución al Ejercicio 2.
* **`T6_E3.m`**: Solución al Ejercicio 3.
* **`T6_E4.m`**: Solución al Ejercicio 4.

---
Eduardo Cano García | Universidad Autónoma Chapingo
