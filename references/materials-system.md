# Materials system — turn any source into citable evidence (auto-filing)

Materials drive both topic selection and evidence. Two sources:

1. **Shared library** — a folder of reusable authoritative sources (standards PDFs, spec sheets, white papers, datasets) reused across many articles. Keep an index so topic selection can see "what we can write with authority."
2. **User-pointed locations / whole computer** — the user can point to any path ("use `~/Downloads/research/`", "scan my computer for docs about X"). Reached via **filesystem MCP** + file search. Requires OS file access (macOS: grant Full Disk Access to the host app).

## Auto-filing (raw material → evidence)

For each item the agent: **discover → extract → register → grade → index.**

| Source type | Extraction |
|---|---|
| PDF | text (OCR if scanned) → ledger with page locator |
| Word / PPT | `pandoc` → Markdown |
| Excel / CSV | Python (`pandas`/`openpyxl`) → tables/data |
| Web URL | web fetch → main text |
| Image | vision → key points / data, or use as figure source |
| Whole folder | filesystem MCP scan + keyword filter → index |

**Register** into the article's `02-证据台账.md`: claim · type · source file/URL · **exact locator** (page/section/table/clause/anchor) · status.

**Grade**: primary (standards / original data / spec sheets) ✅; `conflict` (sources disagree → human adjudicates); `unverified` (not found → soft phrasing only). **Never** treat competitor blogs / content farms as authority.

**Index**: maintain a shared `素材索引.md` (what exists, where, what topics it covers) so P1 topic selection can reverse-lookup material → defensible, exclusive topics.

## Privacy
Only read paths the user authorizes. When scanning broadly, report what was found before ingesting. Keep source files in place; the ledger stores locators, not copies.
