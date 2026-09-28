/* ================================================================
   SETUP AUDIO UNED: SUPERCOLLIDER + TEAMS
   ================================================================
   INSTRUCCIONES:
   1. Asegúrate de que el Audio MIDI Setup del Mac esté a 48kHz.
   2. Ejecuta el primer bloque para empezar la clase.
   3. Ejecuta el segundo bloque al terminar para usar tu Scarlett sola.
*/

// --- BLOQUE A: INICIO DE CLASE (Monitorización + Streaming) ---
(
s.quit;
s.options.outDevice = "Monitor_y_Streaming_UNED"; // Tu dispositivo de salida múltiple
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 0; // Evita conflictos de Sample Rate con el micro de Teams
s.options.sampleRate = 48000;      // Frecuencia estándar para Teams
s.waitForBoot({
    "=========================================".postln;
    " SERVIDOR CONFIGURADO PARA CLASE UNED ".postln;
    " Escuchas por: Scarlett 2i2 ".postln;
    " Envías a Teams por: BlackHole ".postln;
    "=========================================".postln;

    // Test rápido de sonido (un pitido percusivo)
    { SinOsc.ar(440, 0, 0.05) * EnvGen.kr(Env.perc, doneAction: 2) }.play;
});
)


// --- BLOQUE B: VOLVER A LA NORMALIDAD (Solo Scarlett) ---
/*
(
s.quit;
s.options.outDevice = "Scarlett 2i2 USB";
s.options.numInputBusChannels = 2;
s.options.sampleRate = nil; // O 44100 si es tu estándar personal
s.boot;
)
*/