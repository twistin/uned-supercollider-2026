# Fichas de presentación — Cursos de Extensión Universitaria UNED Vigo

---

## MÓDULO 1

# Componer con código
### Introducción a la música algorítmica con SuperCollider

---

### ¿De qué va este curso?

Imagina poder escribir una línea de código y obtener un acorde. Otra línea y ese acorde cambia de tonalidad. Otra más y el ritmo se reorganiza solo. Eso es exactamente lo que vas a aprender a hacer.

**SuperCollider** es un entorno de programación libre y gratuito que permite crear música directamente desde el código. Lo usan compositores, productores, investigadores y músicos de todo el mundo para generar sonido de formas que ningún secuenciador convencional permite. También es la base técnica del **live coding**, una práctica en la que la composición y la ejecución musical ocurren al mismo tiempo, en directo, delante del público.

Este curso es tu punto de entrada. No necesitas saber programar. Necesitas curiosidad y ganas de explorar.

---

### ¿Qué vas a poder hacer al terminar?

Al finalizar el curso serás capaz de:

- Producir tu primer sonido con código en los primeros cinco minutos de clase
- Entender cómo funciona SuperCollider y navegar su entorno con soltura
- Generar colecciones de notas, ritmos y parámetros musicales de forma algorítmica
- Escribir funciones reutilizables que produzcan material musical variado
- Controlar la aleatoriedad para obtener resultados musicalmente coherentes
- Diseñar sonidos básicos con osciladores, envolventes y modulaciones
- Combinar todo lo anterior en un pequeño patch sonoro funcional

---

### ¿Para quién es este curso?

Este curso está pensado para:

- **Músicos y compositores** curiosos por la tecnología y la composición algorítmica
- **Productores y creadores sonoros** que quieren explorar más allá de los DAW convencionales
- **Docentes de música** interesados en nuevas herramientas para el aula
- **Cualquier persona** con interés por la intersección entre música y programación

**No se requieren conocimientos previos de programación.** Sí se recomienda tener alguna relación con la música (tocar un instrumento, producir, componer o simplemente escuchar con atención).

---

### Contenidos

**Sesión 1 — El entorno y el lenguaje** *(2 horas)*
El ecosistema SuperCollider: IDE, intérprete y servidor de audio. Sintaxis básica. Variables y tipos de datos. El sistema de ayuda y documentación.

**Sesión 2 — Generar material musical** *(2 horas)*
Arrays como contenedores de notas y ritmos. Funciones reutilizables y parametrizables. Aleatoriedad controlada. Iteración con `do` y `collect`. Construcción en directo de `~makeNotes`: una función que genera acordes en cualquier tonalidad.

**Sesión 3 — El servidor de audio y los UGens** *(2 horas)*
Del lenguaje al sonido. Osciladores, ruido y filtros. Tasas de señal. Control en tiempo real con argumentos. Envolventes básicas. Herramientas visuales: Scope, FreqScope, Meter.

---

### Metodología

Las sesiones combinan **demostración en directo**, **práctica guiada con código** y **experimentación individual**. El ritmo se adapta al grupo.

Cada sesión incluye un handout con el contenido esencial, ejemplos ejecutables y ejercicios para trabajar de forma autónoma entre clases.

---

### Modalidad y duración

- **Formato:** online (Microsoft Teams) o presencial
- **Duración:** 6 horas (3 sesiones de 2 horas)
- **Software:** SuperCollider (libre, gratuito, multiplataforma — Mac, Windows, Linux)

---

### ¿Quieres continuar?

Este módulo es la base del **Módulo 2: Música en tiempo real**, donde profundizaremos en la definición formal de instrumentos, la secuenciación con Patterns y el live coding.

---
---

## MÓDULO 2

# Música en tiempo real
### Síntesis, Patterns y live coding con SuperCollider

> *Prerequisito recomendado: Módulo 1 o conocimientos básicos de SuperCollider*

---

### ¿De qué va este curso?

Si en el Módulo 1 aprendiste a generar material musical con código, aquí aprendes a **organizarlo en el tiempo, convertirlo en instrumentos y ejecutarlo en directo**.

El **live coding** es una práctica musical en la que el código es el instrumento: escribes, modificas y ejecutas mientras suena. No hay partitura. No hay "toma". Solo código, sonido y decisiones en tiempo real. Comunidades como [TOPLAP](https://toplap.org/) y festivales como **Algorave** llevan más de veinte años explorando estas posibilidades en todo el mundo.

En este módulo recorreremos el camino completo: desde definir un instrumento formal hasta improvisarlo en directo.

---

### ¿Qué vas a poder hacer al terminar?

Al finalizar el curso serás capaz de:

- Definir instrumentos formales con `SynthDef` y controlar sus parámetros
- Comprender la diferencia entre el lenguaje y el servidor de audio en profundidad
- Secuenciar eventos musicales complejos con el sistema de Patterns (`Pbind`, `Pseq`, `Prand`...)
- Sincronizar múltiples procesos a un tempo usando `TempoClock`
- Modificar sonido en tiempo real usando `NodeProxy` y `Ndef`
- Realizar una sesión de live coding básica: empezar en silencio, construir capas, terminar en silencio

---

### ¿Para quién es este curso?

Este curso está pensado para:

- Personas que han completado el **Módulo 1** de este curso
- Músicos o programadores con conocimientos básicos de SuperCollider adquiridos por su cuenta
- Compositores interesados en la notación algorítmica y la música generativa
- Creadores que quieren acercarse al live coding de forma práctica

---

### Contenidos

**Sesión 4 — Instrumentos con SynthDef** *(2 horas)*
De `Function.play` a `SynthDef` y `Synth`. Argumentos tipados. Control preciso de parámetros. `doneAction` y gestión del ciclo de vida de los synths. Buenas prácticas.

**Sesión 5 — Secuenciación con Patterns** *(2 horas)*
`Pbind` como interfaz musical. `Pseq`, `Prand`, `Pxrand`, `Pseries`. `TempoClock` y gestión del tempo. Ritmos, dinámicas y estructuras temporales complejas.

**Sesión 6 — Live coding y proyecto final** *(2 horas)*
`NodeProxy` y `Ndef`: sonido que se puede reescribir en tiempo real. Filosofía del live coding. Sesión práctica en directo. Presentación de un proyecto o propuesta propia.

---

### Metodología

Las sesiones combinan **demostración en directo**, **práctica guiada** y **tiempo de improvisación libre** — especialmente en la sesión final. La última sesión incluye una pequeña propuesta personal de cada participante.

---

### Modalidad y duración

- **Formato:** online (Microsoft Teams) o presencial
- **Duración:** 6 horas (3 sesiones de 2 horas)
- **Software:** SuperCollider (libre, gratuito, multiplataforma — Mac, Windows, Linux)

---

### Referencia académica

Este curso toma como referencia metodológica programas universitarios internacionales de composición algorítmica, incluyendo *MUS 499C: Introduction to Audio Coding with SuperCollider* (University of Illinois at Urbana-Champaign), adaptando sus contenidos a un formato accesible e intensivo.

---

*Curso impartido por Silvino Carrasco — Aula UNED Vigo*
*SuperCollider es software libre (GPL). No requiere ninguna compra.*
