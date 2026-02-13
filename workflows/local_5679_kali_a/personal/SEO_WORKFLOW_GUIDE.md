# 🚀 SEO Shopify Blog Generation Workflow - Complete Guide

**Workflow:** `Generate - SEO - Shopify Blog Article (Agents + HITL)`  
**Status:** Production-ready with testing mode  
**Total Nodes:** 62 (38 functional + 24 documentation notes)

---

## 📊 Workflow Overview

This multi-agent orchestration workflow automatically generates SEO-optimized Shopify blog articles from a user-provided topic. It combines:
- **LLM Agents** (5x OpenAI gpt-4o-mini for specialized roles)
- **Vector Memory** (Supabase pgvector for grounded research)
- **Human-in-the-Loop** (Slack approval before publication)
- **Error Handling** (Graceful degradation on API failures)
- **Test Mode** (Draft articles before going live)

---

## 🎯 Workflow Stages

### Stage 1: RESEARCH (Nodes 01-17)
**Goal:** Gather and index research materials from web sources.

| Node | Type | Purpose |
|------|------|---------|
| **01** | Chat Trigger | User provides topic via n8n chat |
| **02** | Set | Normalize parameters (language, country, test mode, etc) |
| **03** | Agent | Orchestrator: expand topic into keyword cluster |
| **04** | HTTP GET | SERPAPI: fetch Google search results |
| **05** | Code | Validate SERP response, extract top 20 results |
| **06** | Agent | Researcher: select best N sources from SERP |
| **07** | Code | Convert sources into loop items |
| **08** | Loop | Iterate over each source (batch size=1) |
| **09** | IF | Check if Firecrawl API available |
| **10** | HTTP POST | Firecrawl: scrape markdown (preferred) |
| **11** | HTTP GET | Direct fetch: fallback scraping (raw HTML) |
| **12** | Code | Clean HTML → text, validate min 50 chars |
| **13** | IF | Check if text is valid for storage |
| **14** | Loader | Convert text to LangChain Documents |
| **15** | Embedding | Vectorize using text-embedding-3-small |
| **16** | Insert | Store document + embedding in Supabase |
| **17** | Tool | Make vector store searchable for agents |
| **18** | Code | Exit loop, collapse N items → 1 |

**Output:** Vector database populated with 6 researched sources. Research context ready for content generation.

---

### Stage 2: ANALYSIS (Nodes 20-20a)
**Goal:** Build SEO strategy and content structure.

| Node | Type | Purpose |
|------|------|---------|
| **20** | Agent | SEO Strategist: create content brief |
| **20a** | Parser | Validate brief JSON schema |

**Uses Tools:**
- `ResearchMemory`: Retrieve relevant facts from vector store

**Outputs:**
- Title, slug, SEO title (≤60 chars), meta description (≤150 chars)
- Content outline (H2/H3 hierarchy)
- FAQ questions/answers
- Table specification
- Internal/external link suggestions

---

### Stage 3: CREATION (Nodes 21-22a)
**Goal:** Write and fact-check the blog article.

| Node | Type | Purpose |
|------|------|---------|
| **21** | Agent | Content Writer: write full HTML article |
| **21a** | Parser | Validate contentHtml JSON schema |
| **22** | Agent | Fact-Checker: verify claims, enforce limits |
| **22a** | Parser | Validate final article JSON schema |

**Uses Tools:**
- `ResearchMemory`: Ground all claims in research

**Outputs:**
- Production-grade HTML (valid, clean, no scripts)
- Summary (2-3 sentences)
- Citations (url + title)

---

### Stage 4: DISTRIBUTION (Nodes 30-35)
**Goal:** Get human approval and publish to Shopify.

| Node | Type | Purpose |
|------|------|---------|
| **30** | Slack | Send & Wait: preview article, ask approve/reject |
| **31** | IF | Route: approved → publish, rejected → notify |
| **32** | GraphQL | Create article in Shopify (with testMode check) |
| **33** | GraphQL | Attach SEO metafields (title_tag, description_tag) |
| **34** | Slack | Success notification |
| **35** | Slack | Rejection notification |

**Approval Message Shows:**
- Title
- SEO Title
- Meta Description
- Article Slug

**testMode Behavior:**
- `true` → isPublished=false (draft only)
- `false` → isPublished=true (live publish)

---

## 🔧 Configuration & Environment Variables

### Required Environment Variables

```bash
# OpenAI
OPENAI_API_KEY=sk-...

# SerpAPI (Google Search)
SERPAPI_API_KEY=...

# Firecrawl (Web Scraping - Optional but Recommended)
FIRECRAWL_API_KEY=...
FIRECRAWL_SCRAPE_URL=https://api.firecrawl.dev/v2/scrape  # Default

# Supabase (Vector Store)
SUPABASE_PROJECT_URL=https://xxxx.supabase.co
SUPABASE_API_KEY=...
SUPABASE_VECTOR_TABLE=documents  # Default table name

# Shopify
SHOPIFY_STORE_DOMAIN=mystore.myshopify.com
SHOPIFY_ADMIN_API_TOKEN=shpat_...
SHOPIFY_BLOG_ID=12345  # Blog ID in Shopify
SHOPIFY_API_VERSION=2026-01  # Default

# Slack
SLACK_APPROVAL_CHANNEL_ID=C12345678  # Channel for approvals

# Content Settings
CONTENT_LANGUAGE=en          # Language for content
SERP_COUNTRY=US              # Country for SERP
SERP_LOCATION=United States  # Location for SERP
SEO_MAX_SOURCES=6            # Max sources to research
SCRAPED_TEXT_MAX_CHARS=20000 # Max text per source

# Mode
TEST_MODE=false  # true=draft only, false=live publish
```

### Node-Specific Credentials
- **Node 03, 06, 20, 21, 22 (Agents):** Use `LLM - OpenAI Chat` (shared instance)
- **Node 15, 17 (Embeddings & Vector):** Use Supabase credentials
- **Node 30, 34, 35 (Slack):** Use Slack OAuth2 credential

---

## 🤖 The 5 Agents Explained

### 1. **Orchestrator Agent** (Node 03)
- **Role:** Manager/Strategist
- **Input:** Topic, language, country
- **Output:** Keyword cluster (primary keyword, LSI, long-tail, search intent, SERP query)
- **Mindset:** Enterprise SEO manager. Never invents facts.

### 2. **Researcher Agent** (Node 06)
- **Role:** Analyst
- **Input:** SERP results (20 links)
- **Output:** Selected sources (N=maxSources, typically 6)
- **Mindset:** Strict web researcher. Prefers authoritative sources.

### 3. **SEO Strategist Agent** (Node 20)
- **Role:** Content Planner
- **Input:** Keyword cluster, research context (via ResearchMemory tool)
- **Output:** Detailed content brief (outline, FAQ, table, links)
- **Tools:** ResearchMemory (retrieves top-6 relevant documents)
- **Mindset:** Strategic planner. No hallucinations; data-driven.

### 4. **Content Writer Agent** (Node 21)
- **Role:** Author
- **Input:** SEO brief, research context
- **Output:** Full HTML article, summary, citations
- **Tools:** ResearchMemory (retrieves supporting evidence)
- **Mindset:** Professional blogger. Writes clean, valid HTML only.

### 5. **Fact-Checker Agent** (Node 22)
- **Role:** Quality Assurance / Editor
- **Input:** Draft article from Writer
- **Output:** Final verified article (claims checked, limits enforced)
- **Tools:** ResearchMemory (cross-references claims)
- **Constraints:**
  - SEO title ≤ 60 characters
  - Meta description ≤ 150 characters
  - Remove any unverifiable claims

---

## 📈 Data Flow & Transformations

```
Chat Input
    ↓
[02] Normalize (add language, country, testMode, idempotentKey)
    ↓
[03] Orchestrator (expand topic → keyword cluster)
    ↓
[04] SERP Search (get top 20 results for keyword)
    ↓
[05] SERP Validation (filter, check for errors)
    ↓
[06] Researcher Agent (select best 6 sources)
    ↓
[07] Build Items (convert to loop format)
    ↓
[08-17] LOOP: For each source
    ├─ [09] IF Firecrawl available?
    ├─ [10] Firecrawl Scrape OR [11] Direct Fetch
    ├─ [12] Normalize Text (clean HTML)
    ├─ [13] IF valid text?
    ├─ [14] Load Document
    ├─ [15] Generate Embeddings
    ├─ [16] Insert into Vector Store
    └─ Repeat for next source
    ↓
[18] Collapse Context (exit loop, 1 item)
    ↓
[20] SEO Strategist (build brief, uses ResearchMemory)
    ↓
[21] Content Writer (write HTML, uses ResearchMemory)
    ↓
[22] Fact-Checker (verify, enforce limits)
    ↓
[30] Slack Approval Gate (send & wait for response)
    ↓
[31] IF Approved?
    ├─ YES → [32] Create Article → [33] Set Metafields → [34] Notify Published
    └─ NO  → [35] Notify Rejected
```

---

## ⚙️ Error Handling & Resilience

| Scenario | Handling | Fallback |
|----------|----------|----------|
| **SERPAPI timeout/fails** | `continueOnFail: true` + error flag | Agents notified in output |
| **Firecrawl unavailable** | Route to Direct Fetch (Node 11) | Raw HTML instead of markdown |
| **Scrape text too short** | Skip to next source (Node 13) | Continue with valid sources |
| **Agent JSON parsing fails** | Output parser re-attempts | Falls back to raw agent output |
| **Shopify API fails** | `continueOnFail: true` | Error logged, notification sent |

---

## 🧪 Testing with Test Mode

### Running in Draft Mode:
```bash
TEST_MODE=true
```

**Behavior:**
- Executes entire workflow
- Creates article in Shopify with `isPublished=false` (draft)
- Allows preview without going live
- Still sends approval notification

### Production Mode:
```bash
TEST_MODE=false
```

**Behavior:**
- Creates article with `isPublished=true` (live immediately)
- Indexed by search engines upon creation
- Visible on storefront

---

## 📝 Sample Workflow Execution

**User Input:**
```
topic: "Best Budget Laptops for Students 2026"
language: en
country: US
testMode: false
```

**Process:**
1. Orchestrator expands: primary keyword = "best budget laptops students", LSI = ["affordable laptops", "student laptops", "cheap laptops"]
2. SERP searches: "best budget laptops students 2026" → 20 results
3. Researcher selects: Top 6 sources (Techradar, TechAdvisor, Tom's Hardware, etc)
4. Loop scrapes all 6 → stores in vector DB (6 documents indexed)
5. SEO Strategist creates brief: "Best Budget Laptops for Students in 2026"
6. Writer drafts: Full HTML article with H2/H3, table (compare 5 laptops), FAQ
7. Fact-Checker verifies all claims against research
8. Slack asks: "Approve publication?"
   - User responds: "approve"
9. Article created in Shopify (live)
10. SEO metafields set
11. Slack notification: "Published: Best Budget Laptops for Students in 2026"

---

## 🔍 Monitoring & Debugging

### Key Flags in Node Outputs:
- `__serp_ok`: true if SERP results valid
- `__error`: error message if node fails
- `__scrape_error`: reason text scrape failed
- `__collapse_ok`: vector loop completed successfully

### Check Vector Store:
```sql
-- Supabase
SELECT COUNT(*) FROM documents;
SELECT id, content, metadata FROM documents LIMIT 5;
```

### View Agent Outputs:
- Each agent (03, 06, 20, 21, 22) has a `Parser` node
- Parsers validate JSON schema and show parsing errors
- Check n8n execution UI → view node output for full JSON

---

## 🎓 Best Practices

1. **Start with TEST_MODE=true** to validate workflow with your data
2. **Monitor vector store size** (avoid excessive storage costs)
3. **Adjust SEO_MAX_SOURCES** (6-10 typical; more = higher cost)
4. **Review Slack approvals carefully** before publishing
5. **Test Firecrawl first** (better quality than raw fetch)
6. **Use consistent language** (set CONTENT_LANGUAGE environment variable)
7. **Track idempotent keys** to avoid duplicate articles

---

## 📞 Support & Troubleshooting

### "No SERP results found"
- Check SERPAPI_API_KEY validity
- Verify keyword is searchable (try in Google manually)
- Check location/language settings match SERP

### "Text too short or empty"
- Source page may be JavaScript-heavy
- Try increasing SCRAPED_TEXT_MAX_CHARS
- Firecrawl may extract better than direct fetch

### "Agent output not valid JSON"
- Agent may have hallucinated. Check ResearchMemory results.
- Increase agent temperature (reduce determinism)?
- Check LLM context isn't exceeded

### "Shopify article not created"
- Verify SHOPIFY_ADMIN_API_TOKEN has `write_articles` scope
- Check SHOPIFY_BLOG_ID is correct
- Verify API version matches Shopify store

---

## 📚 Additional Resources

- [n8n Workflow Docs](https://docs.n8n.io)
- [LangChain Agents](https://docs.langchain.com/docs/modules/agents)
- [Supabase Vector Search](https://supabase.com/docs/guides/database/pgvector)
- [Shopify Admin API](https://shopify.dev/api/admin-rest)
- [SerpAPI Docs](https://serpapi.com/docs)
- [Firecrawl API](https://www.firecrawl.dev/docs)

---

**Last Updated:** 2026-02-13  
**Workflow ID:** KLYU1xiQY4fwyof1  
**Version:** 1.2 (Reorganized with explanation notes)
