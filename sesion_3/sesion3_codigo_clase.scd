/* =========================================================
   SuperCollider — Código de Sesión 3
   Módulo 1: Componer con código
   Sesión 3: El servidor de audio y los UGens
   =========================================================

   INSTRUCCIONES:
   - Arranca el servidor ANTES de evaluar cualquier bloque de sonido
   - Usa Cmd/Ctrl + . para parar el sonido en cualquier momento
   - Evalúa un bloque, escucha, luego para y evalúa el siguiente

*/

/* ---------------------------------------------------------
   0. ARRANCAR EL SERVIDOR
   --------------------------------------------------------- */

s.boot;
s.meter;      // nivel de entrada/salida
s.scope;      // osciloscopio

/* ---------------------------------------------------------
   1. OSCILADORES BÁSICOS
   --------------------------------------------------------- */

{ SinOsc.ar(440) * 0.1 }.play;        // seno puro
{ Saw.ar(440) * 0.1 }.play;           // diente de sierra
{ Pulse.ar(440) * 0.1 }.play;         // onda cuadrada
{ Pulse.ar(440, 0.2) * 0.1 }.play;    // cuadrada con ancho de pulso 20%
{ LFTri.ar(440) * 0.1 }.play;         // triángulo

// Visualizar sin sonido
{ SinOsc.ar(440) }.plot(0.01);
{ Saw.ar(440) }.plot(0.01);
{ Pulse.ar(440) }.plot(0.01);

/* ---------------------------------------------------------
   2. GENERADORES DE RUIDO
   --------------------------------------------------------- */

{ WhiteNoise.ar * 0.05 }.play;     // todos los armónicos igual
{ PinkNoise.ar * 0.05 }.play;      // más energía en graves
{ BrownNoise.ar * 0.05 }.play;     // todavía más grave

/* ---------------------------------------------------------
   3. CONTROL DE AMPLITUD
   --------------------------------------------------------- */

// Multiplicación directa
{ SinOsc.ar(440) * 0.1 }.play;     // 10% de amplitud

// Con decibelios
{ SinOsc.ar(440) * (-20).dbamp }.play;   // -20 dB
{ SinOsc.ar(440) * (-6).dbamp }.play;    // -6 dB  (más fuerte)
{ SinOsc.ar(440) * (-30).dbamp }.play;   // -30 dB (más suave)

/* ---------------------------------------------------------
   4. TASAS: .ar y .kr
   --------------------------------------------------------- */

// .ar (audio rate) → va al altavoz
// .kr (control rate) → para modulaciones lentas

// LFO a kr modulando frecuencia a ar
{
    var lfo, sig;
    lfo = SinOsc.kr(0.5).range(200, 800);   // oscila entre 200 y 800 Hz
    sig = SinOsc.ar(lfo) * 0.1;
    sig
}.play;

// .range — convierte [-1,1] al rango que necesitas
{
    var freq;
    freq = LFNoise1.kr(1).range(200, 800);  // más musical que SinOsc
    SinOsc.ar(freq) * 0.1
}.play;

/* ---------------------------------------------------------
   5. MODULADORES DE BAJA FRECUENCIA (LFO)
   --------------------------------------------------------- */

// LFNoise0 — saltos bruscos
{ SinOsc.ar(LFNoise0.kr(4).range(200, 800)) * 0.1 }.play;

// LFNoise1 — interpolación lineal (más suave)
{ SinOsc.ar(LFNoise1.kr(2).range(200, 800)) * 0.1 }.play;

// LFNoise2 — interpolación curvada
{ SinOsc.ar(LFNoise2.kr(2).range(200, 800)) * 0.1 }.play;

/* ---------------------------------------------------------
   6. CONTROL EN TIEMPO REAL CON ARGUMENTOS
   --------------------------------------------------------- */

// Función con argumentos y referencia guardada
(
x = {
    arg freq = 440, amp = 0.1;
    SinOsc.ar(freq) * amp
}.play;
)

x.set(\freq, 660);
x.set(\amp, 0.05);
x.set(\freq, 880, \amp, 0.15);
x.free;   // liberar

// Con lag — transiciones suaves
(
x = {
    arg freq = 440, amp = 0.1;
    SinOsc.ar(freq.lag(1)) * amp.lag(0.3)
}.play;
)

x.set(\freq, 880);    // glissando de 1 segundo
x.set(\freq, 220);
x.free;

/* ---------------------------------------------------------
   7. ESTÉREO
   --------------------------------------------------------- */

// Array de dos señales = estéreo
{
    SinOsc.ar([440, 441]) * 0.1    // L: 440, R: 441 → batido
}.play;

// Pan2 — panorámica
{
    Pan2.ar(SinOsc.ar(440), SinOsc.kr(0.3)) * 0.1  // auto-pan
}.play;

/* ---------------------------------------------------------
   8. ENVOLVENTES
   --------------------------------------------------------- */

// Visualizar envolventes
Env.perc(0.01, 1).plot;
Env.adsr(0.1, 0.2, 0.8, 0.5).plot;
Env.new([0, 1, 0.5, 0], [0.1, 0.3, 0.5]).plot;

// EnvGen — ejecutar la envolvente como señal
{
    var env, sig;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    sig = SinOsc.ar(440) * env * 0.3;
    sig ! 2   // estéreo
}.play;

// Atajo moderno: Env.kr
{
    SinOsc.ar(440)
    * Env.perc(0.05, 1.5).kr(2)
    * 0.3 ! 2
}.play;

// Lanzar varios sonidos independientes
{ SinOsc.ar(440) * Env.perc(0.01, 0.3).kr(2) * 0.2 ! 2 }.play;
{ SinOsc.ar(550) * Env.perc(0.01, 0.3).kr(2) * 0.2 ! 2 }.play;
{ SinOsc.ar(660) * Env.perc(0.01, 0.3).kr(2) * 0.2 ! 2 }.play;
{ SinOsc.ar(770) * Env.perc(0.01, 0.3).kr(2) * 0.2 ! 2 }.play;

/* ---------------------------------------------------------
   9. PRIMER INSTRUMENTO COMPLETO
   --------------------------------------------------------- */

(
~tono = { |freq = 440, amp = 0.2, atk = 0.01, rel = 1|
    var env, sig;
    env = EnvGen.kr(Env.perc(atk, rel), doneAction: 2);
    sig = SinOsc.ar(freq) * env * amp;
    sig ! 2
};
)

// Lanzar con distintos parámetros
~tono.(440).play;
~tono.(660).play;
~tono.(880, 0.1, 0.1, 2).play;

// Lanzar una melodía manual
(
[60, 64, 67, 72].do { |nota|
    ~tono.(nota.midicps, 0.15, 0.01, 0.5).play;
    0.5.wait;
}
)
// ↑ Esto da error fuera de Routine — lo arreglaremos en la Sesión 5
// Por ahora usa .play por separado:

~tono.(60.midicps, 0.15).play;
~tono.(64.midicps, 0.15).play;
~tono.(67.midicps, 0.15).play;
~tono.(72.midicps, 0.15).play;
