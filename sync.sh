#!/usr/bin/env bash
# Refresh the per-agent mirrors from the canonical skills/ directory.
set -e
cd "$(dirname "$0")"
for m in .claude/skills .agents/skills .cursor/skills; do
  rm -rf "$m"; mkdir -p "$m"; cp -r skills/* "$m/"
done
echo "Mirrors synced from skills/"
