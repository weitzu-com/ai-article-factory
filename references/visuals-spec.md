# Visuals spec (图文并茂) — SEO + GEO friendly

Figures serve three readers: humans (understanding), search engines (image SEO / rich results), AI engines (multimodal understanding & citation). **≥3 figures per article: 1 cover + ≥2 content.**

## Type decision tree (pick type, then tool)
| To express | Type | Tool | Output |
|---|---|---|---|
| flow / structure / relationship | flowchart / diagram | **Mermaid** `assets/src/*.mmd` | PNG |
| data / comparison / trend | bar/line/pie | **matplotlib** `assets/src/*.py` (`import figlib`) | PNG |
| concept / cover | illustration | **AI image** (`assets/src/cover-prompt.md`, human fills `cover.png`) | PNG |
| real UI / object | screenshot / photo | manual | PNG/JPG |
| tabular comparison | **Markdown table** | in prose (preferred — AI-extractable) | — |

**Rule:** if tabular data can be a Markdown table, use a table (extractable, accessible, indexable). Only draw when relationships/trends can't be tabled.

## Render
```bash
bash scripts/render-figures.sh articles/<slug>/   # mermaid + matplotlib → assets/img/
```
`figlib.py`: brand palette (`palette.json`) + macOS CJK fonts registered (Chinese won't render as boxes) + `save()` / `bar_compare()` helpers. `render-figures.sh` adds the scripts dir to PYTHONPATH and writes outputs to the article's `assets/img/`.

## Naming & embedding (image SEO/GEO)
- Filename: **English kebab-case with keywords** (e.g. `feature-vs-competitor-tco.png`, not `image1.png`).
- Embed: `![keyworded alt](assets/img/x.png)` + caption (with source `[C#]`).
- Each figure passes: descriptive filename · keyworded alt · caption · compressed (<200KB chart / <400KB cover) · **data figure has an equivalent sentence/table nearby** · key numbers also in prose pointing to the source.
- Cover prompt (`assets/src/cover-prompt.md`): subject + style (brand colors) + 16:9 with negative space for a title + negative prompt.

## Accessibility (also an SEO signal)
Don't rely on color alone; sufficient contrast; in-figure font ≥ body; give complex figures a prose summary.
