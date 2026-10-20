# Charla de carreras 2027

Sitio web estático de una sola página que acompaña la charla de carreras para estudiantes de 6to año de escuela técnica, modalidad Informática. El contenido se organiza como un mapa de recorrido: dos líneas, diez paradas y tres apartados especiales, cada una con una idea clave, ejemplos, figuras y una actividad.

Comparte el diseño del sitio [Del aula al primer trabajo](https://lpedaci.github.io/taller-primerempleo/): mismos tokens de color, tipografías, componentes y animaciones. Está desarrollado con HTML, CSS y JavaScript, sin frameworks ni proceso de compilación.

## Características

- **Avance del estudiante:** cada parada se marca como recorrida y el progreso se guarda en `localStorage`, junto con la lista final y la escala de intención.
- **Año de ingreso automático:** la solapa del cuaderno muestra el año siguiente al actual.
- **Inscripciones con fecha de hoy:** las tarjetas de cada institución muestran si la inscripción está abierta, por abrir o cerrada, y el calendario del ingreso marca el día actual.
- **Escala sin el 7:** herramienta para puntuar dos carreras del 1 al 10 sin la opción tibia.
- **Plantilla para copiar:** comparación de dos planes de estudio, con copia al portapapeles.
- **Tema claro y oscuro:** sigue la preferencia del sistema y permite cambiarlo a mano.
- **Diseño adaptable y accesible:** HTML semántico, enlace para saltar al contenido, foco visible, tablas apiladas en móvil y respeto por la preferencia de movimiento reducido.
- **Animaciones explicativas:** seis composiciones HyperFrames incrustadas en vivo, que heredan el tema del sitio.

Contenido: Prof. Lourdes Pedaci, a partir de la charla de carreras 2025, actualizado en octubre de 2026 para el ingreso 2027.

## Recorrido

**Línea 1. Conocer el mapa**

1. El sistema educativo argentino
2. La educación superior: institutos y universidades
3. Requisitos para entrar
4. Inscripciones 2027: fechas y programas

**Línea 2. Elegir tu camino**

5. Tipos de titulaciones posibles
6. Cómo leer y comparar planes de estudio
7. La particularidad de la ingeniería
8. Qué pide el mercado hoy
9. Entonces… ¿qué camino tomar?
10. En síntesis

Fuera del recorrido hay tres apartados especiales: la particularidad de la programación, la particularidad de la psicología y el servidor de Lourdes, con cursos gratuitos y materiales. Al final están las referencias en formato APA 7.

## Estructura de archivos

```
index.html             Página única con todas las paradas
assets/styles.css      Design system compartido con el taller de primer empleo
assets/carreras.css    Componentes propios: calendario, tarjetas, escala, notas adhesivas
assets/app.js          Avance guardado, pestañas, estados de inscripción, escala, animaciones
assets/fonts/          Outfit, Geist y Geist Mono
assets/img/            Imagen para redes (og.png), vista previa del servidor y logos/ de las universidades
videos/<nombre>/       Composiciones HyperFrames: niveles, titulos, espectro, cliente, perfil, escala
videos/_shared/        Base común de las composiciones (mg.css, mg-embed.js, gsap, fuentes)
```

Los íconos son de Font Awesome Free y están incluidos en `index.html` como sprite SVG.

Para verlo en local con un servidor:

```bash
npx http-server . -p 4173
```

## Actualizar las fechas

Cada tarjeta de institución tiene una etiqueta `.status` con `data-open` y `data-close` en formato `AAAA-MM-DD`; si la fecha no está confirmada, lleva `data-tbc`. El calendario de la parada 4 usa las mismas fechas, escritas en las barras (`--a` y `--b` son el porcentaje entre el 1 de agosto de 2026 y el 1 de abril de 2027) y en la tabla que está debajo.

## Animaciones (HyperFrames)

Cada carpeta de `videos/` es un proyecto HyperFrames de 1200x900. El sitio las muestra en vivo dentro de un `<iframe>` (`index.html?embed=1`): se reproducen una vez al entrar en pantalla, tienen botón de pausa y respetan "reducir movimiento" (muestran el cuadro final).

Para revisar o exportar una como video (la exportación requiere FFmpeg instalado):

```bash
cd videos/titulos
npx hyperframes check .
npx hyperframes preview
npx hyperframes render . -q high -o ./renders/video.mp4
```

Si cambiás algo en `videos/_shared/`, ejecutá `videos/sync.sh` para copiarlo a cada composición.
