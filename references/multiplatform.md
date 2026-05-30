# Multi-platform copy — one master, many forms (一稿多投)

From one master draft, generate platform-native versions. **Never paste the long article verbatim — rewrite per platform.** Target platforms are declared in `00-产品档案.md` (`target-platforms`).

| Platform | Artifact | Rewrite rules |
|---|---|---|
| **Website / WordPress** | `<slug>-final.md` + `<slug>-final.docx` + `<slug>-wp.md` | Full long-form; meta + schema + FAQ + internal links; Word for review/clients. |
| **LinkedIn** | `<slug>-linkedin.md` | Hook in first 2 lines + ONE insight + CTA (link in first comment to avoid downranking) + 3–5 hashtags (core/scope/reach) + carousel suggestion. Single idea, not the whole article. |
| **X / Twitter** | `<slug>-x.md` | 1 hook tweet (≤280 chars) + 5–8 tweet thread, one point each; first tweet carries the hook; 1–2 hashtags; link in the last tweet. |
| **(extensible)** | 公众号 / 小红书 / Newsletter … | per-platform tone & length; add a template as needed. |

## Shared principles
- Lead with the conclusion (answer-first) — works on every platform.
- One first-hand insight / real example makes it feel human and triggers engagement.
- End with a concrete question to invite comments.
- Keep the brand entity name consistent across platforms.

## Routing
`target-domain` (e.g. site-a.com / site-b.ai) decides which website; `target-platforms` decides which social versions to generate. After publishing, archive each under the published layer by domain + month, and log it.
