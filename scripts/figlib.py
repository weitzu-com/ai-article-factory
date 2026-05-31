"""figlib.py — 文章配图统一图库（品牌一致 + 中文安全 + 通用）

任意文章的 assets/src/*.py 里：
    import figlib as F
    fig, ax = F.fig()
    ax.bar(...)
    F.save(fig, "01-tco-comparison.png")

render-figures.sh 会自动把本目录加入 PYTHONPATH，并把 FIG_OUT 指到该文章的
assets/img/。脱离脚本单独跑时，默认输出到 ./ 或环境变量 FIG_OUT。

品牌色板从同目录 palette.json 读取（若存在），否则用内置中性默认色。
换品牌 VI 只改 palette.json，无需改每篇文章。
"""
from pathlib import Path
import json
import os
import matplotlib
matplotlib.use("Agg")  # 无界面渲染
import matplotlib.pyplot as plt
from matplotlib import font_manager

# --- 注册 macOS 中文字体，保证中文不变方框 ---
for _p in (
    "/System/Library/Fonts/Hiragino Sans GB.ttc",
    "/System/Library/Fonts/Supplemental/Songti.ttc",
    "/System/Library/Fonts/STHeiti Light.ttc",
):
    try:
        font_manager.fontManager.addfont(_p)
    except Exception:
        pass

plt.rcParams.update({
    "font.family": ["DejaVu Sans", "Hiragino Sans GB", "Songti SC",
                     "STHeiti", "Arial Unicode MS"],
    "axes.titlesize": 16,
    "axes.labelsize": 12,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.unicode_minus": False,
    "figure.dpi": 110,
})

# --- Brand palette: neutral example defaults; override via palette.json next to this script ---
_DEFAULT = {"blue": "#1F6FEB", "teal": "#2AA198", "gold": "#D29922",
            "red": "#CF222E", "grey": "#57606A"}
_here = Path(__file__).resolve().parent
_pal_path = next((p for p in (_here / "palette.json",
                              _here.parent / "brand" / "palette.json") if p.exists()), None)
try:
    if _pal_path:
        _DEFAULT.update(json.loads(_pal_path.read_text(encoding="utf-8")))
except Exception:
    pass
BLUE, TEAL, GOLD, RED, GREY = (_DEFAULT[k] for k in ("blue", "teal", "gold", "red", "grey"))
PALETTE = [BLUE, TEAL, GOLD, RED, GREY]


def fig(w=10, h=5.6):
    """统一尺寸/留白的画布。"""
    f, ax = plt.subplots(figsize=(w, h))
    return f, ax


def _out_dir() -> Path:
    d = Path(os.environ.get("FIG_OUT", "."))
    d.mkdir(parents=True, exist_ok=True)
    return d


def save(figure, name: str):
    """保存到 FIG_OUT（render-figures.sh 已指向该文章 assets/img/）。"""
    out = _out_dir() / name
    out.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(out, dpi=144, bbox_inches="tight", facecolor="white")
    plt.close(figure)
    print(f"  wrote {out}")
    return out


def bar_compare(categories, series: dict, title="", ylabel="", unit=""):
    """快捷分组柱状图：series = {'方案A':[..], '方案B':[..]}，自动配色+数值标注。"""
    import numpy as np
    f, ax = fig()
    n = len(series)
    x = np.arange(len(categories))
    w = 0.8 / max(n, 1)
    for i, (label, vals) in enumerate(series.items()):
        bars = ax.bar(x + (i - (n - 1) / 2) * w, vals, w, label=label,
                      color=PALETTE[i % len(PALETTE)])
        for b, v in zip(bars, vals):
            ax.text(b.get_x() + b.get_width() / 2, v, f"{v}{unit}",
                    ha="center", va="bottom", fontsize=9)
    ax.set_xticks(x)
    ax.set_xticklabels(categories)
    if title:
        ax.set_title(title)
    if ylabel:
        ax.set_ylabel(ylabel)
    ax.legend()
    return f
