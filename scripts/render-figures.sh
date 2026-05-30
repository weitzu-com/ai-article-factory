#!/usr/bin/env bash
# render-figures.sh — 渲染一篇文章的全部配图
#   assets/src/*.mmd  --(mermaid-cli)-->  assets/img/<name>.png   流程图/结构图
#   assets/src/*.py   --(matplotlib)-->   assets/img/<name>.png   数据图/对比图
# 用法: bash render-figures.sh <article-dir>    (默认当前目录)
set -euo pipefail

DIR="${1:-.}"
DIR="$(cd "$DIR" && pwd)"
SRC="$DIR/assets/src"
IMG="$DIR/assets/img"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$IMG"

# 让文章里的 *.py 能 `import figlib`，并把产物写进本文章的 img/
export PYTHONPATH="$SCRIPT_DIR:${PYTHONPATH:-}"
export FIG_OUT="$IMG"

shopt -s nullglob
n=0

# 1) Mermaid 流程/结构图
if command -v mmdc >/dev/null 2>&1; then
  for f in "$SRC"/*.mmd; do
    base="$(basename "${f%.mmd}")"
    mmdc -i "$f" -o "$IMG/$base.png" -b white -s 2 -q >/dev/null 2>&1 \
      && { echo "  mermaid -> $IMG/$base.png"; n=$((n+1)); } \
      || echo "  [warn] mermaid 渲染失败: $f"
  done
else
  echo "  [warn] mmdc 未安装，跳过 .mmd（npm i -g @mermaid-js/mermaid-cli）"
fi

# 2) Python / matplotlib 数据图
for f in "$SRC"/*.py; do
  [ "$(basename "$f")" = "figlib.py" ] && continue
  python3 "$f" && n=$((n+1)) || echo "  [warn] python 渲染失败: $f"
done

echo "✅ 渲染完成，共 $n 张 -> $IMG"
ls "$IMG" 2>/dev/null | sed 's/^/   - /'
