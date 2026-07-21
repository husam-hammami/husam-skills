#!/usr/bin/env bash
# Install these skills into Claude Code (~/.claude/skills).
set -e
cd "$(dirname "$0")"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$DEST"
for s in skills/*/; do
  n=$(basename "$s")
  rm -rf "$DEST/$n"; cp -r "$s" "$DEST/$n"
  echo "  installed $n"
done
echo "Done -> $DEST"
