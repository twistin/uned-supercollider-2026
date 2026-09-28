(
s.quit;
s.options.outDevice = "Monitor_y_Streaming_UNED"; // Tu salida múltiple
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 0; // Para evitar errores de sample rate
s.options.sampleRate = 48000;
s.waitForBoot({
    "SISTEMA LISTO PARA CLASE UNED".postln;
    { SinOsc.ar(440, 0, 0.05) * EnvGen.kr(Env.perc, doneAction: 2) }.play; // Test
});
)
