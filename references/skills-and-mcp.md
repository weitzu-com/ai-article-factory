# Skills · MCP · tools

This skill is an **orchestrator**. It calls worker-skills, MCP servers, and local tools.

## Worker skills (companion packs — install separately)
```bash
npx -y skills@latest add aaron-he-zhu/seo-geo-claude-skills
npx -y skills@latest add inhouseseo/superseo-skills
```
| Stage | Skills |
|---|---|
| Topic/research | `keyword-research` `keyword-deep-dive` `content-gap-analysis` `competitor-analysis` `serp-analysis` `content-brief` |
| Structure | `topic-cluster-planning` `semantic-gap-analysis` |
| First-hand | `expert-interview` |
| Draft | `write-content` (anti-AI-slop) `seo-content-writer` |
| Optimize | `geo-content-optimizer` `meta-tags-optimizer` `schema-markup-generator` `internal-linking-optimizer` `featured-snippet-optimizer` `entity-optimizer` |
| QA | `content-quality-auditor` (CORE-EEAT 80) `eeat-audit` `domain-authority-auditor` (CITE 40) |
| Monitor | `rank-tracker` `performance-reporter` `alert-manager` `backlink-analyzer` |
| Refresh | `improve-content` `content-refresher` |

This skill itself bundles the two capabilities those packs lack: **visuals** (`scripts/render-figures.sh` + `figlib.py`) and **Word export** (`scripts/export.sh`).

## MCP servers (configure in `.mcp.json` or `~/.claude.json`)
| MCP | Used for |
|---|---|
| **Filesystem** | read materials from any path / whole computer |
| **Web Fetch / Web Search** (built-in) | SERP, primary sources, fact-finding |
| **Google Drive** | cloud materials in/out |
| **Notion** | topic backlog / schedule / knowledge base sync |
| **WordPress** (optional) | push drafts to the site (else use `<slug>-wp.md` manually) |
| **Gmail / Calendar** (optional) | schedule reminders / "ready to review" notices |

> New users can ask Claude Code to configure an MCP for them, e.g. "set up a filesystem MCP that can read `/some/path`."

### Minimal filesystem MCP (reads materials from a path)
Add to your project `.mcp.json` (or user `~/.claude.json`):
```json
{
  "mcpServers": {
    "materials": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/you/Documents", "/Users/you/Downloads"]
    }
  }
}
```
List the folders you want readable as extra args. **macOS:** also grant the host app (Terminal / iTerm / VS Code / Claude) **Full Disk Access** in System Settings → Privacy & Security, then restart it — otherwise reads fail with `Operation not permitted`. Without any MCP, the built-in file tools still read paths the app can already access.

### Required vs optional
- **This skill alone**: scaffold + draft + figures (mermaid/matplotlib) + Word export work standalone.
- **Companion packs (recommended for full quality)**: keyword/SERP research, schema, and CORE-EEAT scoring. If absent, those stages run best-effort from the model's own reasoning.

## Local tools
| Tool | For | Install |
|---|---|---|
| pandoc | Markdown → Word (.docx) | `brew install pandoc` |
| mermaid-cli (`mmdc`) | flow/structure figures | `npm i -g @mermaid-js/mermaid-cli` |
| matplotlib | data figures | `python3 -m pip install matplotlib` |

## Claude Code features
- `/schedule` — recurring auto-topic / auto-report (PDCA cadence).
- `/loop` — poll external state (e.g. indexation).
- **Hooks** — `PreToolUse(Write|Edit)` evidence-ledger gate.
- **Subagents** — independent QA reviewer (separate context).
