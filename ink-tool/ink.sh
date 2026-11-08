#!/usr/bin/env bash
# Turn any GIF/video into a two-tone ink-and-paper halftone GIF.
# usage: ./ink.sh input.gif output.gif [width] [contrast] [brightness]
# needs: ffmpeg. palette.png must sit next to this script.
set -euo pipefail
in="$1"; out="$2"; w="${3:-800}"; c="${4:-1.5}"; b="${5:-0.05}"
here="$(cd "$(dirname "$0")" && pwd)"
ffmpeg -v error -y -i "$in" -i "$here/palette.png" -filter_complex \
"[0:v]fps=15,scale=${w}:-1:flags=lanczos,format=gray,eq=contrast=${c}:brightness=${b},format=rgb24[g];[g][1:v]paletteuse=dither=bayer:bayer_scale=3" \
-loop 0 "$out"
echo "wrote $out"
