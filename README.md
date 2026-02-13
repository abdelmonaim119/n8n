# n8n

This repository stores n8n workflows as JSON for source control and controlled promotion between environments.

## Recommended Push/Pull Model
- Use one-way flow to avoid conflicts: `dev instance -> Git -> prod instance`.
- Avoid editing and pushing from the same production instance.
- Push workflow changes immediately after completing a task.
- Pull in production from Git after review.

## n8n Source Control Notes
- Push includes workflows, folders, tags, projects, and variable/credential stubs.
- Pull can override local workflow changes if you confirm override.
- Deleted items in Git are not auto-deleted locally; n8n prompts for cleanup.
- Pulling published workflows may briefly unpublish/republish them.

## Current Structure
Workflows are organized under:
- `workflows/local_5679_kali_a/Lead Generation`
- `workflows/local_5679_kali_a/Sales`
- `workflows/local_5679_kali_a/Marketing`
- `workflows/local_5679_kali_a/Data Sync`
- `workflows/local_5679_kali_a/Notifications`
- `workflows/local_5679_kali_a/Admin - Utilities`
- `workflows/local_5679_kali_a/Experiments`
- `workflows/local_5679_kali_a/_Review Before Deletion`

## Initial Setup Commands
```bash
git init -b main
git add .
git commit -m "Initialize n8n workflow repository"
```

## Connect Remote Repository Named `n8n`
```bash
git remote add origin <your-repo-url>
git push -u origin main
```
