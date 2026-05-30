# This article folder

Created by the **ai-article-factory** skill. It holds everything for ONE article (single-piece flow).

## Default "water" path (newbie default — AI does it all, 2 light confirms)
```
one sentence / a materials folder
  → AI auto-files + drafts a blueprint   (confirm ①, optional — silence = continue)
  → AI writes the draft (every fact sourced, answer-first)
  → AI self-checks + renders figures (placeholder cover, never blocks) + exports
     (confirm ②: glance, approve or tweak)
  → 文章.md  +  文章.docx   (ready to publish)
```
You never touch the command line; you only review, confirm, publish. Everything below is produced for you.

## Files
- `00-产品档案.md` + `01`–`06`: per-stage artifacts. **AI fills these automatically** — you don't hand-write them.
- `assets/`: `src/` (figure sources) · `img/` (rendered images) · `图清单.md` (figure index).
- `<slug>-final.md` (illustrated) · `<slug>-final.docx` (Word) · `<slug>-wp.md` / `<slug>-linkedin.md` / `<slug>-x.md` (on demand).

## Figures / export (scripts the skill provides — run them on THIS folder)
```bash
bash <path-to>/ai-article-factory/scripts/render-figures.sh <this-folder>
bash <path-to>/ai-article-factory/scripts/export.sh <this-folder> <slug>
```

Full 11-stage SOP: the skill's `SKILL.md` + `references/`. Two real gates only: **evidence is sourced**, **QA passes**.
