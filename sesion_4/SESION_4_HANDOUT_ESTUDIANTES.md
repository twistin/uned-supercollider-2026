# SuperCollider — Módulo 2, Sesión 4: Instrumentos con SynthDef
## De Function.play a instrumentos formales

> **Módulo 2 — Música en tiempo real: síntesis, Patterns y live coding con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Entender qué hace `Function.play` internamente y por qué `SynthDef` es mejor
- ✅ Definir instrumentos con `SynthDef` y crear instancias con `Synth`
- ✅ Controlar parámetros en tiempo real con argumentos tipados
- ✅ Gestionar el ciclo de vida de un synth con `doneAction`, `.free` y `.release`
- ✅ Diseñar envolventes percusivas, re-triggerables y sostenidas (ADSR)
- ✅ Aplicar buenas prácticas: salida estéreo, `Out.ar`, organización del código

---

## 📚 Estructura de la Sesión

### 1. De Function.play a SynthDef — 20 min
### 2. Argumentos tipados y control en tiempo real — 20 min
### 3. Ciclo de vida de un Synth — 15 min
### 4. Envolventes avanzadas — 25 min *(percusiva, re-triggerable, ADSR)*
### 5. Buenas prácticas y ejercicios — 20 min

---

# 1. De `Function.play` a `SynthDef`

## 1.1 ¿Qué hace `Function.play` realmente?

En el Módulo 1 usamos mucho esta forma:

```supercollider
{ SinOsc.ar(440) * 0.1 }.play;
```

Esto funciona, pero es un **atajo**. Internamente, SuperCollider está haciendo todo esto sin que lo veas:

1. Crear un `SynthDef` temporal con nombre aleatorio
2. Enviarlo al servidor
3. Crear un `Synth` (instancia del instrumento)
4. Añadir una envolvente automática de fade-in y fade-out

### El problema del atajo

- No puedes **reutilizar** el instrumento fácilmente
- No puedes crear **múltiples instancias** independientes
- No puedes **sincronizarlo** con otros procesos de forma precisa
- El código queda **acoplado** a la definición

## 1.2 La forma explícita: `SynthDef`

```supercollider
// 1. DEFINIR el instrumento (se envía al servidor)
SynthDef(\tono, {
    var sig;
    sig = SinOsc.ar(440) * 0.1;
    Out.ar(0, sig ! 2);    // salida estéreo por canales 0 y 1
}).add;

// 2. CREAR una instancia (suena)
x = Synth(\tono);

// 3. LIBERAR la instancia (para el sonido)
x.free;
```

> `Out.ar(bus, señal)` — envía la señal al bus de salida. `0` es el canal izquierdo.
> `sig ! 2` — duplica la señal a estéreo (equivalente a `[sig, sig]`).

---

# 2. Argumentos tipados y control en tiempo real

## 2.1 Argumentos dentro de SynthDef

```supercollider
SynthDef(\tono, {
    arg freq = 440, amp = 0.1;
    var sig;
    sig = SinOsc.ar(freq) * amp;
    Out.ar(0, sig ! 2);
}).add;

// Crear con parámetros iniciales
x = Synth(\tono, [\freq, 660, \amp, 0.05]);

// Modificar en tiempo real
x.set(\freq, 880);
x.set(\amp, 0.2);
x.set(\freq, 330, \amp, 0.15);   // varios a la vez

x.free;
```

## 2.2 Argumentos tipados (forma recomendada)

La forma moderna y más flexible usa `\nombre.kr(valorDefecto)`:

```supercollider
SynthDef(\tono, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var pan   = \pan.kr(0);
    var sig;

    sig = SinOsc.ar(freq) * amp;
    sig = Pan2.ar(sig, pan);     // panorámica estéreo
    Out.ar(0, sig);
}).add;
```

**Ventajas sobre `arg`:**
- Permite expresiones matemáticas como valor por defecto
- Especifica la tasa explícitamente (`.kr`, `.ar`, `.ir`, `.tr`)
- Más legible en SynthDefs complejos

## 2.3 Transiciones suaves con `lag`

```supercollider
SynthDef(\tonoCon Lag, {
    var freq  = \freq.kr(440).lag(1);   // 1 segundo de glissando
    var amp   = \amp.kr(0.1).lag(0.1);
    var sig;
    sig = SinOsc.ar(freq) * amp;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\tonoConLag);
x.set(\freq, 880);    // glissando suave hacia 880 Hz
x.set(\freq, 220);    // y de vuelta hacia 220 Hz
x.free;
```

---

# 3. Ciclo de vida de un Synth

## 3.1 `doneAction` — liberar el synth al terminar

Sin `doneAction`, un synth con envolvente sigue consumiendo CPU aunque esté en silencio:

```supercollider
SynthDef(\percusion, {
    var env, sig;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);  // ← libera al terminar
    sig = SinOsc.ar(440) * env * 0.3;
    Out.ar(0, sig ! 2);
}).add;

Synth(\percusion);   // crea la instancia y se destruye sola al acabar
```

> `doneAction: 2` equivale a `doneAction: Done.freeSelf` — libera el nodo del servidor.

## 3.2 Liberar manualmente

```supercollider
x = Synth(\tono);

x.free;        // libera inmediatamente (puede causar click)
x.release;     // libera con fade-out si hay envolvente con gate
x.release(2);  // fade-out de 2 segundos
```

## 3.3 Ver los synths activos en el servidor

```supercollider
s.plotTree;    // árbol visual de todos los nodos activos
```

---

# 4. Envolventes avanzadas

## 4.1 Envolvente percusiva (ya conocida)

```supercollider
SynthDef(\perc, {
    var env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    var sig = SinOsc.ar(\freq.kr(440)) * env * 0.3;
    Out.ar(0, sig ! 2);
}).add;

Synth(\perc, [\freq, 440]);
Synth(\perc, [\freq, 660]);
Synth(\perc, [\freq, 880]);
```

## 4.2 Envolvente re-triggerable

Permite volver a disparar la envolvente sin destruir el synth:

```supercollider
SynthDef(\retriggerable, {
    var trig = \trig.tr(1);   // argumento tipo trigger
    var env  = EnvGen.kr(
        Env.perc(0.01, 0.5),
        trigger: trig,
        doneAction: 0   // NO liberar — el synth persiste
    );
    var sig = SinOsc.ar(\freq.kr(440)) * env * 0.3;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\retriggerable);

// Re-disparar sin crear un nuevo synth
x.set(\trig, 1);    // dispara la envolvente de nuevo
x.set(\freq, 660);
x.set(\trig, 1);    // vuelve a disparar

x.free;
```

> Los argumentos `.tr` (trigger) se activan un ciclo y vuelven a cero solos — perfectos para re-triggers.

## 4.3 Envolvente ADSR (sostenida con gate)

```supercollider
SynthDef(\adsr, {
    var gate = \gate.kr(1);   // 1 = sostenido, 0 = release
    var env  = EnvGen.kr(
        Env.adsr(0.1, 0.2, 0.7, 0.5),
        gate: gate,
        doneAction: 2
    );
    var sig = SinOsc.ar(\freq.kr(440)) * env * 0.3;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\adsr);        // empieza ataque/decay/sustain
x.set(\gate, 0);         // inicia el release
```

---

# 5. Buenas prácticas

## Plantilla recomendada para SynthDef

```supercollider
SynthDef(\nombreInstrumento, {

    // 1. Argumentos
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var pan   = \pan.kr(0);
    var gate  = \gate.kr(1);

    // 2. Envolvente
    var env = EnvGen.kr(
        Env.adsr(0.01, 0.1, 0.8, 0.3),
        gate: gate,
        doneAction: 2
    );

    // 3. Señal
    var sig = SinOsc.ar(freq) * env * amp;

    // 4. Salida
    Out.ar(0, Pan2.ar(sig, pan));

}).add;
```

> Comenta siempre las cuatro secciones: argumentos, envolvente, señal, salida.

---

# 6. Ejercicios

## Ejercicio 1: Primer SynthDef propio

Crea un `SynthDef(\miOscilador, ...)` que use `Saw.ar` en lugar de `SinOsc`. Añade un filtro paso bajo `RLPF` con frecuencia de corte controlable por argumento. Prueba a modificar el filtro en tiempo real con `.set`.

## Ejercicio 2: Batería básica

Define tres SynthDefs simples:
- `\kick` — seno descendente rápido (frecuencia baja que cae con EnvGen)
- `\snare` — mezcla de seno + ruido blanco con envolvente corta
- `\hihat` — ruido blanco con envolvente muy corta y filtro paso alto

Dispara los tres en secuencia manualmente.

## Ejercicio 3: Instrumento melódico

Crea un `SynthDef(\melodia, ...)` con envolvente ADSR. Crea 5 instancias con frecuencias diferentes del acorde de Do mayor (C4=60, E4=64, G4=67, B4=71, D5=74 en MIDI). Convierte MIDI a Hz con `.midicps`.

## Ejercicio 4: Control de panorámica

Toma cualquier SynthDef anterior y añade un argumento `\pan`. Crea 4 instancias con panorámica distribuida: -1, -0.5, 0.5, 1. Escucha el resultado en auriculares.

---

# 7. Próxima Sesión

En la **Sesión 5** conectaremos los instrumentos que hemos definido con el sistema de **Patterns**: la forma de organizar el tiempo y crear secuencias musicales complejas con muy poco código.

- `Routine` y `TempoClock`
- `Pbind` — el motor musical de SuperCollider
- `Pseq`, `Prand`, `Pxrand` y otros patterns esenciales

---

## 📝 Recursos

- [Documentación de SynthDef](https://doc.sccode.org/Classes/SynthDef.html)
- [Documentación de Synth](https://doc.sccode.org/Classes/Synth.html)
- Cheatsheet de UGens y Envelopes (en los materiales del curso)

---

**Un SynthDef es una receta. Un Synth es el plato.** 🎛️

*Módulo 2 · Sesión 4 de 3 — Música en tiempo real*
