#!/usr/bin/env bash
# e2e-smoke.sh — end-to-end pipeline reliability gate (automated dogfood).
# Scaffolds a throwaway article, renders figures (Mermaid + matplotlib), exports
# to Word, and asserts the WHOLE chain composes: figures embedded + [C#] reconcile.
# Complements harness.sh (which tests scripts in isolation). Bash 3.2 safe.
# Usage: bash tests/e2e-smoke.sh [repo_root]
set -uo pipefail
REPO="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
W="/tmp/aaf-e2e"; rm -rf "$W"; mkdir -p "$W"
FAIL=0; pass(){ echo "  ✓ $1"; }; fail(){ echo "  ✗ $1"; FAIL=1; }

SLUG="e2e-demo"
( cd "$W" && ARTICLE_OUTPUT_DIR=articles bash "$REPO/scripts/new-article.sh" "$SLUG" 2026-01-01 >/dev/null )
D="$W/articles/2026-01-01-$SLUG"
[ -f "$D/00-产品档案.md" ] && pass "scaffold creates project folder" || fail "scaffold"

# figure sources: one Mermaid diagram + one matplotlib chart (via bundled figlib)
printf 'flowchart LR\n  A[topic]-->B[draft]-->C[publish]\n' > "$D/assets/src/01-flow.mmd"
cat > "$D/assets/src/02-chart.py" <<'PY'
import figlib as F
F.save(F.bar_compare(["A","B"], {"before":[3,5], "after":[1,2]}, title="demo"), "02-chart.png")
PY

# minimal evidence ledger + final draft with [C#] tags
cat > "$D/02-证据台账.md" <<'MD'
| # | Claim | Status |
|---|---|---|
| C1 | opening claim | 已核 |
| C2 | composition claim | 已核 |
MD
cat > "$D/$SLUG-final.md" <<'MD'
# E2E Demo

Opening answer block. [C1]

![flow](assets/img/01-flow.png)

## Proof

The pipeline composes end to end. [C2]

![chart](assets/img/02-chart.png)
MD

bash "$REPO/scripts/render-figures.sh" "$D" >/dev/null 2>&1
[ -f "$D/assets/img/01-flow.png" ]  && pass "Mermaid figure rendered"     || fail "Mermaid figure rendered"
[ -f "$D/assets/img/02-chart.png" ] && pass "matplotlib figure rendered"  || fail "matplotlib figure rendered"

bash "$REPO/scripts/export.sh" "$D" "$SLUG" >/dev/null 2>&1
[ -f "$D/$SLUG-final.docx" ] && pass "Word .docx produced" || fail "Word .docx produced"
n=$(unzip -l "$D/$SLUG-final.docx" 2>/dev/null | grep -c 'media/')
[ "${n:-0}" -ge 1 ] && pass "docx embeds figures (media=$n)" || fail "docx embeds figures"

# [C#] reconciliation: every tag in the final must exist as a ledger row
miss=0
for c in $(grep -oE '\[C[0-9]+\]' "$D/$SLUG-final.md" | tr -d '[]' | sort -u); do
  grep -q "| $c " "$D/02-证据台账.md" || { echo "    unreconciled: $c"; miss=1; }
done
[ "$miss" -eq 0 ] && pass "every [C#] reconciles to the ledger" || fail "[C#] reconciliation"

rm -rf "$W"
echo ""
[ "$FAIL" -eq 0 ] && echo "E2E: ALL GREEN" || { echo "E2E: FAILURES"; exit 1; }
