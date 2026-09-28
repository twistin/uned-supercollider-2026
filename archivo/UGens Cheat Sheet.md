

------

# 🎛️ SuperCollider – **Essential UGens Cheat Sheet**

> **UGen (Unit Generator)** = bloque básico que **genera o procesa audio o control**.

------

## 1️⃣ Tasas de cálculo (esto es CLAVE)

| Tasa    | Método | Uso                          |
| ------- | ------ | ---------------------------- |
| Audio   | `.ar`  | Sonido audible               |
| Control | `.kr`  | Modulación lenta             |
| Inicial | `.ir`  | Valor fijo al crear el Synth |

```supercollider
SinOsc.ar(440);
LFNoise1.kr(2);
```

------

## 2️⃣ Osciladores básicos (generadores)

### 🔹 SinOsc – seno (base de todo)

```supercollider
SinOsc.ar(freq: 440, mul: 0.2);
```

### 🔹 Saw – diente de sierra

```supercollider
Saw.ar(220, 0.2);
```

### 🔹 Pulse – onda cuadrada con ancho variable

```supercollider
Pulse.ar(110, width: 0.3, mul: 0.2);
```

### 🔹 LFTri – triángulo

```supercollider
LFTri.ar(330, mul: 0.2);
```

------

## 3️⃣ Ruido (texturas)

### 🔹 WhiteNoise – ruido blanco

```supercollider
WhiteNoise.ar(0.2);
```

### 🔹 PinkNoise – ruido rosa

```supercollider
PinkNoise.ar(0.2);
```

### 🔹 BrownNoise – ruido marrón

```supercollider
BrownNoise.ar(0.2);
```

------

## 4️⃣ Modulación (LFOs)

### 🔹 SinOsc como LFO

```supercollider
SinOsc.kr(0.5).range(200, 800);
```

### 🔹 LFNoise1 – valores suaves aleatorios

```supercollider
LFNoise1.kr(3).range(300, 600);
```

### 🔹 LFNoise0 – saltos aleatorios

```supercollider
LFNoise0.kr(5).range(0, 1);
```

------

## 5️⃣ Envolventes (control del tiempo)

### 🔹 Env + EnvGen (esencial)

```supercollider
EnvGen.kr(
    Env.perc(0.01, 1),
    doneAction: 2
);
```

### 🔹 ADSR

```supercollider
Env.adsr(0.01, 0.2, 0.5, 1);
```

------

## 6️⃣ Amplificación y control de volumen

### 🔹 multiplicar señal

```supercollider
sig * 0.1;
```

### 🔹 Amplitude follower

```supercollider
Amplitude.kr(sig);
```

------

## 7️⃣ Filtros (muy usados)

### 🔹 LPF – paso bajo

```supercollider
LPF.ar(sig, 1000);
```

### 🔹 HPF – paso alto

```supercollider
HPF.ar(sig, 500);
```

### 🔹 BPF – paso banda

```supercollider
BPF.ar(sig, freq: 800, rq: 0.2);
```

------

## 8️⃣ Efectos esenciales

### 🔹 DelayC – delay corto

```supercollider
DelayC.ar(sig, 0.3, 0.2);
```

### 🔹 CombN – eco resonante

```supercollider
CombN.ar(sig, 0.3, 0.2, 2);
```

### 🔹 FreeVerb – reverb básica

```supercollider
FreeVerb.ar(sig, mix: 0.3, room: 0.5);
```

------

## 9️⃣ Panorámica y estéreo

### 🔹 Pan2 – mono a estéreo

```supercollider
Pan2.ar(sig, 0);  // -1 izquierda, 1 derecha
```

### 🔹 Splay – arrays a estéreo

```supercollider
Splay.ar([sig1, sig2, sig3]);
```

------

## 🔟 Detección y control

### 🔹 Triggers

```supercollider
Impulse.kr(2);
```

### 🔹 Dust – impulsos aleatorios

```supercollider
Dust.kr(4);
```

------

## 1️⃣1️⃣ Multicanal (muy importante)

```supercollider
SinOsc.ar([440, 660, 880]);
```

------

## 🧠 Receta mínima de Synth

```supercollider
{
    var env = EnvGen.kr(Env.perc, doneAction: 2);
    SinOsc.ar(440) * env * 0.2
}.play;
```

------

## 📌 Regla de oro para clase

> *Un UGen genera o transforma una señal.
> Si no suena, mira la tasa, la amplitud o la envolvente.*

------

## 🎓 Ideas pedagógicas rápidas

- Oscilador → fuente sonora
- LFO → gesto
- Envolvente → forma
- Filtro → color
- Reverb → espacio

------

