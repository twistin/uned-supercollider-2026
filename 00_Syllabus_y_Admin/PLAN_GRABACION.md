# Plan de grabación — SuperCollider, UNED Vigo

> **Criterio confirmado por la UNED (28-09-2026):** una única grabación por sesión.

---

## Decisión de formato

Para la sesión 1 propongo una **grabación continua de aproximadamente 120 minutos**, organizada pedagógicamente en diez bloques internos de entre 10 y 13 minutos. Cada bloque se anuncia oralmente, muestra una operación concreta y termina indicando qué probar. El alumnado puede detener la reproducción y continuar después; no se detiene y reinicia la grabación de Teams entre bloques. Las pausas que haga para repetir ejercicios son tiempo adicional al metraje.

No dejar minutos de silencio ante un cartel «pausa». La grabación demuestra y propone; el alumnado pausa voluntariamente. Añadir un índice con marcas de tiempo en el handout y, si está habilitada esa opción en el reproductor de la cuenta institucional, capítulos a la misma grabación. La respuesta de la UNED descarta varios archivos por sesión; este plan reemplaza la propuesta anterior de clips.

---

## Secuencia de los dos módulos

| Sesión | Resultado comprobable | Estructura en la grabación única | Descarga/práctica |
|--------|----------------------|----------------------------------|-------------------|
| 1. Entorno y lenguaje | Arranca el servidor, evalúa expresiones, altera un oscilador, usa ayuda | 10 bloques de 10–13 min | Handout, sesion_1_codigo.scd, autocontrol |
| 2. Material musical | Genera y transforma una colección de alturas con función y azar acotado | 8–10 bloques | .scd con ejercicios escalonados y solución |
| 3. Servidor y UGens | Construye un sonido con oscilador, ruido, filtro y envolvente | 8–10 bloques | .scd, guía de audición, mini patch |
| 4. SynthDef y Synth | Define un instrumento reutilizable y controla sus parámetros | 8–10 bloques | .scd, mapa de flujo y retos |
| 5. Patterns | Secuencia alturas, duraciones y dinámicas con tempo explícito | 8–10 bloques | .scd por capas y escucha comparada |
| 6. Live coding | Construye una pieza breve desde el silencio y la cierra | 8–10 bloques | plantilla de proyecto, rúbrica de autoevaluación |

**Para cada sesión:**
1. Orientación al comienzo de la grabación
2. Bloques de demostración y práctica dentro del mismo vídeo
3. Un solo archivo `.scd` con secciones en el mismo orden
4. Handout con índice de tiempos y conceptos esenciales
5. Tarea de 15–25 minutos con solución o criterios de comprobación
6. Canal claro de dudas

La propuesta personal de la sesión 6 se entrega como código y audio o vídeo breve; no se «presenta en directo» si no hay encuentro síncrono. En las fichas y syllabus, sustituir «práctica colectiva», «ritmo adaptado al grupo», «participación activa en sesiones» y «presentación» por estas acciones asincrónicas. No prometer feedback individual si la organización no lo ha previsto.

---

## Escaleta de la Sesión 1: una grabación de 120 minutos

| Bloque | Inicio previsto | Duración | Contenido en pantalla | Acción del estudiante al acabar |
|--------|----------------:|----------|----------------------|---------------------------------|
| 01. Primer sonido | 00:00 | 10 min | Objetivo, volumen, `s.boot`, primera línea de audio, parada | Repetir y cambiar 440 por 330 |
| 02. Conocer el IDE | 10:00 | 10 min | Editor, Post Window, ayuda, servidor, guardar .scd | Localizar cada zona |
| 03. Tres piezas | 20:00 | 12 min | IDE → lenguaje → servidor; número sin servidor y sonido con él | Explicar en una frase qué hace cada una |
| 04. Expresiones | 32:00 | 12 min | `4.squared`, `.neg`, valor de retorno, `.postln` | Predecir `7.squared - 1` |
| 05. Leer y ejecutar | 44:00 | 12 min | Punto, paréntesis, `;`, comentarios, selección, línea y región | Ejecutar tres líneas por separado |
| 06. Variables | 56:00 | 13 min | `x = 4;`, reasignación, `var` dentro de región | Modificar un valor y explicar el resultado |
| 07. Tipos útiles | 1:09:00 | 13 min | `7`, `7.0`, `"hola"`, `\tono`, `true`; `.class` | Identificar cuatro tipos |
| 08. Ayuda y error | 1:22:00 | 12 min | Ayuda en SinOsc, freq, error inocuo | Encontrar un argumento |
| 09. Volver al sonido | 1:34:00 | 13 min | Frecuencia, amplitud, `x = { ... }.play`, `x.free` | Crear dos versiones y describirlas |
| 10. Reto y cierre | 1:47:00 | 13 min | Reto, repaso lenguaje/servidor y anticipo de arrays | Autocontrol y guardar archivo |
| **Total** | **2:00:00** | **120 min** | | |

> Las marcas son previstas: anotar los tiempos reales durante o después de grabar y actualizar el índice antes de publicarlo. No hay que forzar el ritmo para coincidir con cada minuto. Si falta contenido para dos horas, ampliar la práctica modelada y la audición en los bloques 06–09, sin relleno.

---

## Guion operativo para cada bloque dentro del vídeo

- **Entrada breve:** anunciar «Bloque 4: expresiones» y el resultado («Al terminar esta parte podrás...»)
- **Demostración:** mostrar la pantalla del IDE, escribir o ejecutar un bloque, explicar lo que cambia al oído o en Post Window
- **Predicción:** formular una pregunta antes de ejecutar la variante
- **Comprobación:** ejecutar, interpretar el resultado y mostrar cómo detener o restablecer
- **Transición breve:** «Puedes pausar la reproducción para probar X. A continuación vamos a Y». Continuar grabando sin detener la reunión

Una toma fallida real y breve es útil si enseña a leer el error.

---

## Ruta principal: una grabación por sesión en Teams

1. Entrar en la aplicación de escritorio con la cuenta institucional, crear una reunión de prueba («Grabación SuperCollider · sesión 1»)
2. Comprobar que **Más acciones → Grabar y transcribir → Iniciar grabación** está disponible. Si no aparece, la licencia, el rol o la política de grabación pueden necesitar ajuste por parte de la UNED
3. Elegir **una sola** ruta de audio (ver `GUIA_SETUP_AUDIO_STREAMING.md`):
   - **A (recomendada, la del setup actual):** micrófono *Clase UNED* (Scarlett + BlackHole), SuperCollider hacia *Monitor_y_Streaming_UNED*, y **sin** «Incluir sonido» al compartir.
   - **B:** micrófono Scarlett 2i2 y activar **Incluir sonido** al compartir. En Mac, Teams puede pedir instalar su controlador de audio y conceder permisos de captura.
4. Compartir la pantalla o ventana del IDE. Activar el **modo de música de alta fidelidad** para que la supresión de ruido no recorte la síntesis
5. **Prueba de 60–90 segundos:** hablar, ejecutar un seno suave, detener el seno, terminar la grabación y escuchar el archivo procesado. Voz y sintetizador deben estar en la grabación, sin eco ni audio duplicado
6. Activar **No molestar** antes de compartir pantalla (las notificaciones también se capturan)

En la sesión definitiva, iniciar una vez la grabación, impartir los diez bloques con transiciones orales y detenerla solo al final.

**Red de seguridad en SuperCollider (`inicio_clase.scd`, BLOQUE C):**
- Limitador en la salida que se repone solo tras `Cmd+.` o `s.reboot`: ningún ejemplo puede saturar la única toma.
- En las sesiones 1–3 los ejemplos mono se envían a los dos canales de la grabación (si no, el vídeo solo sonaría por el oído izquierdo).
- Ventana «Grabación» con cronómetro: *Empezar* al ver que Teams graba, *Siguiente bloque* al anunciar cada bloque. Indica si vas adelantado o tarde respecto a esta escaleta y guarda en cada pulsación `INDICE_SESION_N_<fecha>.md` con los tiempos reales, listo para el handout y los capítulos.

**Si algo falla durante la toma:** leer el error en voz alta (es contenido); si no se resuelve en un minuto, pasar al ejemplo siguiente; sonido colgado → `Cmd+.`; servidor caído → `s.reboot` (el limitador vuelve solo); Teams se cae → volver a entrar, reanudar la grabación e informar a la UNED.

Las grabaciones ordinarias se guardan en OneDrive del organizador (o en SharePoint si son reuniones de canal). Esperar al procesamiento, renombrar por ejemplo `M1_S01_EntornoYLenguaje`, revisar el principio/final y verificar permisos del alumnado antes de publicar el enlace. Añadir el índice de tiempos reales al handout y, si el reproductor lo permite, capítulos manuales.

> No usar el dispositivo agregado como micrófono a la vez que «Incluir sonido» sin una prueba: podrías enviar el sonido de SuperCollider por dos rutas.

---

## Ruta alternativa: grabación local con OBS en Mac M1 Pro

Si Teams no conserva bien el sonido o necesitas más control: SuperCollider + Scarlett 2i2 + micrófono + **OBS Studio**.

En macOS 13 o posterior, OBS 30+ puede capturar audio del escritorio con **macOS Audio Capture**, junto con la fuente de micrófono. Captura el escritorio completo, no solo la aplicación IDE: el servidor `scsynth` es un proceso separado. No poner el mismo audio en dos fuentes de OBS: se duplicaría o produciría eco.

**OBS, escena única:**
- Captura de pantalla a 1920×1080 y 30 fps
- Texto del editor suficientemente grande para verse en un portátil
- Fuente de audio del escritorio + entrada de micrófono Scarlett

**Formato:** grabar en MKV y remultiplexar a MP4 H.264/AAC si se requiere. Conservar el original hasta comprobar el MP4. Nombre: `M1_S01_EntornoYLenguaje.mp4`.

**Prueba de 90 segundos obligatoria:** decir una frase mientras suena un seno a bajo volumen, parar el sonido, reproducir el archivo local con auriculares y comprobar voz, síntesis, sincronía y texto legible.

---

## Si necesitas BlackHole

Primero prueba la captura nativa de OBS. Si no funciona:
1. Configurar Scarlett + BlackHole en salida múltiple de macOS
2. Seleccionar esa salida para SuperCollider o el sistema
3. Capturar BlackHole en OBS + voz Scarlett como fuente distinta

Si se cambia el dispositivo del servidor, salir de él y arrancarlo de nuevo antes de grabar. Mantener **48 kHz** en todos los dispositivos.

---

## Preparación, grabación y publicación

**Antes:** comprobar versión de macOS; abrir Teams y SuperCollider; abrir `sesion_1_codigo.scd`; cerrar mensajes, correo y ventanas con datos personales; disponer agua y guion; fijar tamaño de letra y niveles.

**Durante:** una sola grabación continua; anunciar cada bloque y apuntar su tiempo de entrada; ante un tropiezo menor, corregirlo con naturalidad sin reiniciar.

**Después:** revisar inicio, varios pasajes con audio y final; publicar juntos el vídeo, handout y `.scd`; comprobar acceso desde cuenta de estudiante; actualizar el índice con marcas de tiempo reales.

**Seguimiento asincrónico:** foro o buzón para dudas; mini entrega al final de cada sesión; soluciones diferidas o autocorrección. Indicar plazo de respuesta solo si se ha acordado.

---

## Cambios concretos recomendados en los textos iniciales

- Mantener el «primer sonido en cinco minutos» como gancho, pero prever arranque/selección de audio y volumen
- Aplazar el árbol de herencia detallado y `~variables` para la sesión 2 o un recuadro opcional
- Sustituir la tabla rígida de posiciones del IDE por identificación funcional
- Usar un error de nombre diagnosticable en Post Window en lugar de `4.pow;`
- Unificar atajos: `Shift+Return` (línea/selección), `Cmd/Ctrl+Return` (región), `Cmd/Ctrl+D` (ayuda), `Cmd/Ctrl+.` (parar)
- Corregir la ficha: modalidad online asincrónica, ejercicios individuales, dos módulos independientes administrativamente

---

## Fuentes técnicas consultadas (28-09-2026)

- [SuperCollider IDE, evaluación, ayuda y parada](https://doc.sccode.org/Guides/SCIde.html)
- [Teams: iniciar, detener y localizar grabaciones](https://support.microsoft.com/en-us/teams/meetings/start-stop-and-find-meeting-recordings-in-microsoft-teams)
- [Teams: compartir sonido del ordenador (requisitos Mac)](https://support.microsoft.com/en-us/teams/meetings/share-sound-from-your-computer-in-microsoft-teams-meetings-or-live-events)
- [Teams: clips de chat limitados a un minuto](https://support.microsoft.com/en-us/teams/chat/record-a-video-or-audio-clip-in-microsoft-teams)
- [Capítulos manuales en el reproductor de Microsoft 365](https://support.microsoft.com/en-us/clipchamp/stream-pages/creating-and-managing-chapters-for-videos-in-the-clipchamp-player)
- [OBS: captura de audio en macOS](https://obsproject.com/kb/macos-desktop-audio-capture-guide)
- [OBS: formatos de grabación](https://obsproject.com/kb/audio-video-formats-guide)
- [BlackHole: rutas de audio](https://existential.audio/blackhole/support/)
