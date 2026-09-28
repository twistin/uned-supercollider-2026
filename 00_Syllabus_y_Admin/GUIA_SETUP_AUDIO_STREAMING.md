# 🎙️ Guía de Configuración Audio: SuperCollider + Teams (UNED)

Esta guía detalla los pasos necesarios para configurar el streaming de audio de alta calidad durante las sesiones del curso.

---

## 1. Antes de empezar la clase (Setup Streaming)

### 🔊 Audio MIDI Setup (macOS)
*   Abre la aplicación **Configuración de Audio MIDI**.
*   Asegúrate de que todos los dispositivos involucrados (**Scarlett 2i2, BlackHole, Clase UNED, Monitor**) estén configurados a una frecuencia de muestreo de **48,000 Hz**.

### 👥 Microsoft Teams
*   **Configuración de Dispositivos:**
    *   **Micrófono:** Clase UNED (Dispositivo agregado).
    *   **Altavoz:** Scarlett 2i2.
*   **Modo de Música:** Una vez iniciada la reunión, activa el **Modo de música de alta fidelidad** (clic en el icono de la nota musical).
*   **Compartir Pantalla:** Al compartir el IDE de SuperCollider, **NO** marques **"Incluir sonido del sistema"**. El sonido de SuperCollider ya entra por el micrófono *Clase UNED* (vía BlackHole); si además activas «Incluir sonido», llega por dos caminos y se oye duplicado o con eco en la grabación.
*   **Una sola ruta:** o bien *Clase UNED* como micrófono (esta guía), o bien Scarlett como micrófono + «Incluir sonido». Nunca las dos a la vez.

### ✅ Prueba obligatoria antes de la primera sesión
Graba 90 segundos en una reunión de prueba: habla, ejecuta `{ SinOsc.ar(440, 0, 0.1) }.play;` (mono, como en la sesión 1), páralo, ejecuta un ejemplo con ruido (`{ PinkNoise.ar * 0.05 }.play;`) y termina. Escucha el archivo procesado con auriculares: voz y síntesis presentes, sin eco, sin cortes en el ruido y en los dos oídos.

### 🎹 SuperCollider
*   Abre SuperCollider y ejecuta en `inicio_clase.scd` el **BLOQUE A** (rutea el audio hacia el cable virtual) y el **BLOQUE C** (limitador de seguridad + ventana de bloques para la grabación). Cambia `~sesion` en el BLOQUE C antes de cada clase.

---

## 2. Al terminar la clase (Volver a la normalidad)

### 🔌 Reset de Audio
*   **SuperCollider:** Ejecuta el **BLOQUE B** de `inicio_clase.scd` para volver a usar la Scarlett como dispositivo de salida directo.
*   **Microsoft Teams:** Si vas a realizar llamadas normales, recuerda volver a cambiar el **Micrófono** a *Scarlett 2i2* o *Micrófono del MacBook*. De lo contrario, los demás oirán el silencio del cable virtual.
*   **Frecuencia (Opcional):** Puedes devolver los dispositivos a **44.1 kHz** si tus proyectos personales o sesiones de grabación lo requieren.

---
*Documento generado por Twistin — Febrero 2026*
