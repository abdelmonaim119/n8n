# n8n Workflow Audit Report

## Scope
All workflows under `workflows/local_5679_kali_a/personal` were reviewed individually by trigger, node graph, and connection intent.

## Category Legend
- **A**: Meaningful and useful (kept)
- **C**: Meaningless / duplicate / broken / uncertain (moved to `_Review Before Deletion` or deleted)

## Decisions
| Original Workflow | Category | Action Taken | Current Location / Name |
|---|---|---|---|
| AI Video Avatar Generator_ Turn URLs into Shorts (Using Free Tier APIS).json | A | Kept + renamed + documented | `Marketing/Generate - HeyGen - Avatar Shorts from URLs.json` |
| AI blog generator for Shopify product listings_ Using GPT-4o and Google Sheets.json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Generate - Shopify - Product Blogs from Catalog Data.json` |
| AppontmentLookUP.json | A | Kept + renamed + documented | `Sales/Lookup - CRM - Appointment by Email.json` |
| Automate personalized cold emails with Apollo lead scraping and GPT-4.1.json | A | Kept + renamed + documented | `Lead Generation/Generate - Apollo - Personalized Cold Email Lead Sheet.json` |
| Avatare Generater.json | C | Moved to review (likely older duplicate of avatar flow) | `_Review Before Deletion/Avatare Generater.json` |
| Book Event.json | A | Kept + renamed + documented | `Sales/Create - Google Calendar - Client Appointment Event.json` |
| Booking appointement.json | A | Kept + renamed + documented | `Sales/Orchestrate - MCP Assistant - Appointment Lifecycle Actions.json` |
| Build a Phone Agent to qualify outbound leads and inbound calls with RetellAI -vide.json | A | Kept + renamed + documented | `Sales/Qualify - RetellAI - Leads via Call Outcomes.json` |
| CRM Outbound.json | A | Kept + renamed + documented | `Sales/Orchestrate - CRM - Outbound Prospecting Sequence.json` |
| Check Availlibilty Clander.json | A | Kept + renamed + documented | `Sales/Check - Google Calendar - Appointment Availability.json` |
| ClickUp(Server).json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Serve - ClickUp API - MCP Task Operations.json` |
| ClickUp.json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Assist - Telegram - ClickUp Task Management.json` |
| Client Lookup.json | A | Kept + renamed + documented | `Sales/Lookup - CRM - Client Record by Email.json` |
| Delete Appointment.json | A | Kept + renamed + documented | `Sales/Cancel - Google Calendar - Appointment and CRM Record.json` |
| Email Classifier.json | A | Kept + renamed + documented | `Notifications/Classify - Gmail - Incoming Message Routing.json` |
| FirstOutbound.json | A | Kept + renamed + documented | `Sales/Send - Gmail - First Outbound Message Sequence.json` |
| Generate_ComplexeWorkflows.json | A | Kept + renamed + documented | `Experiments/Generate - AI Agent - Workflow Draft Variants.json` |
| Gmail campaign sender_ Bulk-send emails and follow up automatically if no reply.json | A | Kept + renamed + documented | `Sales/Automate - Gmail - Cold Campaign and Follow-up Sequence.json` |
| IdeaExtractorYoutube.json | A | Kept + renamed + documented | `Lead Generation/Extract - YouTube - Content Ideas Dataset.json` |
| Lovable.json | A | Kept + renamed + documented | `Experiments/Respond - Webhook - Gemini Generated Reply.json` |
| My workflow 2.json | A | Kept + renamed + documented | `Admin - Utilities/Manage - n8n MCP - Workflow Tool Registry.json` |
| My workflow 3.json | C | Moved to review (unclear business purpose) | `_Review Before Deletion/My workflow 3.json` |
| My workflow 4.json | C | Deleted (empty workflow) | deleted |
| My workflow 5.json | C | Deleted (test scaffold) | deleted |
| My workflow 6.json | C | Deleted (test scaffold) | deleted |
| My workflow 7.json | C | Deleted (test scaffold) | deleted |
| My workflow 8.json | C | Deleted (test scaffold) | deleted |
| My workflow 9.json | C | Deleted (test scaffold) | deleted |
| My workflow.json | C | Moved to review (generic test assistant flow) | `_Review Before Deletion/My workflow.json` |
| New Client CRM.json | A | Kept + renamed + documented | `Sales/Create - CRM Sheet - New Client Record.json` |
| Personal Assistant MCP server.json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Assist - MCP - Personal Productivity Actions.json` |
| Scrape recent news about a company before a call.json | A | Kept + renamed + documented | `Lead Generation/Research - Company News - Pre-Call Briefing Email.json` |
| TABLE.json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Serve - Google Sheets - CRM Table MCP Tools.json` |
| UICRM.json | A | Kept + renamed + documented | `Sales/Enrich - CRM UI - Sheet-Driven Lead Actions.json` |
| Update appointment Calander.json | A | Kept + renamed + documented | `Sales/Update - Google Calendar - Existing Appointment Details.json` |
| Upwork.json | A | Kept + renamed + documented | `Lead Generation/Capture - Upwork - Qualified Lead Pipeline.json` |
| baserowMCP.json | C | Moved to review (unclear purpose and inactive) | `_Review Before Deletion/baserowMCP.json` |
| call Loger.json | A | Kept + renamed + documented | `Notifications/Log - Webhook - Call Records to Google Sheets.json` |
| create a database.json | A | Kept + renamed + documented | `Data Sync/Build - YouTube Dataset - Structured Sheet Database.json` |
| enrich crm.json | A | Kept + renamed + documented | `Sales/Enrich - HubSpot - CRM Contact Intelligence.json` |
| from1to2.json | C | Moved to review (unclear objective) | `_Review Before Deletion/from1to2.json` |
| indeed.json | A | Kept + renamed + documented | `Lead Generation/Capture - Indeed - Candidate and Outreach Queue.json` |
| newlead.json | C | Moved to review (schema validation failed on tool node types) | `_Review Before Deletion/Respond - Google Sheets - New Lead Qualification Email.json` |
| saas.json | C | Moved to review (unclear endpoint contract/purpose) | `_Review Before Deletion/saas.json` |
| scraperGemini United Arab Emirates.json | C | Moved to review (duplicate pattern / unclear owner) | `_Review Before Deletion/scraperGemini United Arab Emirates.json` |
| scraperGemini.json | C | Moved to review (duplicate pattern / unclear owner) | `_Review Before Deletion/scraperGemini.json` |
| scrpite image gene.json | C | Moved to review (experimental draft) | `_Review Before Deletion/scrpite image gene.json` |
| social media.json | A | Kept + renamed + documented | `Marketing/Generate - Multi-Channel Social - Daily Content Package.json` |
| tracking due date.json | A | Kept + renamed + documented | `Admin - Utilities/Track - Notion Deadlines - Due and Overdue Alerts.json` |
| upwork Gmail.json | A | Kept + renamed + documented | `Sales/Summarize - Gmail - Upwork Message Intelligence.json` |
| upwork-->googlesheet.json | C | Moved to review (overlaps with Upwork lead capture flow) | `_Review Before Deletion/upwork-->googlesheet.json` |

## Notes
- Every kept workflow now includes a `Workflow Overview` sticky note with:
  - Purpose
  - Trigger
  - Process Summary
  - Output
  - Owner
- `_Review Before Deletion` contains all uncertain and broken candidates to avoid unsafe deletion.
