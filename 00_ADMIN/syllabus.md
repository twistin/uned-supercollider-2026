# Syllabus — Cursos de Extensión Universitaria UNED Vigo

## SuperCollider: música algorítmica y live coding

*Dos módulos independientes de 6 horas*
*(Inspirado metodológicamente en MUS 499C — University of Illinois at Urbana-Champaign)*

---

## Módulo 1 — Componer con código
### Introducción a la música algorítmica con SuperCollider

---

### Descripción

Introducción práctica a la creación musical mediante programación con **SuperCollider**, un entorno libre y de código abierto para síntesis de audio en tiempo real y composición algorítmica.

El curso está diseñado para **personas sin experiencia previa en programación**. El enfoque es exploratorio y orientado a la práctica: desde la primera sesión el alumno produce sonido con código.

---

### Objetivos

Al finalizar el módulo, el alumnado será capaz de:

1. Navegar el entorno SuperCollider (IDE, intérprete, servidor de audio)
2. Escribir y evaluar expresiones en el lenguaje de SuperCollider
3. Crear y manipular arrays como contenedores de material musical
4. Construir funciones reutilizables con argumentos y valores por defecto
5. Usar aleatoriedad controlada para generar material musical variado
6. Producir sonidos básicos con osciladores y generadores de ruido
7. Controlar la dinámica mediante envolventes

---

### Contenidos

| Sesión | Título | Contenido principal |
|--------|--------|---------------------|
| 1 (2h) | El entorno y el lenguaje | IDE · intérprete · servidor · sintaxis · variables · tipos de datos · ayuda |
| 2 (2h) | Generar material musical | Arrays · funciones · aleatoriedad · iteración · `makeNotes` |
| 3 (2h) | El servidor de audio y los UGens | Osciladores · ruido · tasas de señal · argumentos · `set` · envolventes |

---

### Metodología

- Demostración en directo con código ejecutable
- Práctica guiada individual y colectiva
- Handout por sesión con conceptos, ejemplos y ejercicios
- Experimentación libre al final de cada sesión

No se requieren conocimientos previos de programación. El ritmo se adapta al grupo.

---

### Evaluación / Seguimiento

Al tratarse de un curso de extensión universitaria, **no se contempla evaluación calificada**. El seguimiento se realiza mediante:

- Participación activa en sesiones
- Realización de ejercicios propuestos por sesión
- Propuesta personal libre al cierre del módulo

---

### Recursos

- SuperCollider (software libre, gratuito, multiplataforma)
- Materiales proporcionados por sesión (handout + código)
- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- [Comunidad TOPLAP — Live Coding](https://toplap.org/)
- [SC Forum](https://scsynth.org/)

---
---

## Módulo 2 — Música en tiempo real
### Síntesis, Patterns y live coding con SuperCollider

*Prerequisito recomendado: Módulo 1 o conocimientos básicos equivalentes de SuperCollider*

---

### Descripción

Continuación del Módulo 1. Se profundiza en la definición formal de instrumentos (`SynthDef`), la secuenciación algorítmica con el sistema de Patterns y la práctica del **live coding**: composición y ejecución musical en tiempo real mediante código.

---

### Objetivos

Al finalizar el módulo, el alumnado será capaz de:

1. Definir instrumentos formales con `SynthDef` y dispararlos con `Synth`
2. Controlar parámetros en tiempo real mediante argumentos tipados
3. Secuenciar eventos musicales con `Pbind`, `Pseq`, `Prand` y otros Patterns
4. Sincronizar procesos a un tempo usando `TempoClock`
5. Modificar sonido en tiempo real con `NodeProxy` y `Ndef`
6. Realizar una sesión básica de live coding

---

### Contenidos

| Sesión | Título | Contenido principal |
|--------|--------|---------------------|
| 4 (2h) | Instrumentos con SynthDef | `SynthDef` · `Synth` · argumentos tipados · `doneAction` · buenas prácticas |
| 5 (2h) | Secuenciación con Patterns | `Pbind` · `Pseq` · `Prand` · `TempoClock` · ritmo y dinámica algorítmica |
| 6 (2h) | Live coding y proyecto | `NodeProxy` · `Ndef` · filosofía del live coding · sesión práctica en directo |

---

### Metodología

Idéntica al Módulo 1, con mayor peso de la experimentación libre. La última sesión incluye una propuesta personal de cada participante: puede ser una pieza, un patch, una demostración o una propuesta pedagógica.

---

### Evaluación / Seguimiento

Mismo sistema que el Módulo 1. La sesión 6 incluye una **presentación breve** del trabajo personal de cada alumno.

---

### Recursos

Los mismos que el Módulo 1, más:

- Cheatsheets de UGens, Patterns y Envelopes (en los materiales del curso)
- Referencias a la práctica internacional de live coding (TOPLAP, Algorave)

---

## Relación con referentes académicos internacionales

Estos cursos toman como referencia metodológica el programa **MUS 499C: Introduction to Audio Coding with SuperCollider** (University of Illinois at Urbana-Champaign), adaptando su filosofía a un formato intensivo, accesible y orientado a la práctica creativa y docente.

---

*Silvino Carrasco — Aula UNED Vigo — 2026-27*