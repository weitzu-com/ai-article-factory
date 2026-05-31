# GEMINI.md

**ai-article-factory** — a self-contained skill suite that turns any material/topic/product into a publish-ready, illustrated, SEO+GEO article in Markdown + Word, plus website/LinkedIn/X copy. A human only reviews, confirms, and publishes.

👉 Full agent instructions are in **[AGENTS.md](AGENTS.md)** (single source of truth) — pipeline, worker skills, commands, and rules. The skill orchestrator is `SKILL.md`; the six workers are under `skills/`.

Quickstart:
```bash
bash scripts/new-article.sh <slug>            # scaffold articles/<date>-<slug>/
bash scripts/render-figures.sh <article-dir>  # figures → assets/img/
bash scripts/export.sh <article-dir> <slug>   # Markdown → .docx
bash tests/harness.sh                         # regression suite (keep green)
```
Default path: one sentence → AI infers the profile (no forms) → draft → figures + export → `*-final.md` + `*-final.docx`. Apache-2.0 (see `NOTICE`).
