# SuperCollider Cheatsheet - UGens (Unit Generators)

## Generadores (Osciladores)

### Osciladores Básicos

```supercollider
// Onda sinusoidal
SinOsc.ar(freq: 440, phase: 0, mul: 0.1)

// Onda diente de sierra
Saw.ar(freq: 440, mul: 0.1)

// Onda pulso (cuadrada con width variable)
Pulse.ar(freq: 440, width: 0.5, mul: 0.1)

// Onda triangular (frecuencia baja)
LFTri.ar(freq: 440, mul: 0.1)

// Oscilador variable (diente de sierra ↔ triángulo)
VarSaw.ar(freq: 440, width: 0.5, mul: 0.1)
```

### Ruidos

```supercollider
Ruido rosa (balanceado perceptivamente)
PinkNoise.ar(mul: 0.1)

// Ruido blanco
WhiteNoise.ar(mul: 0.1)

// Ruido marrón (enfasis en graves)
BrownNoise.ar(mul: 0.1)

// Ruido clip (valores aleatorios +1/-1)
ClipNoise.ar(mul: 0.1)
```

### Ruidos de Baja Frecuencia (para modulación)

```supercollider
// Saltos (sin interpolación)
LFNoise0.kr(freq: 2).range(-1, 1)

// Interpolación lineal
LFNoise1.kr(freq: 2).range(-1, 1)

// Interpolación curvada
LFNoise2.kr(freq: 2).range(-1, 1)
```

---

## Envolventes (Envelopes)

### Tipos de Envolventes

```supercollider
// Envolvente estándar (ADSR)
Env([levels], [times], [curve])

// Envolvente con duración especificada
Env.linen(attackSustain, releaseTime, peakLevel)
Env.perc(attackTime, releaseTime, peakLevel)
Env.sine(durion, level)
Env.step(levels, times)
```

### Ejemplos Prácticos

```supercollider
// ADSR simple
~adsr = Env([0, 1, 0.5, 0], [0.01, 0.2, 0.3], \lin, \lin, \exp);

// Pecaudal (muy musical)
~perc = Env.perc(0.01, 0.2, 1);

// Liner (para drones)
~lin = Env.linen(0.1, 8, 1, 0.1);

// Sinusoidal
~sine = Env.sine(2, 0.5);
```

---

## Filtros

```supercollider
// Paso bajo
LPF.ar(in: input, freq: 1000, mul: 1, add: 0)

// Paso alto
HPF.ar(in: input, freq: 1000)

// Paso banda
BPF.ar(in: input, freq: 1000, rq: 1)

// Nota (paso banda estrecho)
Resonz.ar(in: input, freq: 1000, bwr: 0.01)

// Filtro Moog (vintae)
MoogFF.ar(in: input, freq: 1000, gain: 2)

// Formante
Formlet.ar(in: input, freq: 1000, attackTime: 0.01, decayTime: 0.1)
```

---

## Modulación

### LFO (Low Frequency Oscillator)

```supercollider
// LFO sinusoidal
SinOsc.kr(freq: 2).range(min: 300, max: 600)

// LFO triangular
LFTri.kr(freq: 1).range(0.1, 0.5)

// Ruido lento
LFNoise1.kr(freq: 0.5).range(300, 800)
```

### Frecuencias Audio vs Control

```supercollider
// .ar = Audio Rate (para sonar)
SinOsc.ar(440).play

// .kr = Control Rate (para modular)
SinOsc.kr(2)  // Modulación lenta

// .ir = Initialization Rate (calcula una vez)
440.ir        // Valor fijo
```

---

## Amplitud y Volumen

### Decibelios

```supercollider
// dB a amplitud
(-12).dbamp        // → 0.2512

// Amplitud a dB
0.2512.ampdb       // → -12
```

### Multiplicación de volumen

```supercollider
// Directo
{ PinkNoise.ar * 0.1 }.play

// Usando dB
{ PinkNoise.ar * (-20).dbamp }.play

// Mul argumento
{ PinkNoise.ar(mul: 0.1) }.play
```

---

## Control y Secuenciación

### Impulsos (Triggers)

```supercollider
// Impulso periódico
Impulse.ar(freq: 2, phase: 0, mul: 1)

// Impulso aleatorio (no periódico)
Dust.ar(density: 2, mul: 1)

// Impulso por cambio
Changed.ar(input: value)
```

---

## Efectos

### Delay

```supercollider
DelayN.ar(in: input, maxdelay: 1, delay: 0.5, mul: 1)

DelayL.ar(in: input, maxdelay: 1, delay: 0.5, mul: 1)  // Lineal

DelayC.ar(in: input, maxdelay: 1, delay: 0.5, mul: 1)  // Cubica
```

### Reverb

```supercollider
FreeVerb.ar(
    in: input,            // Entrada
    mix: 0.33,            // Mezcla (0 = dry, 1 = wet)
    room: 0.5,            // Tamaño de sala
    damp: 0.5             // Atenuación de agudos
)
```

### Distorsión

```supercollider
// Distorsión suave
SoftClip.ar(in: input)

// Distorsión fuerte
Distort.ar(in: input)

// Compresión
Compander.ar(
    in: input,
    control: input,
    thresh: 0.2,
    slopeBelow: 1,
    slopeAbove: 0.5,
    clampTime: 0.01,
    relaxTime: 0.1
)
```

### Panoramización

```supercollider
// Panorámica estática
Pan2.ar(in: input, pos: 0, level: 1)

// Panorámica con balance de potencias
Balance2.ar(inLeft, inRight, pos: 0)

// Panorámica azimutal (multichannel)
PanAz.ar(numChans: 4, in: input, pos: 0, level: 1)
```

---

## Multi-Channel Expansion

### Arrays como Señales Multicanal

```supercollider
// Dos canales L/R
[
    SinOsc.ar(440),
    SinOsc.ar(442)
]

// Expansión con arrays
SinOsc.ar([440, 442])  // Genera 2 osciladores
```

### Mezclar Muchas Voces

```supercollider
// Sumar todas las señales
sig.sum

// Panorámicas automáticas
Splay.ar(sig, spread: 1, level: 1, center: 0)
```

---

## UGens Especiales

### Muestreo

```supercollider
// Reproducir buffer
PlayBuf.ar(
    numChannels: 2,
    bufnum: buffer,
    rate: 1,
    trigger: 1,
    startPos: 0,
    loop: 0,
    doneAction: 2
)
```

### Grain Synthesis

```supercollider
TGrains.ar(
    numChannels: 2,
    trigger: Impulse.ar(10),
    bufnum: buffer,
    rate: 1,
    centerPos: 0.5,
    dur: 0.1,
    pan: 0,
    amp: 0.1,
    maxGrains: 512
)
```

---

## Referencias Rápida

### Tasa

| Tasa | Uso | Ejemplo |
|------|-----|---------|
| `.ar` | Señal audible | `SinOsc.ar(440)` |
| `.kr` | Modulación lenta | `SinOsc.kr(2)` |
| `.ir` | Valor fijo | `440.ir` |

### Argumentos Comunes

```supercollider
mul  // Multiplicación (volumen, escala)
add  // Adición (offset)
freq // Frecuencia
phase // Fase inicial
width // Ancho (para Pulse, VarSaw)
```

### Rangos Típicos

```supercollider
// Frecuencias audibles
20 Hz - 20000 Hz

// LFO (modulación)
0.1 Hz - 10 Hz

// Amplitud
0.0 - 1.0 (o usar dB)
```

---

## Patrones Comunes

### Oscilador Modulado

```supercollider
{
    var carrier, modulator;
    modulator = SinOsc.kr(2).range(300, 600);
    carrier = SinOsc.ar(modulator) * 0.1;
    carrier;
}.play
```

### Ruido Filtrado

```supercollider
{
    PinkNoise.ar * 0.5
    |> LPF.ar(_, 1000)
}.play
```

### Oscilador con Envolvente

```supercollider
Synth(\simple, [
    \freq, 440,
    \gate, 1,
    \env, Env.perc(0.01, 0.2, 0.5)
])
```

---

*Actualizado para curso UNED - Sesión 1-4*

---

**¿Buscas más?**
- Cmd + D sobre cualquier UGen para ver su ayuda
- Ver Browse UGens en Help Browser
- Consulta cheatsheet adicional de Envolventes