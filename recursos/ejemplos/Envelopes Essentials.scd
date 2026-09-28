/* =========================================================
   SuperCollider – Envelopes Essentials
   Cuaderno de trabajo (.scd)
   =========================================================

   Una envolvente describe cómo cambia un valor en el tiempo.
   En SuperCollider se usa principalmente para controlar
   amplitud, frecuencia, filtros y otros parámetros.

   Envolvente (Env) -> descripción
   EnvGen          -> ejecución de la envolvente
*/

/* ---------------------------------------------------------
   1. Env y EnvGen (concepto básico)
   ---------------------------------------------------------

   Env: define la forma
   EnvGen: la ejecuta en el tiempo
*/

Env.perc;   // solo descripción, no suena

/* ---------------------------------------------------------
   2. Envolvente mínima (amplitud)
   --------------------------------------------------------- */

{
    var env;
    env = EnvGen.kr(
        Env.perc(0.01, 1),
        doneAction: 2
    );
    SinOsc.ar(440) * env * 0.2
}.play;

/* ---------------------------------------------------------
   3. Tipos de envolventes predefinidas
   --------------------------------------------------------- */

// Percusiva (ataque corto, caída)
Env.perc(0.01, 1);

// Lineal simple
Env.linen(0.1, 1, 0.5);

// ADSR clásica
Env.adsr(0.01, 0.2, 0.6, 1);

/* ---------------------------------------------------------
   4. EnvGen: argumentos importantes
   ---------------------------------------------------------

   gate       -> activa / libera la envolvente
   levelScale -> escala de amplitud
   timeScale  -> escala de tiempo
   doneAction -> qué hacer al terminar
*/

EnvGen.kr(
    Env.perc,
    gate: 1,
    doneAction: 2
);

/* ---------------------------------------------------------
   5. Envolvente sostenida con gate
   --------------------------------------------------------- */

(
{
    var env, sig;
    env = EnvGen.kr(
        Env.adsr(0.01, 0.2, 0.5, 1),
        gate: 1
    );
    sig = Saw.ar(220) * env * 0.1;
    sig
}.play;
)

/* ---------------------------------------------------------
   6. Liberar una envolvente (gate = 0)
   --------------------------------------------------------- */

x = {
    var env;
    env = EnvGen.kr(
        Env.adsr(0.01, 0.2, 0.5, 1),
        gate: 1,
        doneAction: 2
    );
    SinOsc.ar(440) * env * 0.2
}.play;

// liberar
x.set(\gate, 0);

/* ---------------------------------------------------------
   7. Envolventes personalizadas
   --------------------------------------------------------- */

// Niveles + tiempos
Env(
    levels: [0, 1, 0.5, 0],
    times:  [0.01, 0.3, 1]
);

/* ---------------------------------------------------------
   8. Curvas de la envolvente
   ---------------------------------------------------------

   0      -> lineal
   -4     -> curva exponencial suave
   4      -> curva rápida
*/

Env(
    [0, 1, 0],
    [0.01, 1],
    curve: -4
);

/* ---------------------------------------------------------
   9. Envolvente aplicada a otros parámetros
   --------------------------------------------------------- */

// Filtro
{
    var env, sig;
    env = EnvGen.kr(
        Env.perc(0.01, 1),
        doneAction: 2
    );
    sig = Saw.ar(220);
    LPF.ar(sig, env.range(200, 3000)) * 0.1
}.play;

/* ---------------------------------------------------------
   10. Envolvente en frecuencia
   --------------------------------------------------------- */

{
    var env;
    env = EnvGen.kr(
        Env.perc(0.01, 1),
        doneAction: 2
    );
    SinOsc.ar(env.range(200, 800)) * 0.1
}.play;

/* ---------------------------------------------------------
   11. Envolventes multicanal
   --------------------------------------------------------- */

{
    var env;
    env = EnvGen.kr(Env.perc, doneAction: 2);
    SinOsc.ar([440, 660]) * env * 0.1
}.play;

/* ---------------------------------------------------------
   12. timeScale y levelScale
   --------------------------------------------------------- */

EnvGen.kr(
    Env.perc,
    timeScale: 2,    // el doble de duración
    levelScale: 0.5  // mitad de amplitud
);

/* ---------------------------------------------------------
   13. Comparación: sin / con envolvente
   --------------------------------------------------------- */

// Sin envolvente (sonido continuo)
{ SinOsc.ar(440) * 0.1 }.play;

// Con envolvente (sonido con forma)
{
    SinOsc.ar(440)
    * EnvGen.kr(Env.perc, doneAction: 2)
    * 0.1
}.play;

/* ---------------------------------------------------------
   Ideas clave:
   - La envolvente da forma al sonido
   - Sin envolvente, el sonido no "respira"
   - Env describe, EnvGen ejecuta
   - doneAction: 2 libera el Synth

   Regla práctica:
   Si un sonido no se detiene,
   revisa gate y doneAction
   --------------------------------------------------------- */
