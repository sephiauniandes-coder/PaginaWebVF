#!/usr/bin/env bash
# Publica design/landing en la vista previa pública (GitHub Pages, noindex, sin analítica).
# Uso: scripts/publicar-preview.sh ["mensaje del commit"]
set -euo pipefail

REPO_PREVIEW="mncons/sephia-landing-preview"
RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
ORIGEN="$RAIZ/design/landing"
MENSAJE="${1:-chore: actualizar vista previa}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

gh repo clone "$REPO_PREVIEW" "$TMP/preview" -- --quiet
cd "$TMP/preview"
rm -rf assets support.js index.html
cp -r "$ORIGEN/assets" "$ORIGEN/support.js" .

python3 -I - "$ORIGEN/SEPHIA Landing.dc.html" index.html <<'EOF'
import re, sys
s = open(sys.argv[1], encoding='utf-8').read()
s = s.replace('<meta charset="utf-8">', '<meta charset="utf-8">\n<meta name="robots" content="noindex, nofollow">', 1)
s = re.sub(r'<!-- Analítica: Umami.*?-->\n<script defer src="https://cloud\.umami\.is/script\.js"[^>]*></script>\n', '', s, flags=re.S)
assert 'noindex' in s and 'umami.is' not in s
open(sys.argv[2], 'w', encoding='utf-8').write(s)
EOF

git add -A
if git diff --cached --quiet; then
  echo "Sin cambios: la vista previa ya está al día."
  exit 0
fi
git commit -qm "$MENSAJE"
git push -q origin main
echo "Publicado. En ~1 min: https://mncons.github.io/sephia-landing-preview/"
