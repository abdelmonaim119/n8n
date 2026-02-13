# Workflow Build Rules (Required)

This file is a mandatory pre-flight input. It defines global rules that must be followed before generating or editing any n8n workflow JSON in this repo.

## Global Safety
- No secrets in Git. Use environment variables or n8n credentials.
- Do not activate workflows by default unless explicitly requested.
- If a workflow deletion is uncertain, move to `_Review Before Deletion` instead of deleting.

## Naming
- Workflow name format: `[Action] - [System/Platform] - [Outcome]` (concise, professional).
- Node names must be descriptive (no `Node1`, `Test`, `Copy`).

## Documentation (Mandatory)
Every kept workflow must include a top sticky note:

Purpose:
Trigger:
Process Summary:
Output:
Owner:

## Reliability Defaults
- Idempotency: prefer explicit idempotency key when applicable.
- Retries: prefer exponential backoff for external APIs.
- Failure handling: log to Errors sheet/table and (optionally) notify admin channel.

## Layout
- Left-to-right flow.
- Notes on key transformations and business rules.

## Your Custom Rules
Replace or extend the above rules with your own. This file must be non-empty.

