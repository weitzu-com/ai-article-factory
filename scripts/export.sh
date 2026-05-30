#!/usr/bin/env bash
# export.sh — export an article's final draft to Word (.docx) with images embedded.
# Usage: bash export.sh <article-dir> [slug]
#   - finds <slug>-final.md (or the first *-final.md in the dir)
#   - applies brand template templates/reference.docx if present
#   - --resource-path points at assets/img so ![](assets/img/x.png) embeds
# Output: <slug>-final.docx (next to the md)
set -euo pipefail

DIR="${1:-.}"
DIR="$(cd "$DIR" && pwd)"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"   # skill repo root
# brand template: skill layout (templates/) or project layout (品牌/)
REF=""
for c in "$ROOT/templates/reference.docx" "$ROOT/品牌/reference.docx"; do
  [ -f "$c" ] && { REF="$c"; break; }
done

# locate final draft
if [ "${2:-}" != "" ] && [ -f "$DIR/$2-final.md" ]; then
  MD="$DIR/$2-final.md"
else
  MD="$(ls "$DIR"/*-final.md 2>/dev/null | head -1 || true)"
fi
[ -z "${MD:-}" ] && { echo "❌ no *-final.md found — finish P7 to produce the final draft first"; exit 1; }

OUT="${MD%-final.md}-final.docx"

# build args (bash 3.2-safe: no empty-array expansion under set -u)
ARGS=( "$MD" -o "$OUT" --resource-path="$DIR:$DIR/assets/img" --toc --toc-depth=2 --metadata=lang:zh-CN )
if [ -n "$REF" ]; then ARGS+=( --reference-doc="$REF" ); else echo "  [warn] no brand template, using pandoc defaults"; fi

pandoc "${ARGS[@]}" 2>/dev/null

echo "✅ Word exported: $OUT"
ls -la "$OUT" | awk '{print "   "$5" bytes"}'
