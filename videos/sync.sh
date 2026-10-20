#!/bin/sh
# Copia la base común (_shared) a cada composición y crea los archivos del proyecto HyperFrames.
cd "$(dirname "$0")"
for d in */; do
  d=${d%/}; [ "$d" = "_shared" ] && continue
  cp _shared/mg.css _shared/mg-embed.js _shared/gsap.min.js "$d/"
  mkdir -p "$d/fonts" && cp _shared/fonts/* "$d/fonts/"
  [ -f "$d/meta.json" ] || printf '{\n  "id": "%s",\n  "name": "%s",\n  "createdAt": "2026-10-20T12:00:00.000Z"\n}\n' "$d" "$d" > "$d/meta.json"
  [ -f "$d/hyperframes.json" ] || cp ../../lpedaci/taller-primerempleo/videos/star/hyperframes.json "$d/" 2>/dev/null
  [ -f "$d/package.json" ] || sed "s/\"star\"/\"$d\"/" ../../lpedaci/taller-primerempleo/videos/star/package.json > "$d/package.json"
done
