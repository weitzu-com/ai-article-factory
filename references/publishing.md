# Publishing — website first, then social

Order rule: **publish to the website first (canonical URL), then drive social traffic back to it.** Route by `target-domain`.

## Website (WordPress example; adapt to your CMS)
**Pre-publish**: category/tags; slug = short, keyworded, **never changed after publish** (else 301); single H1; images uploaded with alt + compressed/WebP; SEO plugin meta (title ≤60, description ≤155, OG); confirm indexable + self-canonical; JSON-LD (`Article`/`TechArticle` + `FAQPage`) injected via the plugin's schema tab / FAQ block (don't hand-write); author bio + dates; ≥2 internal links into the topic cluster.

**Publish + indexing**: push live → **purge all caches/CDN** (critical on cached hosts, or crawlers get stale versions) → copy live URL → submit sitemap + the URL to **Google Search Console** and **Bing Webmaster Tools** (Bing feeds Copilot/ChatGPT — important for GEO) → log to the published index.

**Post-publish**: validate JSON-LD (Rich Results Test) → check Core Web Vitals (PageSpeed) → run an on-page audit on the live URL.

> Managed-host gotchas (e.g. SiteGround): staging subdomains are noindex — only submit the live URL; always purge cache after publish/edit; aggressive JS combine/defer can break layout — eyeball the live page.

## LinkedIn / X
- LinkedIn: post the `-linkedin.md` version; link in first comment; reply to all comments in the first hour (algorithm weights early engagement); carousels get the highest engagement.
- X: post the `-x.md` thread; link in the last tweet.

## Published archive (by domain)
Store published outputs by destination: `<published-dir>/<target-domain>/<YYYYMM>/`. This keeps production (one folder per article) separate from publication (organized by where it went) — and supports multiple sites cleanly.
