# CLAUDE.md

This repo is the **ai-article-factory** Claude Code skill suite — it turns any material/topic/product into a publish-ready, illustrated, SEO+GEO article in Markdown + Word (human only reviews, confirms, publishes).

- **Installed as a skill:** the entry point is `SKILL.md` (the orchestrator); it runs the 11-stage pipeline and invokes the workers in `skills/`.
- **Working in this repo (clone/develop):** read **[AGENTS.md](AGENTS.md)** — the single source of truth for the pipeline, worker skills, commands, and hard rules.

Quickstart: `bash scripts/new-article.sh <slug>` → tell Claude your topic (AI infers the profile, no forms) → get an illustrated `*-final.md` + `*-final.docx`.
Tests: `bash tests/harness.sh` (must stay green). License: Apache-2.0 (see `NOTICE`).
