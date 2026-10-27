# SuperCollider — Cursos de Extensión Universitaria UNED Vigo
## Música algorítmica, síntesis y live coding con SuperCollider

Materiales docentes de las actividades formativas impartidas en el **Aula UNED Vigo** por **Silvino Carrasco**.

El programa se estructura en dos cursos independientes de 6 horas lectivas cada uno (modalidad online en diferido), ofertados a través del portal de Extensión Universitaria de la UNED:

1. **[Curso I (Actividad 55585): Introducción a la música algorítmica con SuperCollider](https://extension.uned.es/actividad/idactividad/55585)** *(Noviembre – Diciembre 2026)*
2. **[Curso II (Actividad 55587): Síntesis, patterns y live coding con SuperCollider](https://extension.uned.es/actividad/idactividad/55587)** *(Enero 2027)*

---

## Estructura del repositorio

```
00_ADMIN/
├── FICHA_PRESENTACION_UNED.md          Textos informativos del catálogo UNED
├── GUIA_SETUP_AUDIO_STREAMING.md       Configuración de audio Scarlett + Teams / OBS
├── PLAN_GRABACION.md                   Plan técnico y escaleta de grabación
├── syllabus.md                         Syllabus académico de los dos cursos
└── imágenes                            Imágenes oficiales de difusión

CURSO_1_INTRODUCCION_MUSICA_ALGORITMICA/ (Actividad 55585 · 6 horas)
├── 01_SESION_1_PRIMER_CONTACTO/        Primer contacto: hacer sonido con código (21 nov)
│   ├── SESION_1_GUION_DOCENTE.md       Escaleta de grabación en 10 bloques con tiempos
│   ├── SESION_1_LOCUCION_DOCENTE_COMPLETA.md  Texto docente detallado de locución
│   ├── SESION_1_HANDOUT_ESTUDIANTES.md Handout paso a paso para el alumnado
│   ├── sesion1_codigo_clase.scd        Script ejecutable de clase
│   └── tarea_sesion1.md                Enunciado del ejercicio práctico
├── 02_SESION_2_DATOS_Y_PROCESOS/       Datos y procesos musicales (28 nov)
│   ├── SESION_2_HANDOUT_ESTUDIANTES.md Handout de arrays, funciones e iteración
│   ├── sesion2_codigo_clase.scd        Script ejecutable de clase
│   └── tarea_sesion2.md                Enunciado del ejercicio práctico
└── 03_SESION_3_DEL_EXPERIMENTO_AL_INSTRUMENTO/ Del experimento al instrumento (05 dic)
    ├── SESION_3_HANDOUT_ESTUDIANTES.md Handout de UGens, envolventes y síntesis
    ├── sesion3_codigo_clase.scd        Script ejecutable de clase
    └── tarea_sesion3.md                Enunciado del ejercicio práctico

CURSO_2_SINTESIS_PATTERNS_LIVECODING/ (Actividad 55587 · 6 horas)
├── 01_SESION_4_DISENAR_INSTRUMENTOS/   Diseñar instrumentos y controlar el sonido
│   ├── SESION_4_HANDOUT_ESTUDIANTES.md Handout de SynthDef, Synth y ADSR
│   └── sesion4_codigo_clase.scd        Script ejecutable de clase
├── 02_SESION_5_TIEMPO_ROUTINES_PATTERNS/ Tiempo, Routines y Patterns
│   ├── SESION_5_HANDOUT_ESTUDIANTES.md Handout de Pbind, TempoClock y Value Patterns
│   ├── sesion5_codigo_clase.scd        Script ejecutable de clase
│   └── tarea_sesiones4y5.md            Enunciado de ejercicios combinados
└── 03_SESION_6_LIVECODING_PROYECTO_FINAL/ Live coding y proyecto final
    ├── SESION_6_HANDOUT_ESTUDIANTES.md Handout de NodeProxy, Ndef y live coding
    ├── sesion6_codigo_clase.scd        Script ejecutable de clase
    └── proyecto_final.md               Guía y rúbrica del proyecto final

recursos/
├── inicio_clase.scd                    Panel de control previo a la grabación
├── cheatsheets/                        Guías rápidas (Arrays, UGens, Envolventes, Métodos)
└── ejemplos/                           Archivos .scd de referencia complementaria
```

---

## Requisitos técnicos

- **SuperCollider** 3.12 o superior ([descarga oficial](https://supercollider.github.io/))
- Sistema operativo: macOS, Windows o Linux
- Auriculares para monitorización de audio

---

## Licencia

Materiales educativos de libre uso con atribución.  
[Creative Commons BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
