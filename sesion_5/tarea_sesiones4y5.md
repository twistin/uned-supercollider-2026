# Tarea — Módulo 2, Sesión 4 y 5
## SynthDef y Patterns

> **Módulo 2 — Música en tiempo real: síntesis, Patterns y live coding con SuperCollider**

---

> Esta tarea integra los contenidos de la Sesión 4 (SynthDef) y la Sesión 5 (Patterns) en un ejercicio unificado. El objetivo es construir un pequeño sistema musical completo.

---

### Ejercicio 1 — Tu propio instrumento

Diseña un `SynthDef` llamado `\miSonido` que tenga al menos:
- Un oscilador distinto de `SinOsc` (prueba `Saw`, `Pulse`, o una combinación)
- Un filtro con frecuencia de corte como argumento (`RLPF` o `LPF`)
- Una envolvente `Env.perc` con ataque y release como argumentos
- Salida estéreo

Prueba tu instrumento creando 3 instancias de `Synth` con parámetros distintos.

---

### Ejercicio 2 — Secuenciación de tu instrumento

Usa `Pbind` con tu `\miSonido` para crear una secuencia que:
1. Recorra al menos 8 notas distintas en algún orden musical (no tiene que ser una escala convencional)
2. Varíe las duraciones con `Prand` o `Pseq`
3. Varíe la amplitud de nota a nota

Guarda la referencia en `p` para poder pararlo.

---

### Ejercicio 3 — Dos voces

Crea una segunda voz con un `Pbind` distinto que suene simultáneamente con la primera. Las dos voces deben:
- Usar el mismo `TempoClock` a un tempo de tu elección
- Arrancarse con `quant: 4` para que queden sincronizadas
- Sonar complementarias (por ejemplo: una grave y lenta, otra aguda y rápida)

---

### Desafío opcional — Estructura en secciones

Haz que tu secuencia tenga dos secciones distintas usando `Pseq` anidado:
- **Sección A** (8 beats): una frase melódica fija con `Pseq`
- **Sección B** (8 beats): material aleatorio con `Prand`
- Repite A-B tres veces y termina

*Pista: `Pseq([secA, secB], 3)` donde cada sección es ella misma un Pattern.*

**Tiempo estimado:** 60-90 minutos

---

*Módulo 2 · Tarea Sesiones 4 y 5 — Música en tiempo real*
