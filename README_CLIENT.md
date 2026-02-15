# SEO Shopify Blog Generator (Agents + HITL) for n8n

Client-ready n8n workflow that turns a topic into a publishable Shopify blog article with SEO metadata, grounded research, and automated quality checks.

## What This Automates

- Researches the topic via Google SERP (SerpAPI) and selects the best sources.
- Scrapes selected sources (direct fetch, with optional Firecrawl fallback for difficult pages).
- Builds a research context pack (sources + extracted facts) to prevent hallucinations.
- Generates:
  - Blog plan (content pillars, post ideas, checklist)
  - SEO brief (outline, FAQ, table spec, on-page SEO rules)
  - Draft HTML article (Shopify-ready)
  - Fact-checked final article + citations
  - Shopify SEO metafields (title + meta description)
- Enforces quality via a deterministic quality gate (word count, headings, citations, HTML structure) with optional rewrite attempts.

## Workflow File

- Main workflow JSON:
  - `workflows/local_5679_kali_a/personal/generate_seo_shopify_blog_article_agents_hitl_enhanced_client.json`

## High-Level Pipeline

1. **Input**
   - User provides a topic via Chat Trigger.
   - Normalization sets defaults (language, country, SERP region, max sources).
2. **SEO Orchestration**
   - Orchestrator agent produces keyword cluster + best SERP query (structured JSON).
3. **Research**
   - SerpAPI returns SERP results.
   - Researcher agent selects the best sources (structured JSON).
4. **Source Scraping**
   - Direct Fetch attempts to retrieve HTML.
   - Firecrawl Scrape (optional) is used if direct fetch fails or returns too little content.
   - HTML extraction produces `{title, metaDescription, body}` for each source.
5. **Research Pack**
   - Aggregates sources into `researchContext` + `sourcesUsed`.
   - Stops early if research coverage is insufficient.
6. **Planning + Writing**
   - Blog Planner generates the blog plan from the research pack.
   - SEO Strategist turns the plan into a writer-ready brief.
   - Writer produces Shopify-ready HTML article (structured JSON).
7. **Verification + Quality Gate**
   - Fact-checker validates claims against the research pack and fixes issues.
   - Quality Metrics checks non-negotiables (structure, length, citations, SEO limits).
   - If quality fails, a rewrite pass can run (configurable).
8. **Publishing**
   - Creates the Shopify article via GraphQL.
   - Sets Shopify SEO metafields via GraphQL (title tag + description tag).

## Quality Controls (Why Output Is Reliable)

- **Structured Output Parsers** enforce valid JSON outputs per agent.
- **Research grounding**: writing and fact-checking are constrained to `researchContext` and `sourcesUsed`.
- **Quality gate** checks:
  - Minimum word count
  - Minimum H2/H3 counts
  - Presence of `<style>` + `<article>`
  - Table included
  - FAQ section included
  - Citation URLs count and format
  - SEO character limits (title/meta)

## AI Design (Professional Setup)

- Each agent can run on its **own OpenAI model node** with role-specific parameters (temperature, model choice).
- Roles:
  - Orchestrator: keyword + SERP query
  - Researcher: source selection
  - Blog Planner: plan and checklist
  - SEO Strategist: brief and outline
  - Writer: HTML draft
  - Fact-checker: accuracy + tightening
  - Rewrite: targeted fixes based on quality feedback

## Requirements

- n8n version: **2.4.6**
- Credentials (configured inside n8n, not hardcoded):
  - OpenAI (for agents)
  - SerpAPI (SERP data)
  - Shopify Admin API access (GraphQL endpoint + access token)
  - Firecrawl API key (optional; improves scraping reliability)

## How To Run

1. Import the workflow JSON into your n8n instance.
2. Set credentials and environment variables.
3. Trigger the workflow from the chat interface with a topic, for example:
   - `"mitigeur de baignoire monotrou remplacement"`
4. The workflow will publish the article to Shopify and set SEO metafields.

## Customization (Non-Technical)

- Language and region:
  - `language`, `country`, `serpLocation`
- Research depth:
  - `maxSources`
- Quality thresholds:
  - `qualityMinWordCount`, `qualityMinH2`, `qualityMinH3`, `qualityMinCitations`
- Rewrite behavior:
  - `maxQualityAttempts` (set to `0` to disable rewrites)

## Security Notes

- Do not store API keys or tokens inside workflow JSON.
- Use n8n credentials and environment variables for secrets.
- Limit Shopify token scope to the minimum required permissions.

## Deliverables

- Shopify blog article (HTML) with:
  - SEO title + meta description
  - Table + FAQ section
  - Citations with real URLs
- Repeatable automation that your team can reuse for consistent content production.

