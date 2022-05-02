# Ejercicio

## 02 - Código Repetido

---
**Alumnos:** Rocio Platini y Martin Ugarte

**Materia:** Algoritmos y Programación III

## Abstracción de los tests 01 y 02

>En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

**RTA:** Para solucionar el código repetido de los test 01 y 02 creamos un método nuevo en CustomerBookTest cuya
implementación se asemeja a un cronómetro, que cuenta la duración que tarda en ejecutarse una determinada acción.

## Cómo representar en Smalltalk

> ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

**RTA:** Para representar entes de la realidad en Smalltalk se pueden utilizar las clases, cuyos métodos están asociados a su comportamiento y cada instancia de la misma representa cada ente del dominio.

## Teoría de Naur

> ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

**RTA:**: Naur menciona que en la Visión de Construcción de Teoría de la programación, la calidad de teoría construida por el programador depende de que el programador esté familiarizado con las soluciones modelo a problemas típicos, con técnicas de descripción y verificación, y con principios de estructuración de sistemas formados por muchas partes en interacciones complicadas. Esto lo podemos relacionar con que al quitar código repetido, es posible modularizar mejor nuestro programa dando lugar a que la interacción entre partes del sistema sea más entendible y facil de modificar. Asimismo, las partes representan algo único del dominio y no repiten entre si comportamiento innecesariamente.