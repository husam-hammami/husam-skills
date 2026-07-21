#!/usr/bin/env bash
# Install these skills AND their subagent definitions into Claude Code.
# The agents/ half is not optional: bulletproof spawns plan-reviewer, and warcry
# spawns warcry-scout / warcry-judge / warcry-premortem. Without them those skills break.
set -e
cd "$(dirname "$0")"
SKILLS="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
AGENTS="${CLAUDE_AGENTS_DIR:-$HOME/.claude/agents}"
mkdir -p "$SKILLS" "$AGENTS"
for s in skills/*/; do
  n=$(basename "$s")
  rm -rf "$SKILLS/$n"; cp -r "$s" "$SKILLS/$n"
  echo "  skill  $n"
done
for a in agents/*.md; do
  cp "$a" "$AGENTS/"
  echo "  agent  $(basename "$a" .md)"
done
echo "Skills -> $SKILLS"
echo "Agents -> $AGENTS"
