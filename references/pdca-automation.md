# PDCA & automation — continuous evolution

The factory gets stronger every loop.

```
P (Plan)  → topic + schedule        01 topic backlog / calendar
D (Do)    → 11-stage creation       articles/<slug>/
C (Check) → CORE-EEAT QA + facts    06-审核报告.md
A (Act)   → publish + monitor + refresh   published-by-domain + reports
```

## Automate the cadence
- **Auto-topic / auto-schedule**: `/schedule` a weekly job — "every Mon 09:00, propose 3 topic cards (using current materials + last cycle's data) and scaffold project folders." Human picks.
- **Auto-report**: `/schedule` "1st of month → performance report + flag decaying articles for refresh."
- **Poll indexation**: `/loop 5m` after publishing until indexed.

## Gates as fuses (keep humans only at 3 points)
- Evidence gate (P2): `PreToolUse(Write|Edit)` hook blocks writing while any `unverified` quant claim remains.
- QA gate (P8): independent reviewer subagent; not "ship" → auto-bounce to draft.
- Human touchpoints: **review** (topic/audit/copy), **confirm** (release at gates), **publish**.

## Auto-tidy (5S)
| 5S | Automated action |
|---|---|
| Sort | gate-failed drafts bounced; duplicates/old → archive (don't delete) |
| Set-in-order | production in `articles/<slug>/`; published in `<dir>/<domain>/<YYYYMM>/` |
| Shine | delete `.DS_Store` / `__pycache__`; enforce kebab-case keyworded names |
| Standardize | README/CLAUDE.md kept consistent with reality; one handbook, one skill set |
| Sustain | update published index on release; weekly/monthly retros |

Trigger by saying "tidy" / "5S", or via a post-run hook.

## Refresh loop (Act → Plan)
Decision tree: indexed but low rank → revisit intent (P1); ranks well but not AI-cited → revisit citability/structure (P7, `semantic-gap-analysis`); both fine but no conversion → revisit ICP (P0). Decaying traffic → `content-refresher` / `improve-content`.
