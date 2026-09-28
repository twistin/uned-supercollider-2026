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
*   **Compartir Pantalla:** Al compartir el IDE de SuperCollider, recuerda marcar la casilla **"Incluir sonido del sistema"**.

### 🎹 SuperCollider
*   Abre SuperCollider y ejecuta el código contenido en el archivo `inicio_clase.scd` para rutear el audio correctamente hacia el cable virtual.

---

## 2. Al terminar la clase (Volver a la normalidad)

### 🔌 Reset de Audio
*   **SuperCollider:** Ejecuta el bloque de código etiquetado como **"Setup Normal"** en tu archivo `.scd` para volver a usar la Scarlett como dispositivo de salida directo.
*   **Microsoft Teams:** Si vas a realizar llamadas normales, recuerda volver a cambiar el **Micrófono** a *Scarlett 2i2* o *Micrófono del MacBook*. De lo contrario, los demás oirán el silencio del cable virtual.
*   **Frecuencia (Opcional):** Puedes devolver los dispositivos a **44.1 kHz** si tus proyectos personales o sesiones de grabación lo requieren.

---
*Documento generado por Twistin — Febrero 2026*
