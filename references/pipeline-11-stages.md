# The 11-stage pipeline (P0–P11)

Each stage: **purpose · skill/tool · output · Gate · human touchpoint**. Advance one stage at a time; report artifact + Gate verdict each time. ★ = hard gate.

| # | Stage | Skill / tool | Output | Gate | Human |
|---|-------|-------------|--------|------|-------|
| P0 | Product profile | — | `00-产品档案.md` | product/ICP/goal/diff clear | — |
| P1 | Topic | `keyword-research` `content-gap-analysis` `competitor-analysis` | `01-选题brief.md` | 1 intent / 1 ICP / 1-line diff | **pick topic** |
| P2 | Evidence ledger ★ | `expert-interview` + web/materials | `02-证据台账.md` | no "unverified" quant claim; primary source + locator each | **adjudicate disputes** |
| P3 | Angle | `content-brief` `serp-analysis` | `03-主题角度.md` | thesis in one line; answer-first block | — |
| P4 | Outline | `topic-cluster-planning` `semantic-gap-analysis` | `04-大纲.md` | each H2 = an answerable question; figure intent marked | — |
| P5 | Draft | `write-content` (anti-AI-slop) | `05-初稿.md` | no unsourced facts; answer-first per H2 | — |
| P6 | Visuals | mermaid + matplotlib(`figlib`) + AI cover | `assets/img/*` + `图清单.md` | ≥3 figures; data fig has text equivalent | **fill cover** |
| P7 | SEO/GEO | `geo-content-optimizer` `meta-tags-optimizer` `schema-markup-generator` `internal-linking-optimizer` | `<slug>-final.md` | SEO≥8 GEO≥8; schema valid | — |
| P8 | QA ★ | `content-quality-auditor` `eeat-audit` (independent subagent) | `06-审核报告.md` | CORE-EEAT ship; facts reconciled 100% | **confirm release** |
| P9 | Export | `scripts/export.sh` (pandoc) | `<slug>-final.docx` + `<slug>-wp.md` | docx images embedded; MD==Word | — |
| P10 | Publish | `technical-seo-checker` + CMS | `<slug>-wp.md` + platform posts | checklist green; submitted to GSC/Bing | **publish** |
| P11 | Monitor | `rank-tracker` `performance-reporter` `alert-manager` | reports in monitoring dir | — | review & steer |

## Per-stage notes

**P0 Product profile** — the generalization key. Fill product / one ICP (role, knowledge level, decision authority, biggest fear, how they search/ask AI) / main intent / business goal / one-line differentiation / brand voice / evidence whitelist / figure intent / `target-domain` / `target-platforms`. This lets the same pipeline serve *any* topic or product.

**P2 Evidence ledger (hard gate)** — list every numeric/definitional/standard/causal/comparative claim; find a primary source and locate it (page/section/table/clause/URL anchor). Conflicts → mark `conflict`; not found → `unverified` (only soft phrasing allowed). Never cite competitor blogs/content farms as authority. A `PreToolUse` hook can block writing while any `unverified` quant claim remains.

**P5 Draft** — answer-first; tag each fact `[C#]`; 40–60-word self-contained answer block after H1 and under each H2; comparisons → tables, questions → FAQ, steps → ordered lists; ≥2 first-hand insights; active voice, non-native readable.

**P7 SEO/GEO** — Title/H1 with main keyword + info gain; meta description ≤155 with CTA; short keyworded slug; ≥2 internal links; image alts. GEO: each H2/H3 independently answerable; definitions/comparisons/data as structured units; FAQ covers real AI queries; consistent entity naming; ≥1 exclusive datapoint. Schema: `Article`/`TechArticle` + `FAQPage`, validated.

**P8 QA (hard gate)** — independent subagent, stance = find faults. Five axes: purpose alignment / factual accuracy (veto) / logic / reader calibration / differentiation. Reconcile every fact against the ledger. Not "ship" → bounce to P5.

> Gate philosophy: gates are the quality fuses. Automate the work between gates; keep humans at review/confirm/publish.
