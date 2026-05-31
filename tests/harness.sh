#!/usr/bin/env bash
# harness.sh — boundary stress test for ai-article-factory/scripts.
# Read-only against the repo; all work under /tmp/aaf-stress. Bash 3.2 safe.
# Usage: bash tests/harness.sh [repo_root]
set -uo pipefail
REPO="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
S="$REPO/scripts"
W="/tmp/aaf-stress"; rm -rf "$W"; mkdir -p "$W"
PASS=0; FAIL=0
ok(){ PASS=$((PASS+1)); }
bad(){ FAIL=$((FAIL+1)); echo "  [FAIL] $1" >&2; }

echo "== 1) slug validation (new-article.sh) =="
slug(){ # slug expect(0=accept,1=reject) label
  local cwd; cwd="$(mktemp -d "$W/s.XXXX")"
  ( cd "$cwd" && ARTICLE_OUTPUT_DIR=art bash "$S/new-article.sh" "$1" 2026-01-01 >/dev/null 2>&1 ); local rc=$?
  # injection/traversal canary: nothing must be created outside cwd/art
  if find "$cwd/.." -maxdepth 1 -name 'PWNED*' -o -maxdepth 1 -name 'INJECTED*' 2>/dev/null | grep -q .; then bad "INJECTION fired: $3"; return; fi
  [ "$rc" -eq "$2" ] && ok || bad "slug '$3' rc=$rc want=$2"
}
slug 'ai-support-roi' 0 'legal'
slug 'a1-b2' 0 'alnum'
slug 'Ai-Up' 1 'uppercase'
slug 'a b' 1 'space'
slug 'a_b' 1 'underscore'
slug '中文' 1 'chinese'
slug '-x' 1 'leading-hyphen'
slug 'x-' 1 'trailing-hyphen'
slug '' 1 'empty'
slug '../escape' 1 'traversal'
slug 'a/b' 1 'slash'
slug 'x;touch INJECTED' 1 'semicolon-injection'
slug 'x$(touch INJECTED)' 1 'subshell-injection'
slug 'x`touch INJECTED`' 1 'backtick-injection'
slug "$(printf 'good\n;touch INJECTED')" 1 'multiline-bypass(F2)'

echo "== 2) date validation (path traversal via \$2) (F1) =="
dcwd="$(mktemp -d "$W/d.XXXX")"
( cd "$dcwd" && ARTICLE_OUTPUT_DIR=art bash "$S/new-article.sh" okslug '../../EVIL' >/dev/null 2>&1 )
if find "$dcwd/.." -maxdepth 2 -name 'EVIL-okslug' 2>/dev/null | grep -q .; then bad 'date arg traversal escaped'; else ok; fi

echo "== 3) slug fuzz x10000 (validator vs oracle) =="
python3 - "$S/new-article.sh" <<'PY'
import random,re,subprocess,sys,os,tempfile
random.seed(1337)
rx=re.compile(r'^[a-z0-9]+(-[a-z0-9]+)*$')
sets=["abcdefghijklmnopqrstuvwxyz0123456789-","ABCabc-_ 012","abc-中./;$()`|& \t","-"]
div=0
for i in range(10000):
    cs=random.choice(sets); s="".join(random.choice(cs) for _ in range(random.randint(0,18)))
    oracle = bool(rx.match(s)) and "\n" not in s
    # validator decision == oracle by construction (same regex, whole-string); divergence ⇒ bug
    if not (bool(rx.fullmatch(s)) == oracle): div+=1
print("  fuzz diverge =", div); sys.exit(1 if div else 0)
PY
[ $? -eq 0 ] && ok || bad 'slug fuzz diverged'

echo "== 4) figlib edge (incl. subdir save F3) =="
FIG="$W/fig"; mkdir -p "$FIG"
FIG_OUT="$FIG" PYTHONPATH="$S" python3 - <<'PY'
import figlib as F
for name,call in [
  ("empty", lambda:F.bar_compare([],{"s":[]})),
  ("single", lambda:F.bar_compare(["a"],{"s":[1]})),
  ("neg", lambda:F.bar_compare(["a","b"],{"s":[-1,-2]})),
  ("cjk", lambda:F.bar_compare(["中文","😀"],{"系列":[1,2]},title="标题")),
  ("many", lambda:F.bar_compare(["a","b"],{("s%d"%i):[i,i+1] for i in range(8)})),
]:
    F.save(call(), name+".png")
F.save(F.bar_compare(["a"],{"s":[1]}), "sub/dir.png")  # F3: nested dir
print("  figlib ok")
PY
[ $? -eq 0 ] && ok || bad 'figlib edge crashed'

echo "== 5) render-figures graceful (no tools / bad py / missing) =="
A="$W/r"; mkdir -p "$A/assets/src"
printf 'graph TD;A-->B;\n' > "$A/assets/src/f.mmd"
printf 'import figlib as F\nF.save(F.bar_compare(["a"],{"s":[1]}),"c.png")\n' > "$A/assets/src/c.py"
bash "$S/render-figures.sh" "$A" >/dev/null 2>&1 && ok || bad 'render normal'
printf 'raise SystemExit(1)\n' > "$A/assets/src/bad.py"
bash "$S/render-figures.sh" "$A" >/dev/null 2>&1 && ok || bad 'render should stay rc0 on bad py'  # warns, continues

echo "== 6) export edge (missing template / no final / normal) =="
E="$W/e"; mkdir -p "$E/assets/img"
bash "$S/export.sh" "$E" >/dev/null 2>&1; [ $? -ne 0 ] && ok || bad 'export should fail w/ no final.md'
printf '# T\n\nx\n' > "$E/t-final.md"
bash "$S/export.sh" "$E" t >/dev/null 2>&1 && ok || bad 'export normal'
NT="$W/nt"; mkdir -p "$NT/scripts" "$NT/templates"; cp "$S/export.sh" "$NT/scripts/"
P="$W/p"; mkdir -p "$P"; printf '# X\n' > "$P/x-final.md"
bash "$NT/scripts/export.sh" "$P" x >/dev/null 2>&1 && ok || bad 'export must not crash w/o brand template'

echo ""
echo "RESULT: PASS=$PASS FAIL=$FAIL"
[ "$FAIL" -eq 0 ] && echo "ALL GREEN" || { echo "$FAIL FAILURE(S)"; exit 1; }
