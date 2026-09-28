# Tarea — Módulo 1, Sesión 3
## El servidor de audio y los UGens

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

### Ejercicio 1 — Exploración de osciladores

Crea cuatro variantes sonoras del mismo oscilador (`SinOsc.ar(440) * 0.1`) que difieran en:

1. El tipo de oscialdor (usa al menos 3 distintos: `SinOsc`, `Saw`, `Pulse`, `LFTri`)
2. La frecuencia (prueba 110 Hz, 220 Hz, 440 Hz, 880 Hz)
3. El ancho de pulso para `Pulse` (prueba 0.1, 0.3, 0.5)

Para cada uno, usa `.plot(0.01)` primero para ver la forma de onda antes de escucharla. ¿Cómo cambia el timbre?

---

### Ejercicio 2 — Sintetizador con modulación

Diseña un sonido con estas características:

- Oscilador principal: `Saw.ar` con frecuencia base de 220 Hz
- Modulación de frecuencia: `LFNoise1.kr` que varíe la frecuencia entre 200 y 300 Hz
- Modulación de amplitud: `SinOsc.kr(0.3)` que varíe entre 0.05 y 0.15 (usa `.range`)
- Salida en estéreo con `! 2`

Guarda la referencia en `x` y modifica los parámetros con `.set` mientras suena.

---

### Ejercicio 3 — Diseño de envolvente

Sin código de sonido — solo visualización:

1. Diseña con `Env.new([...], [...])` una envolvente que imite:
   - Un pizzicato de cuerda (ataque muy rápido, caída lenta)
   - Un pad de sintetizador (ataque lento, caída muy lenta)
   - Un golpe de percusión (ataque instantáneo, caída corta)

2. Visualiza cada una con `.plot`

3. Aplica la envolvente de pizzicato a un `SinOsc.ar(440)` usando `EnvGen.kr`

---

### Desafío opcional — Acorde con envolventes escalonadas

Lanza 4 instancias del instrumento `~tono` del código de clase con:
- Las 4 notas del acorde de Do mayor: Do, Mi, Sol, Si (MIDI: 60, 64, 67, 71)
- Tiempos de ataque progresivos: 0.01, 0.05, 0.1, 0.2
- Duraciones progresivas: 0.5, 0.8, 1.2, 2.0

¿El resultado suena a arpeggio, a acorde o a algo intermedio?

**Tiempo estimado:** 45-60 minutos

---

*Módulo 1 · Tarea Sesión 3 — Componer con código*

---

> **Con esta tarea termina el Módulo 1.**
> Si continúas con el Módulo 2, la próxima sesión introduce `SynthDef` — la forma profesional de definir instrumentos en SuperCollider.
