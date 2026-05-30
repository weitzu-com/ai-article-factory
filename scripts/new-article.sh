#!/usr/bin/env bash
# new-article.sh — scaffold a new article project from the bundled template.
# Usage: bash scripts/new-article.sh <slug> [YYYY-MM-DD]
# Creates: ${ARTICLE_OUTPUT_DIR:-articles}/<date>-<slug>/  (in your current working dir)
set -euo pipefail
SLUG="${1:?usage: new-article.sh <slug> [date]   (slug = english-kebab-case)}"
DATE="${2:-$(date +%F)}"
# enforce the naming rule (no spaces / full-width / uppercase): keeps image SEO & URLs clean
if ! printf '%s' "$SLUG" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$'; then
  echo "❌ invalid slug: '$SLUG' — use english-kebab-case, e.g. ai-support-chatbot-roi"; exit 1
fi
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"   # skill repo root
# Articles land in your CURRENT working directory (override with ARTICLE_OUTPUT_DIR).
# Tip: cd to your project folder first, so output isn't written inside the skill install.
DEST="${ARTICLE_OUTPUT_DIR:-articles}/$DATE-$SLUG"
if [ -e "$DEST" ]; then echo "❌ already exists: $DEST"; exit 1; fi
mkdir -p "$DEST"
cp -R "$ROOT/templates/article/." "$DEST/"
ABS="$(cd "$DEST" && pwd)"
echo "✅ scaffolded: $ABS"
echo "   (output dir = current working dir; set ARTICLE_OUTPUT_DIR to change)"
echo "Next: just tell Claude your topic — the ai-article-factory skill drives the rest."
ls "$DEST"
