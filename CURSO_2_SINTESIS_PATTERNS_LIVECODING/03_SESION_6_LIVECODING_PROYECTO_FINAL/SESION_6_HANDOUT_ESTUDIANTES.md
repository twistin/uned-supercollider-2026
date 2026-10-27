# SuperCollider — Módulo 2, Sesión 6: Live Coding y Proyecto Final
## Código que suena. Música que se escribe.

> **Módulo 2 — Música en tiempo real: síntesis, Patterns y live coding con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Explicar qué es el live coding y cuál es su historia y comunidad
- ✅ Usar `NodeProxy` y `Ndef` para modificar sonido en tiempo real
- ✅ Reescribir código mientras suena sin interrumpir la música
- ✅ Construir y deconstruir una sesión de live coding por capas
- ✅ Presentar una propuesta personal de proyecto creativo o pedagógico

---

## 📚 Estructura de la Sesión

### 1. ¿Qué es el live coding? — 15 min
### 2. NodeProxy y Ndef — 30 min *(núcleo técnico)*
### 3. Construir una sesión — 20 min *(práctica en directo)*
### 4. Proyecto final — presentaciones — 30 min
### 5. Cierre y recursos — 5 min

---

# 1. ¿Qué es el live coding?

## 1.1 Definición

El **live coding** es una práctica musical en la que el código es el instrumento: el músico escribe, modifica y ejecuta código en tiempo real, delante del público, mientras el sonido evoluciona.

No hay partitura fija. No hay "toma". El proceso es visible — en muchas actuaciones el código se proyecta en pantalla para que el público pueda seguirlo.

## 1.2 Historia breve

- **2000** — primeras prácticas sistemáticas en el ámbito académico y experimental
- **2004** — fundación de **TOPLAP** (*Temporary Organisation for the Promotion of Live Algorithm Programming*): el manifiesto del live coding
- **2012** — primer **Algorave**: concierto de música electrónica hecha íntegramente con live coding
- **Hoy** — comunidad global activa, festivales, foros, tutoriales

**Herramientas principales:** SuperCollider, TidalCycles, Sonic Pi, FoxDot, Hydra (vídeo)

> [toplap.org](https://toplap.org) — [algorave.com](https://algorave.com)

## 1.3 La filosofía del error

En Sonic Pi (y en la comunidad de live coding en general) se dice:

> **"No hay errores, solo oportunidades."**

El live coding normaliza el accidente: un error de código que produce un sonido inesperado puede convertirse en el momento más memorable de una actuación. La tolerancia al caos y la improvisación son parte del estilo.

---

# 2. NodeProxy y Ndef

Hasta ahora, para cambiar un sonido había que:
1. Detenerlo (`Cmd + .`)
2. Modificar el código
3. Volver a lanzarlo

Con `NodeProxy` / `Ndef`, el sonido **sigue sonando** mientras reescribes su contenido.

## 2.1 `Ndef` — la forma más concisa

```supercollider
// Arrancar el servidor primero
s.boot;

// Crear un NodeProxy y lanzarlo
Ndef(\x, { SinOsc.ar(440) * 0.1 }).play;

// Reemplazar el contenido SIN interrumpir
Ndef(\x, { Saw.ar(220) * 0.1 });

// Cambiar frecuencia
Ndef(\x, { Saw.ar(660) * 0.1 });

// Parar con fade-out
Ndef(\x).stop(2);    // fade-out de 2 segundos

// Liberar completamente
Ndef(\x).clear;
```

> Evalúa cada línea por separado. El sonido cambia sin interrupción.

## 2.2 `fadeTime` — transiciones suaves

```supercollider
Ndef(\x).fadeTime = 3;    // 3 segundos de transición entre fuentes

Ndef(\x, { SinOsc.ar(440) * 0.1 }).play;
Ndef(\x, { Saw.ar(660) * 0.15 });          // transición suave de 3s
Ndef(\x, { PinkNoise.ar * 0.05 });         // transición suave de 3s
```

## 2.3 Métodos esenciales

```supercollider
Ndef(\x).play;           // comenzar reproducción
Ndef(\x).stop;           // parar (con fadeTime)
Ndef(\x).stop(4);        // parar con fade de 4 segundos
Ndef(\x).set(\freq, 880); // modificar un argumento
Ndef(\x).release;        // liberar con envolvente
Ndef(\x).clear;          // destruir el proxy
```

## 2.4 Argumentos en Ndef

```supercollider
Ndef(\x, { |freq = 440, amp = 0.1|
    SinOsc.ar(freq) * amp
}).play;

// Modificar en tiempo real
Ndef(\x).set(\freq, 660);
Ndef(\x).set(\amp, 0.05);
Ndef(\x).set(\freq, 330, \amp, 0.2);
```

## 2.5 Ndef con Patterns

Un `Ndef` puede tener un `Pbind` como fuente — lo mejor de ambos mundos:

```supercollider
// Primero define el instrumento
SynthDef(\sinLead, {
    var freq = \freq.kr(440);
    var amp  = \amp.kr(0.1);
    var env  = EnvGen.kr(Env.perc(0.01, 0.3), doneAction: 2);
    Out.ar(0, SinOsc.ar(freq) * env * amp ! 2);
}).add;

// Luego usa Pbind como fuente del Ndef
Ndef(\melodia, Pbind(
    \instrument, \sinLead,
    \midinote,   Pseq([60, 62, 64, 67, 69], inf),
    \dur,        0.25
)).play;

// Reemplazar la melodía en tiempo real
Ndef(\melodia, Pbind(
    \instrument, \sinLead,
    \midinote,   Prand([60, 63, 65, 70, 72], inf),
    \dur,        Prand([0.125, 0.25, 0.5], inf)
));

Ndef(\melodia).stop;
```

## 2.6 Varias capas simultáneas

```supercollider
// Capa 1: pad armónico
Ndef(\pad, { SinOsc.ar([220, 330, 440]) * 0.05 }).play;

// Capa 2: melodía con Patterns
Ndef(\mel, Pbind(
    \instrument, \sinLead,
    \midinote,   Prand([60, 64, 67, 71], inf),
    \dur,        0.25
)).play;

// Capa 3: pulso rítmico
Ndef(\kick, Pbind(
    \instrument, \sinLead,
    \midinote,   36,
    \dur,        1
)).play;

// Silenciar y reactivar capas individualmente
Ndef(\pad).stop(2);
Ndef(\mel).stop;
Ndef(\kick).stop;
```

---

# 3. Construir una sesión de live coding

## 3.1 Estructura básica de una sesión

```
silencio → primera capa → segunda capa → tercera capa
    → modificaciones → deconstrucción → silencio
```

La propuesta de proyecto para esta sesión sigue exactamente este arco.

## 3.2 Tu «bolsa de trucos»

El live coding no se puede guionizar completamente, pero sí se puede **preparar**. Con el tiempo cada persona desarrolla su conjunto de herramientas favoritas:

- Patterns que suenan bien y se escriben rápido
- Combinaciones de UGens que dan resultados predecibles
- Nombres de SynthDef memorizados
- Secuencias de atajos de teclado fluidas

La práctica regular es la única manera de construir esta bolsa. Cinco minutos al día son más valiosos que dos horas una vez a la semana.

## 3.3 Estrategias prácticas

- **Empieza en silencio.** Carga tus SynthDefs y variables antes de lanzar nada.
- **Añade capas de una en una.** No intentes que todo suene a la vez desde el principio.
- **Escucha.** El oído decide, no los ojos.
- **No temas el error.** Si algo falla, `Cmd + .` y vuelves a empezar.
- **Termina en silencio.** Un final claro es tan importante como un inicio claro.

---

# 4. Proyecto Final

## Enunciado

Presenta una propuesta personal de **5 minutos** usando SuperCollider. Puede ser cualquiera de estas formas:

### Opción A — Sesión de live coding
- Empieza en silencio
- Construye al menos **dos capas simultáneas**
- Modifica algo en tiempo real (frecuencia, pattern, timbre...)
- Termina en silencio

### Opción B — Pieza o patch generativo
- Un sistema que funcione de forma autónoma o semiautónoma
- Presenta el código y explica las decisiones de diseño
- Demuestra al menos 2 minutos de funcionamiento

### Opción C — Propuesta pedagógica
- ¿Cómo usarías SuperCollider (o Sonic Pi) en un contexto educativo concreto?
- Presenta una actividad, un ejercicio o un proyecto de aula
- Incluye al menos un ejemplo de código que usarían los estudiantes

---

## Criterios orientativos

No hay evaluación calificada, pero estos criterios ayudan a orientar la propuesta:

| Criterio | Descripción |
|----------|-------------|
| **Funciona** | El código se ejecuta sin errores críticos |
| **Intención** | Hay una idea musical o pedagógica reconocible |
| **Uso del lenguaje** | Se usan herramientas del curso de forma apropiada |
| **Comunicación** | Se puede explicar qué hace el código en palabras sencillas |

> No importa la complejidad técnica — importa que haya una idea detrás.

---

# 5. Cierre del curso

## Lo que has aprendido

**Módulo 1:**
- El entorno de SuperCollider y su arquitectura
- El lenguaje: objetos, métodos, variables, tipos
- Arrays como contenedores de material musical
- Funciones reutilizables y aleatoriedad controlada
- Síntesis básica con UGens y envolventes

**Módulo 2:**
- Instrumentos formales con `SynthDef` y `Synth`
- Secuenciación con `Routine`, `TempoClock` y `Pbind`
- El sistema de Patterns para composición algorítmica
- Live coding con `NodeProxy` y `Ndef`

## Cómo seguir

SuperCollider es un instrumento. Como cualquier instrumento, mejoras con la práctica constante. Algunas sugerencias:

- **Practica 10-15 minutos al día.** Abre SC y prueba una cosa nueva.
- **Lee código de otros.** El SC Forum y GitHub están llenos de ejemplos.
- **Participa en la comunidad.** [scsynth.org](https://scsynth.org) y TOPLAP son muy accesibles.
- **Asiste a un Algorave** (o sigue uno en streaming). Ver live coding en directo lo cambia todo.

---

## 📝 Recursos para continuar

### Documentación y referencia
- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- [SC Forum — scsynth.org](https://scsynth.org/)
- [Repositorio de SC en GitHub](https://github.com/supercollider/supercollider)

### Libros
- *The SuperCollider Book* (MIT Press) — la referencia académica
- *Thor Magnusson – Sonic Writing* — contexto histórico y filosófico

### Vídeos y tutoriales
- [Eli Fieldsteel — SuperCollider Tutorials (YouTube)](https://www.youtube.com/user/elifieldsteel)
- [Tutorials de TOPLAP](https://toplap.org/resources/)
- [Algorave en YouTube y Twitch](https://algorave.com)

### Comunidades y eventos
- [TOPLAP](https://toplap.org) — la comunidad global del live coding
- [Algorave](https://algorave.com) — conciertos de live coding
- [Live Code Research Network](https://livecodenetwork.org/)

---

> *«En live coding no hay errores, solo oportunidades.»*
> — Comunidad Sonic Pi / TOPLAP

**Gracias por este curso. Sigue componiendo.** 🎧

*Módulo 2 · Sesión 6 de 3 — Música en tiempo real*

---

*Curso impartido por Silvino Carrasco — Aula UNED Vigo*
*SuperCollider es software libre (licencia GPL). Siempre lo será.*
