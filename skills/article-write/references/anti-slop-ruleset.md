# Anti-AI-Slop Ruleset (反 AI 腔铁律)

The reference for move 5 (anti-slop) and the final slop sweep in `SKILL.md`. This is a **quality standard**, not a detector dodge — the goal is writing genuinely better than default model output, not tricking a classifier.

Why slop is detectable: RLHF strips high-entropy choices (unique detail, strong opinion, odd rhythm), leaving low **burstiness** (uniform sentence length) and low **perplexity** (predictable words). Both human readers and machines read that as machine-written, and bland text drives bounce, which hurts rankings. The fix is to write with voice from the start, not to "humanize" after — post-processing has its own detectable signature.

**Order matters:** inject voice and specificity FIRST, then run this audit. Stripping tells from a voiceless draft yields sterile slop, which is just as obvious.

---

## 1. Banned vocabulary

### Tier 1 — never use (each one alone flags a draft)

delve, leverage (verb), utilize, facilitate, commence, endeavor, embark, harness, navigate (metaphorical), spearhead, bolster, underscore, culminate, robust, seamless, innovative, comprehensive (as adjective), multifaceted, nuanced, pivotal, intricate, paramount, crucial, compelling, vibrant, transformative, meticulous, cutting-edge, revolutionary, game-changer, testament, tapestry, realm, landscape (metaphorical), plethora, myriad, showcase, streamline.

Plain replacements:

| Slop | Use instead |
|---|---|
| leverage / utilize | use |
| facilitate | help, enable |
| commence | start, begin |
| endeavor | try |
| robust | strong, solid |
| seamless | smooth, easy |
| innovative | new |
| comprehensive | full, complete |
| paramount / crucial / pivotal | key, critical |
| plethora / myriad | many, lots of |
| culminate | end in, lead to |
| underscore | show, highlight |
| delve | dig into, look at |
| testament | proof, sign |
| landscape | space, market, field |
| showcase | show |
| streamline | simplify |

### Tier 2 — flag when clustered (3+ in one article = rewrite)

however (more than twice), notably, essentially, arguably, that said, on the other hand, moving forward, here's the thing, at the end of the day, it's no secret that, paired adjectives ("clear and concise", "powerful and flexible"), firstly / secondly / thirdly.

### Tier 3 — flag at high density (3+ clustered)

Overused transitions (therefore, consequently, meanwhile); corporate buzzwords (scalable, optimize, synergy, streamlined); excessive qualifiers (quite, rather, somewhat, fairly, relatively); hedging stacks (perhaps, might, could potentially, to some extent).

---

## 2. Banned phrases (never, regardless of count)

- "It's worth noting that…" / "It's important to note that…"
- "In today's [anything] landscape / world / era"
- "Let's dive in" / "Without further ado" / "Buckle up" / "Strap in"
- "In conclusion" / "In summary" / "In essence"
- "Plays a crucial / vital / pivotal role"
- "Stands as a testament to…"
- "In the realm of…"
- "It goes without saying"
- "Marking a pivotal moment in the evolution of…"
- "In this article, we'll cover…" / "This guide will explore…"
- "Studies show…" / "Experts agree…" with no named source — replace with the specific source + date from the ledger.

---

## 3. Banned structural patterns (千篇一律结构)

1. **Uniform sentence length** — 3+ consecutive sentences within ~3 words of each other. Fix: mix 5-word punches with 30+-word complexes.
2. **Rule of three** — habitual grouping of three examples/adjectives/items. Fix: use 2, 4, or 5.
3. **Topic-sentence-then-support every paragraph.** Fix: open some paragraphs with an example, a question, or a line that only resolves as you read on.
4. **Binary contrast frame** — "it's not X, it's Y" / "no X, no Y, just Z". Fix: just make the argument.
5. **Manufactured staccato** — "Short. Punchy. Exhausting." Fix: fragments only for genuine emphasis, sparingly.
6. **Section-end summaries everywhere.** Fix: summarize only a genuinely complex section (3+ subsections).
7. **Copula avoidance** — "serves as", "functions as", "acts as" where you mean "is". Fix: say "is".
8. **Synonym cycling** — alternating words for one concept to look varied (customers → clients → users → patrons). Fix: repeat the clearest word.
9. **Participial tack-ons** — "…, highlighting the importance of X" / "…, underscoring the need for Y". Fix: delete, or make it its own sentence.
10. **Em-dash chains** — max 1–2 per 1,000 words. Fix: commas, parentheses, or a new sentence.
11. **The hourglass** — synthesis → detail → synthesis. Fix: start specific, zoom out, dive in unevenly, end specific.
12. **Symmetric coverage** — equal word count per subtopic. Fix: spend the words where it's interesting (500 on the part that matters, 50 on the dull-but-necessary part).

---

## 4. The two-pass audit

**Pass 1 — detect and rewrite.** Scan the whole draft against §1–§3. For each hit: quote it, name the tier/pattern, rewrite to keep the meaning and kill the tell, apply it.

**Pass 2 — survivors.** Re-scan. First-pass rewrites re-introduce tells (the model's defaults reassert). Specifically check: recycled transitions, one slop word swapped for another slop word (leverage → harness fixes nothing — go to "use"), copulas that crept back, new uniformity the rewrites created. Research says ~15–20% of tells survive pass 1.

---

## 5. The final tests

- **Horoscope test** — for each paragraph: "could this appear in any article, for anyone, about anything?" If yes, it fails the citation/voice checks regardless of clean vocabulary. Every paragraph needs one element specific to THIS topic, audience, moment.
- **Read-aloud / bar test** — would you say this sentence to a colleague over coffee? "The implementation demonstrated significant improvements in KPIs" → "It worked. Revenue went up 18% `[C4]`." If it sounds like a textbook, rewrite.
- **Rhythm check** — if a paragraph's sentence-length standard deviation is under ~5 words, vary it.

---

## 6. Don't over-correct

- More editing ≠ more human. Every sentence a fragment, every paragraph opening with "Look," — that's a new tell. One technique overused becomes its own signature.
- No deliberate typos. Intentional typos are a different pattern from natural ones.
- Respect register. An academic piece *is* more formal than a blog post — match the content type, don't force a dissertation to sound casual or vice versa.
- One mild redundancy or one slightly-loose sentence is fine. Perfect prose reads as machine prose.

## 7. Non-English drafts

The word lists above are **English** tells. When writing in another language, apply the *equivalent* clichés and the machine-translation giveaways of that language (stock connectors, over-formal register, literal calques), not a translated copy of the English list. The structural patterns in §3 and the tests in §5 are language-independent — apply them as written.

---

*Distilled from the `write-content` skill's `anti-slop-ruleset.md` and `voice-injection-playbook.md`, Apache-2.0; original concise reimplementation for the ai-article-factory P5 drafting stage.*
