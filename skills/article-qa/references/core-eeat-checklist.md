# CORE-EEAT refined checklist — grouped scoring + veto items

A distilled, operational version of the 80-item CORE-EEAT benchmark. The full benchmark scores 80 micro-items across 8 dimensions; for a publish-gate decision you do not need that granularity. Instead, score each dimension as **2–3 grouped checks**, each Pass (10) / Partial (5) / Fail (0), then average the group scores to a 0–100 dimension score.

> Method distilled from the CORE-EEAT 80-item framework and the E-E-A-T dimension rubrics (Apache-2.0). Re-expressed as gate-oriented groups; not a copy.

**Score each group:** Pass = 10 · Partial = 5 · Fail = 0.
**Dimension score** = (sum of its group scores ÷ number of scored groups) × 10, on a 0–100 scale.
**N/A:** a group needing site-level data unavailable from the page → mark N/A and exclude from that dimension's average (do not score 0).
**Rating:** 90–100 excellent · 75–89 good · 60–74 medium · 40–59 low · <40 poor.

---

## CORE — content body / AI-citability (GEO half)

### C — Contextual clarity
- **C-a Intent & direct answer** — title matches body; a self-contained 40–60-word answer sits up top and under each H2; the searcher's question is answered before scrolling. *(veto: see V1)*
- **C-b Coverage & scope** — covers the query and its obvious follow-ups; states who it's for and what's in/out of scope; key terms defined on first use.
- **C-c Semantic closure** — conclusion loops back to the opening promise; no dangling sub-topic introduced and abandoned.

### O — Organization
- **O-a Hierarchy & chunking** — logical H2/H3 nesting; each section is skimmable; no wall-of-text blocks.
- **O-b Structured units** — comparisons as tables, steps as ordered lists, definitions as callouts, Q&A as FAQ — so the right shape carries the right content (and stays AI-extractable).
- **O-c Information density** — every paragraph earns its place; no filler, no throat-clearing intros, no repetition.

### R — Referenceability
- **R-a Evidence–claim mapping ★veto** — every checkable claim maps to a primary source at an exact locator; data stated precisely; nothing sourced to competitor blogs / content farms. *(veto: see V3)*
- **R-b Consistency ★veto** — numbers, names, and claims agree across the whole piece; no figure in the intro contradicts the table. *(veto: see V4)*
- **R-c Freshness & traceability** — time-sensitive facts are current (year within `[current_year − 2, current_year]` unless explicitly evergreen); update/version signal present; entities named consistently.

### E — Exclusivity
- **E-a Original input** — at least one of: original data, a novel framework, primary research, proprietary visuals — something the top results don't have.
- **E-b Depth & synthesis advantage** — goes beyond what a smart generalist could write in 30 minutes; synthesizes rather than summarizes; offers a forward or contrarian insight that's defensible.

---

## EEAT — source credibility (SEO / trust half)

### Exp — Experience
- **Exp-a First-hand evidence** — first-person observations with specifics (what was tried, what happened, dates, values); the "30-second smell test" — does it read like someone who actually did the thing?
- **Exp-b Honest texture** — problems encountered, limitations, before/after, failure stories — the details only hands-on work reveals.

### Ept — Expertise
- **Ept-a Accuracy & depth** — claims correct and verifiable; correct terminology; edge cases acknowledged; reasoning shown, not just conclusions.
- **Ept-b Credentialed authorship** — a named author whose relevant expertise is plausible for the topic. *(YMYL: credentials must be specific to the field and externally verifiable — see YMYL note.)*

### A — Authority *(mostly site-level — mark N/A when auditing a standalone page)*
- **A-a Topical standing** — the piece sits in a coherent topical cluster; the author/site has a track record on this specific topic. *(N/A if site context unavailable.)*
- **A-b External validation** — citations, mentions, or recognition from outside the site. *(N/A if not observable from the page.)*

### T — Trust
- **T-a Disclosure & disclaimers ★veto** — affiliate/sponsored relationships disclosed prominently; YMYL "not professional advice" disclaimer present where the content could be misread as such. *(veto: see V5)*
- **T-b Transparency** — methodology for original data explained; willing to name limitations and even recommend alternatives; correction/update policy visible.
- **T-c Accuracy floor** — no factual errors, no outdated guidance on time-sensitive topics. *(On YMYL, a single factual error fails this group outright.)*

---

## Veto items (one-票否决) — any one → NO-SHIP

These are the deal-breakers. A failure here **caps the affected dimension** and forces an overall **no-ship** regardless of every other score. They are the same checks as the SKILL's Step 0 emergency brake, stated here per-dimension:

| ID | Veto | Lives in | Fails when |
|----|------|----------|-----------|
| **V1** | Intent mismatch / clickbait | C-a | Title/H1 promises something the body doesn't deliver. |
| **V2** | Unsupported factual claim | R-a | A checkable claim is stated as fact with no ledger row, or the row is `待核 (unverified)`. |
| **V3** | Non-primary source as authority | R-a | A load-bearing claim rests on a competitor blog / content farm / circular citation. |
| **V4** | Self-contradiction | R-b | Two places in the article assert incompatible numbers or claims. |
| **V5** | Missing required disclosure | T-a | Affiliate/sponsored relationship undisclosed, or YMYL content lacks a professional-advice disclaimer. |

**Cap rule:** when a veto fails, the affected dimension is capped at **60/100** (a ceiling, not a floor — don't raise an already-lower score), and the overall verdict is **no-ship**. If **2+ vetoes** fail, don't bother computing a polished score — report **no-ship / blocked** and list both as must-fix.

---

## YMYL note — raise the bar

If the topic can affect a reader's **health, money, legal standing, safety, or civic participation** (medical, financial, legal, safety-critical DIY, parenting, elections/benefits, or high-consequence purchases), apply the stricter standard:

- **Expertise** is the biggest shift — the author needs field-specific, **externally verifiable** credentials (medical license, CFP/CFA, bar admission, licensed trade), linked so a reader can confirm. An unverifiable "Dr. Smith, MD" is worse than no bio.
- **Trust** is non-negotiable — every claim linked to a primary source; a single factual error fails T-c and the factual-accuracy veto; disclaimers required; conflict-of-interest disclosure cannot be buried.
- When unsure whether a topic is YMYL, **treat it as YMYL** — a false positive costs nothing; a false negative ships harmful content under a lenient bar.

YMYL ship threshold is higher: only ship when Trust and Expertise are clearly **good (≥75)**, not merely passing.

---

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
