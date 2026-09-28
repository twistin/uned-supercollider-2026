/* =========================================================
   SuperCollider — Código de Sesión 5
   Módulo 2: Música en tiempo real
   Sesión 5: Secuenciación con Patterns
   =========================================================

   INSTRUCCIONES:
   - Evalúa primero s.boot y los SynthDefs del bloque 0
   - Para cada Pbind, guarda la referencia (p = ...) para poder pararlo
   - Usa Cmd/Ctrl + . si algo va mal

*/

/* ---------------------------------------------------------
   0. SETUP: servidor + SynthDefs
   --------------------------------------------------------- */

s.boot;

// SynthDef de nota con envolvente (necesario para los Patterns)
SynthDef(\nota, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var pan   = \pan.kr(0);
    var atk   = \atk.kr(0.01);
    var rel   = \rel.kr(0.3);
    var env   = EnvGen.kr(Env.perc(atk, rel), doneAction: 2);
    var sig   = SinOsc.ar(freq) * env * amp;
    Out.ar(0, Pan2.ar(sig, pan));
}).add;

// SynthDef de batería básica (del código de Sesión 4)
SynthDef(\kick, {
    var freq = EnvGen.kr(Env([150, 60], [0.15], \exp));
    var env  = EnvGen.kr(Env.perc(0.001, 0.4), doneAction: 2);
    Out.ar(0, (SinOsc.ar(freq) * env * 0.5) ! 2);
}).add;

SynthDef(\hihat, {
    var env = EnvGen.kr(Env.perc(0.001, 0.06), doneAction: 2);
    Out.ar(0, (HPF.ar(WhiteNoise.ar, 8000) * env * 0.15) ! 2);
}).add;

/* ---------------------------------------------------------
   1. ROUTINE — secuenciación paso a paso
   --------------------------------------------------------- */

// Routine básica
r = Routine({
    "Momento 1".postln;
    1.wait;
    "Momento 2".postln;
    2.wait;
    "Momento 3".postln;
});

r.play;

// Routine con sonido (necesita SynthDef \nota)
(
r = Routine({
    var notas = [60, 62, 64, 65, 67];
    notas.do { |nota|
        Synth(\nota, [\freq, nota.midicps]);
        0.4.wait;
    };
}).play;
)

// Routine infinita — SIEMPRE con wait
(
r = Routine({
    inf.do {
        Synth(\nota, [\freq, [60,62,64,67].choose.midicps]);
        0.25.wait;
    };
}).play;
)

r.stop;

/* ---------------------------------------------------------
   2. TEMPOCLOCK
   --------------------------------------------------------- */

t = TempoClock.new(120/60);    // 120 BPM

(
r = Routine({
    inf.do {
        Synth(\nota, [\freq, [60,64,67].choose.midicps]);
        1.wait;    // 1 beat a 120BPM = 0.5 segundos
    };
}).play(t);
)

t.tempo = 160/60;   // cambiar en tiempo real a 160 BPM
t.tempo = 80/60;    // más lento
r.stop;

/* ---------------------------------------------------------
   3. CUANTIZACIÓN — sincronizar múltiples procesos
   --------------------------------------------------------- */

t = TempoClock(120/60);

(
// Arrancan en el próximo compás de 4 beats
r1 = Routine({
    inf.do {
        Synth(\kick);
        1.wait;
    };
}).play(t, quant: 4);

r2 = Routine({
    inf.do {
        Synth(\hihat);
        0.5.wait;
    };
}).play(t, quant: 4);

r3 = Routine({
    inf.do {
        Synth(\nota, [\freq, [60,64,67,71].choose.midicps]);
        Prand([0.25, 0.5, 1], 1).asStream.next.wait;
    };
}).play(t, quant: 4);
)

r1.stop; r2.stop; r3.stop;

/* ---------------------------------------------------------
   4. PBIND — el motor musical
   --------------------------------------------------------- */

// Pbind básico con instrumento default
(
p = Pbind(
    \freq, 440,
    \dur,  0.5
).play;
)
p.stop;

// Pbind con SynthDef propio
(
p = Pbind(
    \instrument, \nota,
    \freq,       440,
    \amp,        0.1,
    \dur,        0.5
).play;
)
p.stop;

/* ---------------------------------------------------------
   5. VALUE PATTERNS
   --------------------------------------------------------- */

// Pseq — secuencia ordenada
(
p = Pbind(
    \instrument, \nota,
    \midinote,   Pseq([60, 62, 64, 65, 67, 69, 71, 72], inf),
    \dur,        0.25
).play;
)
p.stop;

// Prand — aleatorio
(
p = Pbind(
    \instrument, \nota,
    \midinote,   Prand([60, 62, 64, 67, 69], inf),
    \dur,        0.25
).play;
)
p.stop;

// Pxrand — aleatorio sin repetir consecutivos
(
p = Pbind(
    \instrument, \nota,
    \midinote,   Pxrand([60, 62, 64, 67, 69], inf),
    \dur,        0.25
).play;
)
p.stop;

// Pseries — serie aritmética
(
p = Pbind(
    \instrument, \nota,
    \midinote,   Pseries(60, 1, 12),    // 60, 61, 62... 12 pasos
    \dur,        0.2
).play;
)

/* ---------------------------------------------------------
   6. PATTERNS EN TODOS LOS PARÁMETROS
   --------------------------------------------------------- */

(
p = Pbind(
    \instrument, \nota,
    \midinote,   Pseq([60, 62, 64, 67, 69], inf),
    \dur,        Prand([0.125, 0.25, 0.5], inf),
    \amp,        Pseq([0.2, 0.1, 0.1, 0.15, 0.05], inf),
    \pan,        Prand([-0.7, -0.3, 0, 0.3, 0.7], inf),
    \rel,        Prand([0.2, 0.5, 1], inf)
).play;
)
p.stop;

/* ---------------------------------------------------------
   7. COMBINACIONES MATEMÁTICAS
   --------------------------------------------------------- */

// Transposición con Pattern
(
p = Pbind(
    \instrument, \nota,
    \midinote,   Pseq([60, 62, 64], inf) + Prand([0, 12, -12], inf),
    \dur,        0.25
).play;
)
p.stop;

/* ---------------------------------------------------------
   8. PATTERNS ANIDADOS
   --------------------------------------------------------- */

(
p = Pbind(
    \instrument, \nota,
    \midinote, Pseq([
        Pseq([60, 62, 64, 65], 1),   // frase A
        Pseq([67, 69, 71, 72], 1),   // frase B
        Prand([60, 65, 67], 2)       // frase C aleatoria
    ], inf),
    \dur, 0.25
).play;
)
p.stop;

/* ---------------------------------------------------------
   9. DOS VOCES CON TEMPOCLOCK
   --------------------------------------------------------- */

t = TempoClock(100/60);

(
// Voz grave — lenta y estable
p1 = Pbind(
    \instrument, \nota,
    \midinote,   Pseq([36, 38, 40, 43], inf),
    \dur,        1,
    \amp,        0.15,
    \rel,        1.5
).play(t, quant: 4);

// Voz aguda — rápida y aleatoria
p2 = Pbind(
    \instrument, \nota,
    \midinote,   Prand([72, 74, 76, 79, 81], inf),
    \dur,        Prand([0.125, 0.25], inf),
    \amp,        0.08,
    \rel,        0.2
).play(t, quant: 4);
)

p1.stop; p2.stop;

/* ---------------------------------------------------------
   10. BATERÍA CON PATTERNS
   --------------------------------------------------------- */

t = TempoClock(120/60);

(
pKick = Pbind(
    \instrument, \kick,
    \dur,        Pseq([1, 1, 1, 1], inf)
).play(t, quant: 4);

pHihat = Pbind(
    \instrument, \hihat,
    \dur,        0.25
).play(t, quant: 4);

pMel = Pbind(
    \instrument, \nota,
    \midinote,   Prand([60, 62, 64, 67], inf),
    \dur,        Prand([0.25, 0.5, 0.75], inf),
    \amp,        0.08,
    \rel,        0.3
).play(t, quant: 4);
)

pKick.stop;
pHihat.stop;
pMel.stop;
