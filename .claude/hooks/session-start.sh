#!/bin/bash
set -euo pipefail

# Only run in Claude Code remote (web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}/.claude/scripts"

# Install TypeScript and Node types for typecheck (tsc --noEmit).
# Runtime scripts use zero npm dependencies — they run via
# node --experimental-strip-types. npm install (not ci) is used
# so the container cache is reused across sessions.
if [ ! -d "node_modules/typescript" ]; then
  npm install --no-save typescript @types/node 2>/dev/null
fi
