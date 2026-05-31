# Schema JSON-LD Templates (article-optimize)

Copy-ready blocks for the factory's optimization stage. First-party, self-contained — no schema tool required. Replace every `[…]` placeholder, delete fields you cannot verify on the visible page, then run the static validation in `SKILL.md` step 6.

## Shared rules (non-negotiable)

- **Mirror visible content.** Every value here must appear on the rendered page. Schema that out-runs the visible text gets the page demoted.
- **Absolute canonical URLs** only (`https://example.com/slug`, never relative paths).
- **ISO 8601** for dates/times (`2026-05-29T09:00:00+08:00`) and durations (`PT1H30M`).
- **No leftover placeholders.** A `[Title]` shipping to production is a defect.
- Emit `aggregateRating` / `review` **only** when visible, verifiable reviews back the exact numbers — otherwise omit entirely.
- One `<script type="application/ld+json">` block per page; if multiple types are needed, put complete objects in a single array (see Combined Array below).
- Author must be a **named Person** (the factory's "trust is proven, not claimed" rule), not the org.

---

## Article

Default for a standard article / blog post. (`@type` may also be `BlogPosting` or `NewsArticle` when that better fits.)

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "[Title — match the H1, ≤110 chars]",
  "description": "[One-sentence summary, matches meta description]",
  "image": ["[Absolute lead image URL]"],
  "datePublished": "[ISO 8601 publish date-time]",
  "dateModified": "[ISO 8601 last-modified date-time]",
  "author": {
    "@type": "Person",
    "name": "[Author Full Name]",
    "url": "[Author profile/bio URL]",
    "jobTitle": "[Credential, e.g. Senior SEO Engineer]"
  },
  "publisher": {
    "@type": "Organization",
    "name": "[Publisher Name]",
    "logo": { "@type": "ImageObject", "url": "[Absolute logo URL]" }
  },
  "mainEntityOfPage": { "@type": "WebPage", "@id": "[Canonical page URL]" }
}
```

**Required**: `headline`, `image`, `datePublished`, `author`, `publisher`. **Strongly add**: `dateModified`, `description`, `mainEntityOfPage` (helps both rich results and AI entity grounding).

---

## TechArticle

Use instead of `Article` for developer / technical "how it works" content (APIs, architecture, configuration, troubleshooting). Same base as `Article` plus difficulty and dependency hints AI engines use to scope answers.

```json
{
  "@context": "https://schema.org",
  "@type": "TechArticle",
  "headline": "[Technical title]",
  "description": "[What the reader will be able to do/understand]",
  "image": ["[Absolute diagram/screenshot URL]"],
  "datePublished": "[ISO 8601]",
  "dateModified": "[ISO 8601]",
  "author": { "@type": "Person", "name": "[Author Name]", "jobTitle": "[Engineering credential]" },
  "publisher": { "@type": "Organization", "name": "[Publisher Name]", "logo": { "@type": "ImageObject", "url": "[Logo URL]" } },
  "mainEntityOfPage": { "@type": "WebPage", "@id": "[Canonical URL]" },
  "proficiencyLevel": "[Beginner | Intermediate | Expert]",
  "dependencies": "[Prerequisites, e.g. Node 20+, basic SQL]"
}
```

---

## FAQPage

Add only when the page shows a **visible** FAQ section. Each `name`/`text` must match the on-page question/answer verbatim. Use the user's real query phrasing.

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question 1 — exact visible phrasing]",
      "acceptedAnswer": { "@type": "Answer", "text": "[Answer 1 — matches visible text, answer-first, 40–120 words]" }
    },
    {
      "@type": "Question",
      "name": "[Question 2]",
      "acceptedAnswer": { "@type": "Answer", "text": "[Answer 2]" }
    }
  ]
}
```

**Rules**: 3+ Q&A pairs recommended; every pair must exist visibly on the page; no promotional or duplicated answers; do not reuse the same FAQ block across many URLs.

---

## HowTo

Add when the article is step-based (`--howto`). `step[]` is required; `totalTime`, `supply`, `tool` are optional and only when visible on the page.

```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "[How-to title — matches H1]",
  "description": "[One-sentence outcome]",
  "totalTime": "PT[H]H[M]M",
  "supply": [{ "@type": "HowToSupply", "name": "[Material]" }],
  "tool": [{ "@type": "HowToTool", "name": "[Tool]" }],
  "step": [
    { "@type": "HowToStep", "position": 1, "name": "[Step 1 title]", "text": "[Instruction, action verb first]", "url": "[Canonical URL]#step1" },
    { "@type": "HowToStep", "position": 2, "name": "[Step 2 title]", "text": "[Instruction]", "url": "[Canonical URL]#step2" }
  ]
}
```

**Rules**: 5–8 steps that match the visible ordered list; each `text` is a complete, executable instruction; `url` anchors point to the visible step on the page.

---

## Combined array (Article + FAQPage + HowTo on one page)

When a single article has a visible FAQ and is also a how-to, emit one script block containing complete objects:

```html
<script type="application/ld+json">
[
  { "@context": "https://schema.org", "@type": "Article", "headline": "…", "...": "…" },
  { "@context": "https://schema.org", "@type": "HowTo", "name": "…", "step": [ … ] },
  { "@context": "https://schema.org", "@type": "FAQPage", "mainEntity": [ … ] }
]
</script>
```

---

## Preflight (static, no tooling required)

- [ ] Valid JSON: double quotes only, no trailing commas, balanced `{}` and `[]`.
- [ ] `@context` = `https://schema.org`; every object has an `@type`.
- [ ] All required fields present; zero `[…]` placeholders remain.
- [ ] Dates ISO 8601; URLs absolute and canonical.
- [ ] Every value (headline, FAQ Q&A, steps, ratings) is visible on the page.
- [ ] Author is a named Person.
- [ ] Optional online confirmation: `validator.schema.org` + Google Rich Results Test.
