# SuperCollider Cheatsheet - Envolventes (Envelopes)

## ¿Qué es una Envolvente?

Una **envolvente** define cómo cambia un parámetro (amplitud, frecuencia, etc.) en el tiempo.

```
        Peak
    ────────┐
           │
           │  Sustain
   Attack  │
     ↗     │
      │    │
      │    │  Release
    Start ───┘ ↘
                 ───→ End
```

---

## Tipos de Envolventes Predefinidas

### 1. Env.perc - Pecaudal (Percussive)

```supercollider
Env.perc(attackTime, releaseTime, peakLevel, curve)

// Ejemplo: golpe de tambor
~perc = Env.perc(
    0.01,        // Ataque: 10ms (corto)
    0.2,         // Release: 200ms
    1,           // Nivel pico: 1.0
    linear       // Curva: lineal (por defecto)
)
```

**Uso típico:** Percusión, pluck, arpegios

### 2. Env.linen - Liner

```supercollider
Env.linen(attackTime, sustainTime, releaseTime, peakLevel, curve)

// Ejemplo: drone sostenido
~lin = Env.linen(
    0.5,         // Attack: 500ms
    5.0,         // Sustain: 5 segundos
    1.5,         // Release: 1500ms
    0.8,         // Nivel pico: 0.8
    \sin         // Curva: sinusoidal
)
```

**Uso típico:** Drones, pads, texturas

### 3. Env.adsr - ADSR Clásico

```supercollider
Env.adsr(
    attackTime,  // Tiempo de ataque
    decayTime,   // Tiempo de caída
    sustainLevel, // Nivel sostenido
    releaseTime, // Tiempo de release
    peakLevel,   // Nivel pico (opcional)
    curve        // Curva (opcional)
)

// Ejemplo: synth clásico
~adsr = Env.adsr(
    0.1,         // Attack: 100ms
    0.2,         // Decay: 200ms
    0.5,         // Sustain: 50% del pico
    0.5,         // Release: 500ms
    1,           // Peak: 100%
    \lin         // Curva lineal
)
```

**Uso típico:** Sintetizadores clásicos, teclados

### 4. Env.sine - Sinusoidal

```supercollider
Env.sine(duration, level)

// Ejemplo: campana suave
~sine = Env.sine(
    2.0,         // Duración total: 2 segundos
    0.5          // Nivel pico: 0.5
)
```

**Uso típico:** Campanas, texturas suaves

### 5. Env.triangle - Triangular

```supercollider
Env.triangle(duration, level)

// Ejemplo: LFO como envolvente
~tri = Env.triangle(
    1.0,         // Duración: 1 segundo
    0.5
)
```

**Uso típico:** LFOs, modulación rítmica

### 6. Env.step - Escalonado

```supercollider
Env.step(levels, times, releaseNode)

// Ejemplo: secuencia escalonada
~step = Env.step(
    [0, 0.5, 1, 0.5, 0],  // Niveles
    [0.5, 0.5, 0.5, 0.5]   // Tiempos entre niveles
)
```

**Uso típico:** Secuencias arpegiadas, cambios discretos

---

## Crear Envolvente Personalizada

### Env(levels, times, curves, releaseNode, loopNode)

```supercollider
Env([
    0,  // Nivel 0: silencio
    1,  // Nivel 1: pico
    0.8, // Nivel 2: sustain
    0   // Nivel 3: silencio
], [
    0.1,    // tiempo 0→1: 100ms (attack)
    0.2,    // tiempo 1→2: 200ms (decay)
    0.5     // tiempo 2→3: 500ms (release)
], [
    \lin,   // curva 0→1: lineal
    \exp,   // curva 1→2: exponencial
    \lin    // curva 2→3: lineal
])
```

---

## Curvas (Curves)

Tipos de curvas disponibles:

```supercollider
\lin      // Lineal
\exp      // Exponencial
\sin      // Sinusoidal
\welch    // Curva Welch
\sqr      // Cuadrática
\cub      // Cúbica
-steepnessValue // Número personalizado (ej: -4 a 4)
```

### Diferencias Prácticas

| Curva | Característica | Uso típico |
|-------|---------------|-----------|
| `\lin` | Cambio constante | Transiciones suaves |
| `\exp` | Cambio acelerado | Drops, releases |
| `\sin` | Suave y orgánico | Texturas, pads |
| `\welch` | Exponencial simétrica | Bows, resonancias |

### Números Personales

```supercollider
// Positivo: más "S" (rápido al principio)
Env([0, 1, 0], [0.5, 0.5], [3, 3])

// Negativo: invertido (lento al principio)
Env([0, 1, 0], [0.5, 0.5], [-3, -3])

// 0: lineal
Env([0, 1, 0], [0.5, 0.5], [0, 0])
```

---

## Usar Envolventes

### En SynthDefs

```supercollider
SynthDef(\simpleEnv, {
    arg freq = 440, gate = 1, amp = 0.5;
    var env, sig;

    env = Env.asr(
        0.01,    // attack
        amp,     // sustain
        0.5      // release
    );

    sig = SinOsc.ar(freq)
        * EnvGen.kr(env, gate, doneAction: 2);

    Out.ar(0, sig);
}).add;

// Crear synth
~synth = Synth(\simpleEnv, [\freq, 440]);

// Detener (trigger release)
~synth.set(\gate, 0);
```

Done Actions → Ver cheatsheet completa

### En UGens

```supercollider
// Envolvente de amplitud
{
    var env;
    env = Env.perc(0.01, 0.2);
    SinOsc.ar(440) * EnvGen.kr(env);
}.play
```

### Como Generador de Valores

```supercollider
// Envolvente controlando frecuencia
{
    var env;
    env = Env([200, 800, 500], [0.1, 0.8]);
    SinOsc.ar(EnvGen.kr(env));
}.play
```

---

## Done Actions (Acciones al Finalizar)

```supercollider
// 0: no hace nada
doneAction: 0

// 1: pausa el synth (sigue en memoria)
doneAction: 1

// 2: elimina el synth (libera servidor)
doneAction: 2  // ← Más común

// 3: elimina synth y sus nodos hijos
doneAction: 3

// 4: elimina synth y su nodo padre
doneAction: 4

// 5: elimina synth y todos en su grupo
doneAction: 5

// ... y más
```

### Importante en Envolventes

```supercollider
// ❌ MAL: No libera servidor
EnvGen.kr(Env.perc(0.01, 0.2))

// ✅ BIEN: Libera servidor al terminar
EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2)
```

---

## Release Nodes y Loop Nodes

### Release Node

Define dónde hacer el release cuando llega el `gate = 0`:

```supercollider
Env(
    [0, 1, 0.5, 0],    // niveles
    [0.1, 0.2, 0.5],   // tiempos
    [\lin, \lin, \lin], // curvas
    2                  // ← ReleaseNode (empieza en nivel 2)
)
```

### Loop Node

Define dónde hacer un loop (repetir):

```supercollider
Env(
    [0, 1, 0.5, 1, 0],
    [0.1, 0.1, 0.2, 0.1],
    [\lin, \lin, \exp, \lin],
    4,      // ReleaseNode
    2       // ← LoopNode (reinicia en nivel 2)
)
```

---

## Patrones Musicales Comunes

### Percusión (Bombo)

```supercollider
~kick = Env(
    [1, 0.5, 0],  // niveles
    [0.01, 0.1],  // tiempos
    \exp          // curva exponencial
)

// Uso
{
    SinOsc.ar(60) * EnvGen.kr(~kick, doneAction: 2);
}.play
```

### Pluck (Guitarra)

```supercollider
~pluck = Env.perc(
    0.001,  // attack muy rápido
    1.0,    // release largo
    0.8,    // pico
    -4      // curva exponencial invertida
)
```

### Pad Sostenido

```supercollider
~pad = Env.adsr(
    2.0,    // attack lento
    3.0,    // decay lento
    0.7,    // sustain alto
    4.0,    // release largo
    1,      // peak
    \sin    // curva suave
)
```

### FX Decay

```supercollider
~fxRelease = Env.linen(
    0,      // no attack
    2.0,    // sustain de 2 segundos
    3.0,    // release de 3 segundos
    level: 0.3
)
```

---

## Depuración de Envolventes

### Ver duración total

```supercollider
env.duration       // Duración total en segundos
```

### Ver tiempos de cada segmento

```supercollider
env.times          // Array de tiempos
```

### Ver niveles

```supercollider
env.levels         // Array de niveles
```

### Ver curvas

```supercollider
env.curves         // Array de curvas
```

---

## Errores Comunes

### Error 1: Olvidar doneAction

```supercollider
// ❌ Synth nunca se elimina
Sig * EnvGen.kr(Env.perc(0.01, 0.2))

// ✅ Libera recursos
Sig * EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2)
```

### Error 2: Curvas inapropiadas

```supercollider
// ❌ Curve \exp en drop (puede ser muy rápido)
Env([0, 1, 0], [0.1, 0.1], [\lin, \exp])

// ✅ Curve \lin en drop (más controlable)
Env([0, 1, 0], [0.1, 0.1], [\lin, \lin])
```

### Error 3: Tiempos incorrectos

```supercollider
// ❌ Attack de 10 segundos (demasiado lento)
Env.perc(10, 0.2)

// ✅ Attack realista
Env.perc(0.01, 0.2)
```

---

## Referencias Rápidas

### Tipos Envolventes

| Env | Niveles | Características |
|-----|---------|---------------|
| `perc` | 3 (0 → peak → 0) | Percusiva |
| `adsr` | 4 (attack → decay → sustain → 0) | Sintetizador clásico |
| `linen` | 4 (attack → sustain → release → 0) | Drone |
| `sine` | - | Suave |
| `step` | N | Escalonado |

### Curvas

| Curva | Uso típico |
|-------|-----------|
| `\lin` | Transiciones generales |
| `\exp` | Drops, releases rápidos |
| `\sin` | Pads, texturas |
| `welch` | Resonancias |

### Done Actions

| Acción | Código |
|--------|--------|
| Nada | `0` |
| Pausar | `1` |
| Eliminar | `2` ← Recomendado |
| Eliminar con hijos | `3` |

---

**¿Buscas más?**
- Cmd + D sobre `Env` para ver documentación completa
- Ver también cheatsheet de UGens
- Consulta ejemplos en Help Browser

---

*Actualizado para curso UNED - Sesión 4*