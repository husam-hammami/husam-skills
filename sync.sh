#!/usr/bin/env bash
# Refresh the per-agent mirrors from the canonical skills/ + agents/ directories.
set -e
cd "$(dirname "$0")"
for m in .claude .agents .cursor; do
  rm -rf "$m/skills" "$m/agents"; mkdir -p "$m/skills" "$m/agents"
  cp -r skills/* "$m/skills/"
  cp agents/*.md "$m/agents/"
done
echo "Mirrors synced from skills/ + agents/"
