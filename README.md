# husam-skills

Fourteen agent skills: a design → plan → review → build → audit → polish pipeline (plus `/strike` fast-track & production sentinels).

`strike` · `design_concept` · `design-with-product-dna` · `warcry` · `bulletproof` · `katana` · `eagleye` · `design_copy` · `grill-with-docs` · `root_cause_tracing` · `security_audit` · `db_sentinel` · `browser_qa` · `memory_sentinel`

See [AGENTS.md](AGENTS.md) for what each one does and when it fires.

## Layout

```
skills/            canonical source — edit here
agents/            subagent definitions — REQUIRED, not optional (see below)
.claude/skills/    mirror, auto-loaded by Claude Code
.agents/skills/    mirror, read by agents following the .agents convention
.cursor/skills/    mirror, read by Cursor
AGENTS.md          index — how Antigravity and other AGENTS.md readers load these
```

The three mirrors are copies of `skills/`. After editing `skills/`, run `./sync.sh` to refresh them.

## agents/ — required

`bulletproof` spawns `plan-reviewer`. `warcry` spawns `warcry-scout`, `warcry-judge`, and
`warcry-premortem`. These live in `~/.claude/agents/`, not in the skill folders, and the skills fail at
spawn time without them. Both installers copy them.

They are also where **model tier** is set, because frontmatter binds and prose does not:

| Agent | Model | Why |
|---|---|---|
| `warcry-scout` | `sonnet` | Retrieval and enumeration — errors show up as visibly thin briefs |
| `warcry-judge` | `sonnet` | Scores against criteria that are already written down |
| `warcry-premortem` | *unpinned* → session model | Adversarial generation; degrades into plausible slop on a cheaper tier |
| `plan-reviewer` | `opus` | The approval gate |

Unpinned subagents inherit the session model. `katana`'s body agents are deliberately left unpinned —
they write code that gets merged, and a cheap coder costs the savings back in the verify-and-fix loop.

## Invocation is manual — this is the cost gate

Every skill here is EXPLICIT-INVOCATION ONLY, enforced in each `description` with frontmatter gates. Nothing here fires because a
request merely resembles what it does. `warcry` and `katana` spawn parallel fleets and cost real money
per run — they wait to be asked. For quick single-agent execution, use `/strike`.

## Install

### Antigravity

Antigravity loads instructions from `AGENTS.md` at the workspace root and from `~/.gemini/GEMINI.md` globally. Two ways in:

**Per workspace** — copy `AGENTS.md` and `skills/` into the project root. Antigravity reads
`AGENTS.md` on every request; the table tells it which `SKILL.md` to open for a given trigger.

```bash
cp -r AGENTS.md skills/ /path/to/your/project/
```

**Globally, for every workspace** — append the index to your Gemini rules and keep the skills
at a fixed absolute path:

```bash
cp -r skills ~/.gemini/skills
{ echo; cat AGENTS.md | sed 's|skills/<name>/SKILL.md|~/.gemini/skills/<name>/SKILL.md|'; } >> ~/.gemini/GEMINI.md
```

### Claude Code

```powershell
.\install.ps1            # copies skills/ into ~/.claude/skills
```

```bash
./install.sh             # same, POSIX
```

Then `/strike`, `/warcry`, `/bulletproof`, `/katana`, `/design_concept`, `/eagleye`, `/memory_sentinel` are available as slash commands.

### Cursor

Copy `.cursor/skills/` into your project's `.cursor/` directory.

## Distribute

`husam-skills.zip` at the repo root is a complete, self-contained copy — hand it to anyone,
or publish this folder as a git repo and install with:

```bash
git clone <url> && cd husam-skills && ./install.sh
```
