#!/usr/bin/env bash
# new-article.sh — scaffold a new article project from the bundled template.
# Usage: bash scripts/new-article.sh <slug> [YYYY-MM-DD]
# Creates: ${ARTICLE_OUTPUT_DIR:-articles}/<date>-<slug>/  (in your current working dir)
set -euo pipefail
SLUG="${1:?usage: new-article.sh <slug> [date]}"
DATE="${2:-$(date +%F)}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"   # skill repo root
DEST="${ARTICLE_OUTPUT_DIR:-articles}/$DATE-$SLUG"
if [ -e "$DEST" ]; then echo "❌ already exists: $DEST"; exit 1; fi
mkdir -p "$DEST"
cp -R "$ROOT/templates/article/." "$DEST/"
echo "✅ scaffolded: $DEST"
echo "Next: fill 00-产品档案.md → run the ai-article-factory pipeline (P0–P11)."
ls "$DEST"
