#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RULES_FILE="$ROOT_DIR/env/rules.md"
INSTR_FILE="$ROOT_DIR/env/instructions.json"

die() {
  echo "preflight: ERROR: $*" >&2
  exit 1
}

warn() {
  echo "preflight: WARN: $*" >&2
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

need_cmd jq

[[ -f "$RULES_FILE" ]] || die "Missing $RULES_FILE"
[[ -s "$RULES_FILE" ]] || die "$RULES_FILE is empty"

[[ -f "$INSTR_FILE" ]] || die "Missing $INSTR_FILE"

# Validate JSON parse
jq -e . >/dev/null <"$INSTR_FILE" || die "$INSTR_FILE is not valid JSON"

# Required keys (baseline)
req() {
  local path="$1"
  jq -e "$path | (type == \"string\") and (length > 0)" >/dev/null <"$INSTR_FILE" \
    || die "Missing or empty required field: $path"
}

req '.n8n.host'
req '.n8n.projectId'
req '.n8n.timezone'
req '.n8n.version'
req '.defaults.googleSheets.spreadsheetId'

# Optional but recommended: credential IDs and targets
opt_req() {
  local path="$1"
  if ! jq -e "$path | (type == \"string\") and (length > 0)" >/dev/null <"$INSTR_FILE"; then
    warn "Recommended field not set yet: $path"
  fi
}

opt_req '.credentials.googleSheetsOAuth2Api.id'
opt_req '.credentials.telegramApi.id'
opt_req '.credentials.openAiApi.id'
opt_req '.defaults.telegram.salesChatId'
opt_req '.defaults.telegram.adminChatId'
opt_req '.defaults.callApi.baseUrl'

echo "preflight: OK"

