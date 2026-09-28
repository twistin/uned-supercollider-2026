# SuperCollider — Módulo 2, Sesión 5: Secuenciación con Patterns
## Routine, TempoClock y el sistema de Patterns

> **Módulo 2 — Música en tiempo real: síntesis, Patterns y live coding con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Crear secuencias temporales con `Routine` y `wait`
- ✅ Gestionar el tempo con `TempoClock` y cambiar BPM en tiempo real
- ✅ Sincronizar varios procesos con cuantización (`quant`)
- ✅ Usar `Pbind` como motor musical principal
- ✅ Aplicar los patterns más comunes: `Pseq`, `Prand`, `Pxrand`, `Pseries`
- ✅ Construir secuencias rítmicas y melódicas de complejidad creciente

---

## 📚 Estructura de la Sesión

### 1. Routine — secuenciación paso a paso — 25 min
### 2. TempoClock y cuantización — 15 min
### 3. De Routine a Patterns — 10 min
### 4. Pbind y los Value Patterns — 30 min *(núcleo de la sesión)*
### 5. Ejercicios — 20 min

---

# 1. Routine — secuenciación paso a paso

## 1.1 ¿Qué es una Routine?

Una `Routine` es una función que puede **pausarse y reanudarse**, recordando exactamente dónde se quedó. Esto permite espaciar eventos en el tiempo.

```supercollider
// Routine básica
r = Routine({
    "Primer evento".postln;
    1.wait;                    // espera 1 beat
    "Segundo evento".postln;
    2.wait;                    // espera 2 beats
    "Tercer evento".postln;
});

r.play;    // ejecuta automáticamente, respetando los tiempos
```

## 1.2 Routine con sonido

```supercollider
// Asegúrate de tener el SynthDef \perc del handout anterior cargado
(
r = Routine({
    inf.do {
        Synth(\perc, [\freq, [60, 64, 67, 72].choose.midicps]);
        0.5.wait;
    };
}).play;
)

r.stop;    // detener
```

> ⚠️ **Regla de oro:** si escribes `inf.do` o `loop`, **añade inmediatamente un `wait`**. Sin él, SuperCollider intentará crear infinitos synths y se bloqueará.

## 1.3 Routine en modo manual

Útil para depurar o controlar la secuencia paso a paso:

```supercollider
r = Routine({
    3.do { |i|
        i.postln;
        1.yield;    // yield devuelve el control (como wait, pero para modo manual)
    };
});

r.next;    // ejecuta hasta el primer yield → imprime 0
r.next;    // ejecuta hasta el siguiente → imprime 1
r.next;    // → imprime 2
r.next;    // → nil (la routine ha terminado)
```

## 1.4 Atajo: `.r`

```supercollider
// En lugar de Routine({ ... }), puedes escribir:
r = { 3.do { |i| i.postln; 1.wait } }.r;
r.play;
```

---

# 2. TempoClock y cuantización

## 2.1 TempoClock

Por defecto, 1 `wait` = 1 beat = 1 segundo (60 BPM). Cambia esto con `TempoClock`:

```supercollider
// Crear un clock a 120 BPM
t = TempoClock.new(120/60);   // beats por segundo, no por minuto

// Cambiar el tempo en tiempo real (mientras la música suena)
t.tempo = 90/60;   // 90 BPM
t.tempo = 140/60;  // 140 BPM

// Usar el clock en una routine
r = Routine({
    inf.do {
        Synth(\perc, [\freq, 440]);
        1.wait;
    };
}).play(t);   // ← pasa el clock como argumento
```

## 2.2 Cuantización

Sincroniza el inicio de una routine al próximo beat o compás:

```supercollider
// Empezar en el próximo beat
r.play(t, quant: 1);

// Empezar en el próximo compás de 4 beats
r.play(t, quant: 4);

// Empezar con medio beat de adelanto (pickup)
r.play(t, quant: [4, -0.5]);
```

## 2.3 Sincronizar varios procesos

```supercollider
t = TempoClock(120/60);

// Dos rutinas sincronizadas al mismo clock
r1 = Routine({
    inf.do { Synth(\perc, [\freq, 440]); 1.wait }
}).play(t, quant: 4);

r2 = Routine({
    inf.do { Synth(\perc, [\freq, 880]); 0.5.wait }
}).play(t, quant: 4);

// Detener ambas
r1.stop; r2.stop;
```

---

# 3. De Routine a Patterns

Una `Routine` con sonido puede volverse verbosa:

```supercollider
// Routine: muchas líneas para algo simple
Routine({
    [\do, \re, \mi, \fa].do { |nota|
        Synth(\perc, [\freq, nota.asMIDI.midicps]);
        0.5.wait;
    };
}).play;
```

Los **Patterns** expresan lo mismo con mucho menos código — y con más potencia:

```supercollider
// Pattern equivalente: 2 líneas
Pbind(
    \midinote, Pseq([60, 62, 64, 65], inf),
    \dur, 0.5
).play;
```

> Los Patterns son como una **partitura**: describen qué va a pasar pero no producen sonido por sí solos. `Pbind` es quien los convierte en sonido.

---

# 4. Pbind y los Value Patterns

## 4.1 `Pbind` — el motor musical

`Pbind` define un evento musical como pares **clave → valor**:

```supercollider
(
Pbind(
    \instrument, \perc,       // qué SynthDef usar
    \freq,       440,          // frecuencia (Hz)
    \dur,        0.5,          // duración entre eventos (beats)
    \amp,        0.1           // amplitud
).play;
)
```

## 4.2 Event keys esenciales

| Clave | Significado | Ejemplo |
|-------|-------------|---------|
| `\instrument` | SynthDef a usar | `\perc`, `\default` |
| `\freq` | Frecuencia en Hz | `440` |
| `\midinote` | Nota MIDI (0-127) | `60` |
| `\degree` | Grado de escala | `0`, `2`, `4` |
| `\dur` | Duración entre notas (beats) | `0.5` |
| `\amp` | Amplitud | `0.1` |
| `\pan` | Panorámica (-1 a 1) | `0` |
| `\legato` | Proporción nota/silencio | `0.8` |

## 4.3 Value Patterns — generar valores en el tiempo

### `Pseq` — secuencia ordenada

```supercollider
Pbind(
    \midinote, Pseq([60, 62, 64, 67], inf),   // Do Re Mi Sol, en bucle
    \dur,      0.25
).play;
```

### `Prand` — aleatorio con repetición

```supercollider
Pbind(
    \midinote, Prand([60, 62, 64, 67], inf),   // aleatorio
    \dur,      0.25
).play;
```

### `Pxrand` — aleatorio sin repetir consecutivos

```supercollider
Pbind(
    \midinote, Pxrand([60, 62, 64, 67], inf),
    \dur,      0.25
).play;
```

### `Pseries` — serie aritmética

```supercollider
Pbind(
    \midinote, Pseries(60, 1, 12),   // 60, 61, 62... hasta 12 pasos
    \dur,      0.2
).play;
```

### `Pdup` — repetir un valor N veces

```supercollider
Pbind(
    \midinote, Pseq([60, 64, 67], inf),
    \dur,      Pdup(4, Prand([0.25, 0.5], inf))   // repite la duración 4 veces
).play;
```

## 4.4 Patterns en todos los parámetros

Cada clave de `Pbind` puede recibir un pattern independiente:

```supercollider
(
p = Pbind(
    \instrument, \perc,
    \midinote,   Pseq([60, 62, 64, 67, 69], inf),
    \dur,        Prand([0.25, 0.25, 0.5, 1], inf),
    \amp,        Pseq([0.2, 0.1, 0.1, 0.15], inf),
    \pan,        Prand([-0.8, -0.3, 0, 0.3, 0.8], inf)
).play;
)

p.stop;
```

## 4.5 Combinaciones matemáticas

```supercollider
// Transponer un Pseq sumando un Pattern
Pbind(
    \midinote, Pseq([60, 62, 64], inf) + Prand([0, 12, -12], inf),
    \dur,      0.25
).play;
```

## 4.6 Patterns anidados

```supercollider
Pbind(
    \midinote, Pseq([
        Pseq([60, 62, 64], 1),    // frase A (3 notas)
        Pseq([67, 69, 72], 1)     // frase B (3 notas)
    ], inf),
    \dur, 0.25
).play;
```

## 4.7 Control: play, stop y TempoClock

```supercollider
t = TempoClock(120/60);

// Guardar la referencia para poder detenerlo
p = Pbind(
    \midinote, Pseq([60, 62, 64, 67], inf),
    \dur, 0.5
).play(t);

p.stop;    // detener

// Volver a empezar
p = p.play(t);
```

---

# 5. Errores comunes

## Error 1: Routine sin wait

```supercollider
// ❌ PELIGROSO — bloquea SuperCollider
Routine({ inf.do { Synth(\perc) } }).play;

// ✅ Siempre añade wait
Routine({ inf.do { Synth(\perc); 0.5.wait } }).play;
```

## Error 2: Olvidar guardar la referencia de Pbind

```supercollider
// ❌ No puedes detenerlo después
Pbind(\midinote, Pseq([60,62,64], inf), \dur, 0.5).play;

// ✅ Guarda la referencia
p = Pbind(\midinote, Pseq([60,62,64], inf), \dur, 0.5).play;
p.stop;   // ahora sí puedes detenerlo
```

## Error 3: Confundir duración de nota y duración entre notas

```supercollider
// \dur es el tiempo hasta el SIGUIENTE evento
// \sustain es la duración real del sonido (por defecto: \dur * \legato)
// \legato por defecto ≈ 0.8
```

---

# 6. Ejercicios

## Ejercicio 1: Canon simple

Crea dos `Pbind` con la misma melodía (`Pseq([60, 62, 64, 65, 67], inf)`) pero con `\dur` distintos (0.25 y 0.375). Arráncalos con el mismo `TempoClock` y cuantización de 4 beats.

## Ejercicio 2: Ritmo irregular

Diseña un `Pbind` que suene como un patrón de batería usando solo frecuencias fijas y duraciones variables (`Pseq` de duraciones que sumen un compás de 4 beats).

## Ejercicio 3: Melodía con aleatoriedad controlada

Construye un `Pbind` donde:
- La melodía sea `Prand` de una escala pentatónica: `[60, 62, 64, 67, 69]`
- Las duraciones alteren entre negra (0.5) y corchea (0.25) con `Prand`
- La amplitud varíe suavemente con `Pseq([0.05, 0.1, 0.15, 0.1], inf)`

## Ejercicio 4: Dos voces

Crea dos `Pbind` simultáneos:
- Voz 1: melodía grave (notas MIDI 36-48), duraciones largas
- Voz 2: melodía aguda (notas MIDI 72-84), duraciones cortas
- Ambos usando el mismo `TempoClock` a 100 BPM

---

# 7. Próxima y última Sesión

En la **Sesión 6** damos el salto al **live coding**: código que se reescribe mientras suena.

- `NodeProxy` y `Ndef` — sonido modificable en tiempo real
- Filosofía del live coding (TOPLAP, Algorave)
- Sesión práctica en directo
- Presentación del proyecto final

---

## 📝 Recursos

- [Guía oficial de Patterns en SC](https://doc.sccode.org/Tutorials/Streams-Patterns-Events1.html)
- Cheatsheet de Patterns (en los materiales del curso)
- [Documentación de Pbind](https://doc.sccode.org/Classes/Pbind.html)

---

**Los Patterns son la partitura. Pbind es el intérprete.** 🎼

*Módulo 2 · Sesión 5 de 3 — Música en tiempo real*
