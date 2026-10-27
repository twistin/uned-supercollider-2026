# SuperCollider — Módulo 1, Sesión 3: El servidor de audio y los UGens
## Del lenguaje al sonido: síntesis básica en tiempo real

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Arrancar, parar y reiniciar el servidor de audio
- ✅ Entender qué son los UGens y las tasas de señal (ar, kr)
- ✅ Producir sonido con osciladores y generadores de ruido
- ✅ Controlar amplitud y frecuencia en tiempo real con argumentos
- ✅ Aplicar una envolvente básica a un sonido
- ✅ Usar herramientas visuales: Scope, FreqScope, Meter

---

## 📚 Estructura de la Sesión

### 1. El servidor de audio — 15 min
### 2. UGens: los bloques de síntesis — 20 min
### 3. Tasas de señal: ar y kr — 15 min
### 4. Control en tiempo real: argumentos y `set` — 20 min
### 5. Envolventes básicas — 20 min
### 6. Herramientas visuales y cierre — 10 min

---

# 1. El servidor de audio

## 1.1 Arrancar el servidor

SuperCollider tiene **tres partes**: IDE, intérprete y servidor de audio. El intérprete arranca solo, pero el servidor hay que iniciarlo a mano:

```supercollider
s.boot;
```

Espera a que en la Post Window aparezca:
```
Server 'localhost' running
```

El indicador en la barra inferior del IDE también cambia de color.

## 1.2 Parar y reiniciar

```supercollider
s.quit;     // apaga el servidor
s.reboot;   // quit + boot en un solo paso
```

> **⚠️ Parada de emergencia:** `Cmd + .` (Mac) / `Ctrl + .` (Windows) — para todo el sonido al instante.

## 1.3 La variable `s`

`s` es la variable reservada que apunta al servidor. No la sobreescribas:

```supercollider
s = 2;          // ❌ NO hagas esto — pierdes la referencia al servidor
s = Server.local; // ✅ Si ocurre, esto lo recupera
```

---

# 2. UGens: los bloques de síntesis

## 2.1 ¿Qué es un UGen?

Un **UGen** (*Unit Generator*) es un módulo de síntesis: oscilador, filtro, generador de ruido, envolvente, etc. Piensa en ellos como los **módulos de un sintetizador modular**.

Para hacer sonido en SuperCollider usas UGens dentro de una función y le pides `play`:

```supercollider
{ SinOsc.ar(440) * 0.1 }.play;
```

En lugar de `.value` (que ejecuta una función matemática), aquí usamos `.play` — que manda la señal al servidor de audio.

## 2.2 Osciladores básicos

```supercollider
{ SinOsc.ar(440) * 0.1 }.play;       // seno puro
{ Saw.ar(440) * 0.1 }.play;          // diente de sierra (rico en armónicos)
{ Pulse.ar(440) * 0.1 }.play;        // onda cuadrada
{ LFTri.ar(440) * 0.1 }.play;        // triángulo
```

> Prueba a cambiar la frecuencia. Usa `Cmd + .` para parar antes de lanzar otro.

## 2.3 Generadores de ruido

```supercollider
{ WhiteNoise.ar * 0.1 }.play;        // todos los armónicos al mismo nivel
{ PinkNoise.ar * 0.1 }.play;         // más potencia en graves
{ BrownNoise.ar * 0.1 }.play;        // todavía más grave
```

## 2.4 Control de amplitud

```supercollider
// Multiplicación directa (0 = silencio, 1 = nivel completo)
{ SinOsc.ar(440) * 0.1 }.play;

// Con decibelios (más intuitivo)
{ SinOsc.ar(440) * (-20).dbamp }.play;   // -20 dB
{ SinOsc.ar(440) * (-6).dbamp }.play;    // -6 dB (más fuerte)
```

---

# 3. Tasas de señal: `.ar` y `.kr`

La mayoría de UGens tienen dos versiones:

| Tasa | Método | Cuándo usar |
|------|--------|-------------|
| **Audio Rate** | `.ar` | Señales que van al altavoz |
| **Control Rate** | `.kr` | Modulaciones lentas (LFO, envolventes) |

`.kr` genera menos muestras → consume menos CPU → ideal para controlar parámetros.

```supercollider
// LFO a control rate modulando frecuencia de oscilador a audio rate
{
    var lfo, sig;
    lfo = SinOsc.kr(0.5).range(200, 800);   // oscila entre 200 y 800 Hz
    sig = SinOsc.ar(lfo) * 0.1;
    sig
}.play;
```

## 3.1 `.range(min, max)`

Convierte la señal de [-1, 1] al rango que necesitas, sin calcular `mul` y `add` a mano:

```supercollider
LFNoise1.kr(2).range(100, 800);    // frecuencia que vaga entre 100 y 800 Hz
LFNoise1.kr(1).range(0.01, 0.2);   // amplitud variable
```

## 3.2 Ruido de baja frecuencia como modulador

```supercollider
// LFNoise0: saltos bruscos
// LFNoise1: interpolación lineal (más suave)
// LFNoise2: interpolación curvada

{
    var freq;
    freq = LFNoise1.kr(1).range(200, 800);
    SinOsc.ar(freq) * 0.1
}.play;
```

---

# 4. Control en tiempo real: argumentos y `set`

Hasta ahora, una vez lanzado el sonido, no podemos modificarlo sin detenerlo. Los **argumentos** cambian eso.

## 4.1 Función con argumentos sonoros

```supercollider
(
x = {
    arg freq = 440, amp = 0.1;
    SinOsc.ar(freq) * amp
}.play;
)
```

Guarda la referencia en `x`. Ahora puedes modificar parámetros en tiempo real:

```supercollider
x.set(\freq, 660);        // cambia la frecuencia
x.set(\amp, 0.05);        // baja la amplitud
x.set(\freq, 880, \amp, 0.15);  // varios a la vez
```

## 4.2 Transiciones suaves con `lag`

Los cambios con `set` son instantáneos. Para suavizarlos:

```supercollider
(
x = {
    arg freq = 440, amp = 0.1;
    SinOsc.ar(freq.lag(1)) * amp.lag(0.5)
}.play;
)

x.set(\freq, 880);   // glissando de 1 segundo hacia 880 Hz
```

## 4.3 Estéreo con arrays

```supercollider
{
    var sig;
    sig = SinOsc.ar([440, 441]) * 0.1;   // L: 440, R: 441 → batido
    sig
}.play;
```

---

# 5. Envolventes básicas

Una **envolvente** da forma a la amplitud de un sonido en el tiempo: ataque, sostenido, caída.

## 5.1 `Env` — definir la forma

```supercollider
Env.perc(0.01, 1).plot;      // percusiva (ataque rápido, caída lenta)
Env.adsr(0.1, 0.2, 0.8, 0.5).plot;  // ADSR clásica
Env.new([0, 1, 0.5, 0], [0.1, 0.3, 0.5]).plot;  // forma personalizada
```

## 5.2 `EnvGen` — ejecutar la envolvente como señal

```supercollider
{
    var env, sig;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    sig = SinOsc.ar(440) * env * 0.3;
    sig
}.play;
```

> `doneAction: 2` — libera el synth cuando la envolvente termina. Sin esto, el proceso sigue consumiendo CPU aunque no suene.

## 5.3 `Env.kr` — atajo moderno

```supercollider
{
    var sig;
    sig = SinOsc.ar(440) * Env.perc(0.01, 1.5).kr(2) * 0.3;
    sig
}.play;
```

## 5.4 Lanzar varios sonidos seguidos

```supercollider
// Cada llamada a .play crea un nuevo proceso independiente
{ SinOsc.ar(440) * Env.perc(0.01, 0.5).kr(2) * 0.2 }.play;
{ SinOsc.ar(660) * Env.perc(0.01, 0.5).kr(2) * 0.2 }.play;
{ SinOsc.ar(880) * Env.perc(0.01, 0.5).kr(2) * 0.2 }.play;
```

---

# 6. Herramientas visuales

```supercollider
s.meter;      // niveles de entrada/salida
s.scope;      // osciloscopio (forma de onda en tiempo real)
s.freqscope;  // analizador espectral
```

Para visualizar una señal sin sonido:

```supercollider
{ SinOsc.ar(440) }.plot(0.01);   // dibuja 10ms de la señal
{ Saw.ar(440) }.plot(0.01);
```

---

# 7. Juntando todo: primer instrumento completo

```supercollider
(
~tono = { |freq = 440, amp = 0.2, atk = 0.01, rel = 1|
    var env, sig;
    env = EnvGen.kr(Env.perc(atk, rel), doneAction: 2);
    sig = SinOsc.ar(freq) * env * amp;
    sig ! 2    // duplicar a estéreo
}.play;
)
```

Lanza el instrumento con distintos parámetros:

```supercollider
{ SinOsc.ar(440)  * Env.perc(0.01, 0.5).kr(2) * 0.2 ! 2 }.play;
{ SinOsc.ar(660)  * Env.perc(0.01, 0.3).kr(2) * 0.2 ! 2 }.play;
{ SinOsc.ar(880)  * Env.perc(0.05, 2.0).kr(2) * 0.1 ! 2 }.play;
```

---

# 8. Ejercicios

## Ejercicio 1: Explorar osciladores

Prueba cada uno de estos y describe con una palabra cómo suena:
```supercollider
{ SinOsc.ar(440) * 0.1 }.play;
{ Saw.ar(440) * 0.1 }.play;
{ Pulse.ar(440) * 0.1 }.play;
{ Pulse.ar(440, 0.1) * 0.1 }.play;   // ¿qué cambia el 0.1?
```

## Ejercicio 2: Modulación de frecuencia

Crea un sonido donde la frecuencia oscile lentamente entre 200 y 600 Hz. Usa `LFNoise1.kr` y `.range`.

## Ejercicio 3: Envolvente personalizada

Diseña una envolvente con `Env.new` que tenga:
- Ataque lento (0.5 segundos)
- Pico a amplitud 1
- Caída rápida a 0.3
- Sostenido en 0.3 durante 1 segundo
- Release de 2 segundos

Visualízala con `.plot` y aplícala a un oscilador.

## Ejercicio 4: Instrumento con argumentos

Toma el `~tono` del ejemplo anterior y:
1. Cambia `SinOsc` por `Saw`
2. Añade un argumento `pan` (panorámica, -1 a 1)
3. Usa `Pan2.ar(sig, pan)` para posicionar el sonido en el campo estéreo

---

# 9. Próxima Sesión — Módulo 2

Con esto termina el **Módulo 1**. Si continúas con el **Módulo 2** (*Música en tiempo real*), la Sesión 4 introduce `SynthDef`: la forma formal de definir instrumentos en SuperCollider. Sobre esa base construiremos secuenciación con Patterns y, finalmente, live coding.

---

## 📝 Recursos

- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- Cheatsheet de UGens y Envelopes (en los materiales del curso)
- [Browsing UGens en la ayuda de SC](https://doc.sccode.org/Browse.html#UGens)

---

**Del lenguaje al sonido: ya tienes los tres ingredientes.** 🎛️

*Módulo 1 · Sesión 3 de 3 — Componer con código*
