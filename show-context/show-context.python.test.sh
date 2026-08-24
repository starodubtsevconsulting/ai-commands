#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

python3 "$SCRIPT_DIR/show-context.py" \
  --file "$SCRIPT_DIR/show-context.report.template.md" \
  --output "$TMP_DIR/report.html" \
  --title "Portable context" \
  --request "What should the human understand?" \
  --no-open >/dev/null

grep -q '<title>Portable context</title>' "$TMP_DIR/report.html"
grep -q 'What should the human understand?' "$TMP_DIR/report.html"
grep -q 'class="mermaid"' "$TMP_DIR/report.html"
grep -q 'Focused evidence only' "$TMP_DIR/report.html"
grep -q 'securityLevel:"strict"' "$TMP_DIR/report.html"

echo 'portable show-context Python tests passed'
