# 文章项目模板 — 单篇 11 阶段运行手册

> 复制本文件夹到 `articles/<YYYY-MM-DD-slug>/` 即开新文章（`/article` 会自动做）。
> 每阶段：**做什么 → 调哪个技能 → 产物 → Gate**。完整说明见 `00_标准与模板/SEO-GEO-文章创作全流程工作手册.md`。

| # | 阶段 | 调用技能 | 产物 | Gate |
|---|------|---------|------|------|
| 0 | 产品档案 | — | `00-产品档案.md` | 产品/ICP/目标/差异化清晰 |
| 1 | 选题 | `keyword-research` `content-gap-analysis` `competitor-analysis` | `01-选题brief.md` | 一意图/一ICP/一句差异化 |
| 2 | 研究/选资料 | `expert-interview` + 一手来源逐条定位 | `02-证据台账.md` | **无待核量化主张（hook门禁）** |
| 3 | 主题角度 | `content-brief` `serp-analysis` | `03-主题角度.md` | thesis 明确、答案前置 |
| 4 | 大纲 | `topic-cluster-planning` `semantic-gap-analysis` | `04-大纲.md` | 每H2=可独立回答的问题 |
| 5 | 写作 | `write-content`（反AI腔）/ `seo-content-writer` | `05-初稿.md` | 每事实带 `[C#]` |
| 6 | **配图** | Mermaid + matplotlib(`figlib`) + AI封面 | `assets/img/*` + `图清单.md` | ≥3图，过配图规范清单 |
| 7 | SEO/GEO优化 | `geo-content-optimizer` `meta-tags-optimizer` `schema-markup-generator` `internal-linking-optimizer` `featured-snippet-optimizer` | `<slug>-final.md`（嵌图） | SEO≥8 GEO≥8 |
| 8 | 质检 | `content-quality-auditor`(CORE-EEAT80) `eeat-audit` `domain-authority-auditor` | `06-审核报告.md` | ship判定、无一票否决 |
| 9 | **导出** | `scripts/export.sh`（pandoc+品牌模板） | `<slug>-final.docx` | docx 图片正常嵌入 |
| 10 | 发布 | `technical-seo-checker` + 官网WP/SiteGround/Yoast + LinkedIn | `<slug>-wp.md` `<slug>-linkedin.md` | 见手册Stage10清单 |
| 11 | 监测迭代 | `rank-tracker` `performance-reporter` `alert-manager` `content-refresher` | 写入 `03_已发布与监测/` | — |

## 关键命令
```bash
# 配图渲染（mermaid+matplotlib → assets/img/）
bash 00_标准与模板/scripts/render-figures.sh articles/<slug>/
# 导出 Word（图自动嵌入）
bash 00_标准与模板/scripts/export.sh articles/<slug>/ <slug>
```

## 产物清单（完成时应齐全）
```
00-产品档案.md  01-选题brief.md  02-证据台账.md  03-主题角度.md  04-大纲.md  05-初稿.md
assets/{src,img}/  assets/图清单.md  06-审核报告.md
<slug>-final.md   <slug>-final.docx   <slug>-wp.md   <slug>-linkedin.md
```
> 铁律：先有证据再有句子 · 先做对再优化 · P2/P8 是门禁不可跳 · 先官网后LinkedIn。
