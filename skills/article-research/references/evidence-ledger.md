# Evidence Ledger Discipline

Used in Workflow Step 6 (the P2 hard gate). The rule is absolute: **every checkable claim earns a ledger row with a primary source and an exact locator before it can become a sentence.** No row → no claim. The downstream draft cites rows as `[C#]`.

## What counts as "checkable" (must be sourced)
- **Numbers / stats** — any figure, percentage, price, date, count, growth rate.
- **Definitions** — "X is defined as…", category boundaries, named concepts.
- **Standards / specs** — RFCs, ISO/IEEE, regulations, official thresholds, version requirements.
- **Causal claims** — "X causes / improves / reduces Y."
- **Comparisons** — "A is faster/cheaper/better than B", rankings, superlatives ("the first", "the largest").
- **Attributed statements** — "According to <person/org>…".

Common knowledge, the author's own opinion (clearly framed as opinion), and the user's own first-party experience do not need an external source — but first-party data still gets a row (source = the user's material, located precisely).

## Ledger schema (`02-证据台账.md`)

| ID | Claim (as it will appear) | Source (primary) | Exact locator | Grade | Notes |
|----|---------------------------|------------------|---------------|-------|-------|
| C1 | "…" | <author/org, title, year, URL/file> | <page / section / table / timestamp / quoted line> | primary / disputed / unverified | conflicts, caveats |

### Exact locator — be findable, not vague
- Web page → the section heading or the quoted sentence (so a reviewer can Ctrl-F it).
- PDF / report → page number + table/figure number.
- Dataset → the specific row/column or query.
- Video/audio → timestamp.
- User material → file name + section/line.
"Source: company website" is **not** a locator. "Stripe pricing page, 'Standard' tier table, retrieved 2026-05-29" is.

## Source hierarchy (prefer top, distrust bottom)
1. **First-party** — the user's own data, logs, invoices, screenshots, interview answers. Strongest; competitors cannot replicate it.
2. **Primary / authoritative** — original research papers, official standards bodies, government/regulatory data, the primary creator of the concept, official product docs/pricing, court filings, financial filings.
3. **Reputable secondary** — established journalism, textbooks, recognized industry reports (use to corroborate, trace back to #2 where possible).
4. **Forbidden as authority** — **competitor blogs and marketing pages**. Read them to find gaps and to locate the primary source they cited, then cite that primary source directly. Never cite a competitor blog as proof of a fact.

## Grading
- **primary** ✅ — a #1 or #2 source confirms the claim with an exact locator. Cleared to write.
- **disputed** ⚠ — two credible primary sources conflict, OR a single source is contested. Record **both** and the discrepancy; surface to the human to adjudicate (a P-gate human decision). In the draft, present the range or attribute explicitly ("estimates range from X to Y").
- **unverified** ✗ — no primary source reachable (often: web unavailable, or the figure only traces back to blogs). The claim **may not be stated as fact**. Either drop it, soften to clearly-labeled opinion, or hold it for a live check before publish. Report the count of these at handoff.

## Conflict handling
When sources disagree: keep both rows, note which is more authoritative and why (recency, methodology, proximity to source), and prefer the higher-tier/more-recent one. If it can't be resolved, mark `disputed` and let the human decide — never silently pick one.

## First-party mini-interview (fills evidence gaps without the web)
When the topic needs experience the user holds but hasn't written down, ask **2–3** questions, one at a time, and capture answers verbatim as ledger rows (source = "interview, <date>"):
1. "What do most people get wrong about <topic>?" — extracts a contrarian, hard-to-fabricate take.
2. "Give me a specific example — a client, a project, an exact number." — produces first-party data.
3. "What surprised you when you actually did this?" — surfaces real outcomes and failures.
4. "Who should NOT do this, and why?" — adds scope and nuance.
Adapt by type: how-to → "what step do beginners skip?"; comparison → "which would you recommend to a friend, really?"; case study → "start with the result number, then walk me back." Depth beats breadth — 2–3 strong answers outvalue 8 shallow ones.

## Why this is the GEO/SEO edge
AI engines and Google both reward content that makes verifiable, well-sourced, self-contained claims (E-E-A-T: Experience, Expertise, Authoritativeness, Trust). A ledger of primary-sourced, first-party-backed claims is exactly what gets cited and what competitors synthesizing each other's blogs cannot match.
