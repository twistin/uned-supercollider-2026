# Módulo 1 · Sesión 1: Primer contacto — hacer sonido con código
## Guion docente detallado y texto de locución para la grabación

> **Curso:** Introducción a la música algorítmica con SuperCollider (Actividad UNED 55585)  
> **Sesión:** 1 (Sábado, 21 de noviembre) · 2 horas  
> **Profesor:** Silvino Carrasco — Aula UNED Vigo  
> **Formato:** Grabación continua única organizada en 10 bloques pedagógicos internos.  
> **Material adaptado de:** Eli Fieldsteel (MUS 499C, UIUC / Chapter 1), reordenado pedagógicamente para situar el sonido en el primer bloque.

---

### Bloque 01 · Primer sonido inmediato · 10 min · desde 00:00

> **En pantalla:** Editor de SuperCollider y Post Window visibles. Fuente ampliada.

Bienvenidos a este primer curso de iniciación a la creación sonora y música algorítmica con SuperCollider en el Aula UNED Vigo. 

Antes de detenernos en la sintaxis, en la teoría de programación orientada a objetos o en la arquitectura del software, vamos a conseguir un sonido. Esta es la mejor forma de comprobar que el sistema funciona y de perderle el respeto al código.

Aseguraos de tener los auriculares conectados y el volumen del ordenador a un nivel prudente. 

En el editor escribimos:

```supercollider
s.boot;
```

Situamos el cursor en esa línea y pulsamos `Shift + Return`. En la Post Window vemos una serie de mensajes del sistema y, al final, una confirmación en verde: el servidor de audio está listo.

Ahora evaluamos nuestro primer oscilador:

```supercollider
{ SinOsc.ar(440, 0, 0.1) }.play;
```

Pulsamos `Shift + Return` y escuchamos una onda senoidal pura a 440 Hz.

Fijaos en dos datos esenciales: `440` es la frecuencia —la altura del tono en hercios— y `0.1` es la amplitud, es decir, el volumen, que mantendremos siempre entre cero y uno para proteger nuestros oídos.

Para detener el sonido usamos el atajo de parada de emergencia: **`Cmd + .`** en Mac o **`Ctrl + .`** en Windows y Linux. 

Si cambiamos `440` por `330`, el tono baja; si ponemos `660`, sube. 

> **Transición oral:** «Puedes pausar el vídeo, probar 660 y detener el audio. Ahora que sabemos que el motor de audio responde y sabemos cómo silenciarlo en cualquier momento, vamos a entender la interfaz en la que trabajaremos.»

---

### Bloque 02 · Conocer el entorno (IDE) · 10 min · desde 10:00

> **En pantalla:** Recorrido por el editor, la Post Window, el panel de ayuda y la barra de estado.

La ventana que tenemos delante es el entorno de desarrollo integrado (el IDE de SuperCollider). Aunque parece una única aplicación, se divide en varias zonas con funciones muy distintas:

1. **El editor de código:** El área principal donde escribimos, guardamos y ejecutamos nuestros documentos (`.scd`).
2. **La Post Window:** El panel que actúa como terminal de respuesta. Aquí SuperCollider imprime los resultados de las operaciones, pero también las advertencias y los mensajes de error. Si algo falla, la solución casi siempre está escrita aquí.
3. **El navegador de ayuda:** Un visor web integrado que contiene la documentación oficial, guías y ejemplos ejecutables.
4. **La barra de estado:** En la esquina inferior derecha, donde comprobamos en todo momento si el servidor está activo (`booted`), el porcentaje de uso de CPU y el número de procesos de síntesis en marcha.

Los paneles se pueden desacoplar, redimensionar o mover. Lo importante no es su posición geométrica en pantalla, sino entender su función: en el editor escribimos; en la Post Window leemos lo que el sistema nos devuelve.

Hagamos una prueba mínima en el editor:

```supercollider
2 + 3;
```

Pulsamos `Shift + Return`. Inmediatamente la Post Window responde con un `5`.

> **Transición oral:** «Localiza los cuatro elementos en tu propia pantalla. Esta suma tan sencilla nos lleva a una pregunta clave: ¿por qué ha funcionado ese cálculo aunque el servidor de audio estuviese apagado? La respuesta está en la estructura interna de SuperCollider.»

---

### Bloque 03 · Tres piezas que cooperan · 12 min · desde 20:00

> **En pantalla:** Demostración con servidor parado vs. servidor encendido.

SuperCollider no es un único programa monolítico; son **tres programas independientes** que colaboran de manera transparente:

1. **El IDE:** La interfaz gráfica que estamos usando: el editor de texto y las ventanas acoplables.
2. **El lenguaje (`sclang`):** El intérprete. Es el cerebro lógico. Entiende la sintaxis, procesa matemáticas, almacena variables y gestiona el tiempo musical.
3. **El servidor de audio (`scsynth`):** El motor sonoro. No entiende de variables ni de sintaxis compleja; solo recibe órdenes de bajo nivel para generar y procesar señales de audio en tiempo real.

El lenguaje y el servidor están completamente desacoplados. Se comunican entre sí en segundo plano mediante un protocolo de red llamado **OSC** (*Open Sound Control*).

Por eso, expresiones como `2 + 3;` o algoritmos numéricos funcionan de inmediato: el lenguaje los resuelve por sí mismo sin encender el motor de audio. En cambio, cuando escribimos `{ SinOsc.ar }.play`, el lenguaje traduce nuestra instrucción gráfica a un proceso de síntesis y le ordena al servidor que lo haga sonar.

Además, SuperCollider es un lenguaje **dinámicamente interpretado**. No necesitamos escribir una obra entera, compilarla y esperar minutos para escucharla. Podemos ejecutar una sola línea, evaluar un bloque o redefinir una función en caliente mientras la música sigue sonando. Esta es la base técnica del *live coding*.

> **Transición oral:** «Pausa el vídeo y anota en tu documento una frase propia que defina qué hace cada una de las tres piezas. Continuamos con las reglas con las que nos comunicamos con el intérprete.»

---

### Bloque 04 · Expresiones y métodos · 12 min · desde 32:00

> **En pantalla:** Evaluación paso a paso en el editor y lectura de resultados en la Post Window.

En SuperCollider todo es un **objeto**, y la forma estándar de comunicarnos es enviándole un **mensaje** o **método** a un objeto:

$$\text{Receptor} \ .\ \text{método}$$

Por ejemplo, tomamos el número `4` y le pedimos su cuadrado:

```supercollider
4.squared;
```

Al evaluar con `Shift + Return`, la Post Window devuelve `16`. `4` es el receptor y `.squared` es el mensaje.

Podemos encadenar métodos de izquierda a derecha. Si al resultado queremos cambiarle el signo:

```supercollider
4.squared.neg;
```

Primero calcula el cuadrado (`16`) y sobre este aplica la negación (`-16`).

Si el método requiere información complementaria, se la pasamos entre paréntesis como argumento:

```supercollider
4.pow(3);
```

Calcula $4^3 = 64$. Si queremos asegurarnos de que un cálculo intermedio se imprima explícitamente en la Post Window, usamos `.postln`:

```supercollider
(7.squared - 1).postln;
```

Fijaos en la claridad del razonamiento: no memorizamos árboles de herencia abstractos; pensamos a qué valor queremos aplicarle una transformación y encadenamos la acción.

> **Transición oral:** «Predice mentalmente cuánto vale `(7.squared - 1)`, pruébalo en tu editor y comprueba si da 48. Seguimos con la estructura de las líneas de código.»

---

### Bloque 05 · Leer y ejecutar bloques de código · 12 min · desde 44:00

> **En pantalla:** Comparativa entre `Shift + Return` y `Cmd/Ctrl + Return`. Demostración de errores de sintaxis comunes.

Cuando trabajamos con proyectos reales, el código abarca múltiples líneas. SuperCollider utiliza reglas de puntuación muy estrictas:

- **El punto y coma (`;`):** Indica el final de una instrucción. Sin él, el intérprete no sabe dónde acaba una orden y dónde empieza la siguiente.
- **Los comentarios (`//`):** Todo lo que vaya detrás de dos barras es ignorado por el intérprete. Sirve para documentar decisiones musicales.
- **La región entre paréntesis `( )`:** Agrupa varias líneas para que se ejecuten como una única unidad temporal.

Para agrupar código, colocamos los paréntesis en líneas independientes al inicio y al final:

```supercollider
(
3.squared.postln;
5.squared.postln;
)
```

**Diferencia crucial de atajos de teclado:**
- **`Shift + Return`:** Evalúa únicamente la línea física en la que se encuentra el cursor.
- **`Cmd + Return` (Mac) / `Ctrl + Return` (Windows/Linux):** Evalúa **todo el bloque** delimitado por los paréntesis exteriores, sin importar en qué línea interior esté el cursor.

Si el cursor está dentro del paréntesis y pulsamos `Cmd/Ctrl + Return`, la Post Window imprimirá `9` y `25` en un solo golpe. Gran parte de los fallos iniciales en SuperCollider se deben a pulsar `Shift + Return` sobre una línea que depende de las anteriores.

> **Transición oral:** «Realiza tres evaluaciones independientes: una línea sola, un bloque y un comentario. Ahora que sabemos agrupar instrucciones, necesitamos contenedores donde guardar esos resultados: las variables.»

---

### Bloque 06 · Variables · 13 min · desde 56:00

> **En pantalla:** Uso de variables de una sola letra y variables locales con `var`.

Una variable es una etiqueta o contenedor que almacena un valor para que podamos reutilizarlo o transformarlo.

En SuperCollider existen dos formas fundamentales de trabajar con variables:

#### 1. Variables globales predefinidas (`a` – `z`)
Las 26 letras minúsculas del alfabeto están disponibles en todo momento sin necesidad de declararlas. Persisten en la memoria del intérprete mientras la sesión esté abierta:

```supercollider
x = 4;
x = x.squared;
x.postln;
```

#### 2. Variables locales (`var`)
Dentro de una función o un bloque de ejecución podemos declarar nombres descriptivos usando la palabra reservada `var`. 

**Regla de oro:** Las variables locales deben declararse **siempre en la primera línea** del bloque o función:

```supercollider
(
var numero;
numero = 7;
(numero.squared - 1).postln;
)
```

Si intentamos evaluar `numero` fuera de este paréntesis, SuperCollider responderá que no está definida. La variable local nace y muere con la ejecución del bloque, lo que evita que unos procesos sobreescriban por accidente los datos de otros.

> **Transición oral:** «Modifica el 7 por un 10 en tu bloque y anticipa la salida antes de pulsar Intro. Pasamos a ver qué tipos de datos maneja SuperCollider.»

---

### Bloque 07 · Tipos de datos básicos · 13 min · desde 1:09:00

> **En pantalla:** Consulta del método `.class` sobre distintos literales.

Podemos preguntarle a cualquier elemento a qué familia pertenece aplicándole el método `.class`:

```supercollider
7.class;       // Integer (número entero)
7.0.class;     // Float (número decimal)
"hola".class;  // String (cadena de caracteres)
\tono.class;   // Symbol (símbolo)
true.class;    // True (familia de los Booleanos)
```

Cada uno cumple una función musical precisa:

- **`Integer` y `Float`:** Controlan frecuencias, duraciones rítmicas, amplitudes y posiciones de paneo. Nótese que `7` y `7.0` no son idénticos para el lenguaje; algunos métodos matemáticos exigen decimales para calcular interpolaciones continuas.
- **`String`:** Texto entrecomillado utilizado para rutas de archivos en disco, mensajes al usuario y títulos.
- **`Symbol`:** Precedido por una barra invertida (`\tono`). Son identificadores inmutables de bajo consumo de memoria. Los usaremos constantemente para bautizar sintetizadores y etiquetar parámetros.
- **`Boolean` (`true` o `false`):** Respuestas binarias que permiten que un algoritmo tome decisiones condicionales.

> **Transición oral:** «Identifica a qué familia pertenece cada uno de los cuatro ejemplos del handout. Ahora aprendamos a consultar el diccionario integrado para no tener que memorizarlo todo.»

---

### Bloque 08 · Ayuda y diagnóstico de errores · 12 min · desde 1:22:00

> **En pantalla:** Búsqueda en el Help Browser con `Cmd+D` y provocación voluntaria de un error en la Post Window.

No hace falta memorizar los cientos de objetos de SuperCollider. El sistema de ayuda integrado está pensado para acompañarnos en todo momento.

Si situamos el cursor sobre cualquier nombre de clase —por ejemplo `SinOsc`— y pulsamos **`Cmd + D`** (Mac) o **`Ctrl + D`** (Windows/Linux), se abre automáticamente el documento correspondiente en el Help Browser.

En la página de `SinOsc` identificamos de inmediato:
- Su función principal (generador de onda senoidal).
- Los argumentos de su método `.ar`: `freq` (frecuencia), `phase` (fase), `mul` (multiplicador/amplitud) y `add` (desplazamiento continuo).
- Bloques de código de ejemplo listos para copiar y evaluar.

#### Cómo perderle el miedo a los errores
Provoquemos un error inocuo a propósito:

```supercollider
4.cuadrado;
```

Al evaluar, la Post Window se llena de texto encabezado por la palabra **`ERROR: Message 'cuadrado' not understood`**. 

El mensaje nos dice con exactitud lo que ha ocurrido: el receptor (el número `4`) no entiende el mensaje `'cuadrado'`, porque el método se llama `squared`. Corregimos la palabra, volvemos a evaluar y el error desaparece. La Post Window no os está juzgando; os está indicando exactamente qué palabra o signo de puntuación necesita revisión.

> **Transición oral:** «Busca en la ayuda de SinOsc qué significa el argumento mul sin leer toda la documentación técnica. Volvamos al sonido para tomar el control de sus parámetros en directo.»

---

### Bloque 09 · Variar el sonido en tiempo real · 13 min · desde 1:34:00

> **En pantalla:** Asignación de un synth a una variable, modulación de frecuencia y liberación con `.free`.

En el primer bloque lanzamos un sonido al aire sin asignarlo a ninguna variable. Para poder controlarlo mientras suena, guardamos el proceso en una variable:

```supercollider
s.boot; // Solo si el servidor no estaba arrancado

x = { SinOsc.ar(440, 0, 0.1) }.play;
```

Al asignar el sonido a `x`, hemos creado un punto de control. Cuando queramos silenciar este oscilador concreto sin apagar el resto del entorno, no necesitamos recurrir a la parada de emergencia global; le enviamos el mensaje `.free`:

```supercollider
x.free;
```

Probemos ahora a contrastar dos registros:
- Una versión grave a 220 Hz:
  ```supercollider
  x = { SinOsc.ar(220, 0, 0.1) }.play;
  x.free;
  ```
- Una versión aguda a 660 Hz:
  ```supercollider
  x = { SinOsc.ar(660, 0, 0.1) }.play;
  x.free;
  ```

Mantened siempre la amplitud en valores prudentes (`0.05` a `0.15`). Frecuencia y amplitud son dimensiones acústicas independientes: variar los hercios modifica la altura; variar el multiplicador altera la intensidad.

> **Transición oral:** «Anota en tus apuntes qué cambio afectó a la altura tonal y cuál a la intensidad sonora. Llegamos al tramo final de la sesión: el reto práctico autónomo.»

---

### Bloque 10 · Reto y cierre de sesión · 13 min · desde 1:47:00

> **En pantalla:** Resolución modelo del reto paso a paso y guardado del archivo de trabajo.

Para consolidar el trabajo de hoy, cada estudiante debe completar este reto de cinco pasos en su propio equipo:

1. **Cálculo numérico:** Escribir una expresión matemática que imprima exactamente el número `48` en la Post Window.
2. **Encendido:** Arrancar el servidor de audio desde código.
3. **Generación sonora:** Crear un sonido suave con `SinOsc` asignándolo a una variable.
4. **Modificación auditiva:** Detenerlo con `.free`, cambiar su frecuencia por otra sensiblemente más aguda o grave y volver a reproducirlo.
5. **Documentación:** Guardar el archivo como `sesion_1_trabajo.scd` añadiendo un comentario de dos líneas (`//`) que resuma qué cambios habéis hecho y qué habéis percibido auditivamente.

#### Las tres reglas de oro para recordar siempre:
1. `Shift + Return` evalúa una línea; `Cmd/Ctrl + Return` dentro de paréntesis evalúa un bloque completo.
2. `Cmd + .` / `Ctrl + .` detiene todo el audio al instante.
3. `Cmd + D` / `Ctrl + D` sobre cualquier palabra abre su documentación oficial.

En la **Sesión 2** daremos el siguiente salto compositivo: abandonaremos las notas aisladas para construir **arrays de frecuencias y ritmos**, manipulándolos con **funciones y aleatoriedad controlada** para generar nuestras primeras estructuras musicales completas.

Cerrad vuestro archivo guardando los cambios y nos vemos en la siguiente sesión.
