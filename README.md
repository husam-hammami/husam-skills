# husam-skills

Eight agent skills: a design → plan → review → build → audit → polish pipeline.

`design_concept` · `design-with-product-dna` · `warcry` · `bulletproof` · `katana` · `eagleye` · `design_copy` · `grill-with-docs`

See [AGENTS.md](AGENTS.md) for what each one does and when it fires.

## Layout

```
skills/            canonical source — edit here
.claude/skills/    mirror, auto-loaded by Claude Code
.agents/skills/    mirror, read by agents following the .agents convention
.cursor/skills/    mirror, read by Cursor
AGENTS.md          index — how Antigravity and other AGENTS.md readers load these
```

The three mirrors are copies of `skills/`. After editing `skills/`, run `./sync.sh` to refresh them.

## Install

### Antigravity

Antigravity has **no native skills directory** — it loads instructions from `AGENTS.md` at the
workspace root and from `~/.gemini/GEMINI.md` globally. Two ways in:

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

Caveat worth knowing up front: this is instruction-level loading, not a plugin API. Antigravity
reads the index every turn and opens a `SKILL.md` when a trigger matches — reliable, but it
depends on the model honoring the index rather than on a hard dispatch mechanism.

### Claude Code

```powershell
.\install.ps1            # copies skills/ into ~/.claude/skills
```

```bash
./install.sh             # same, POSIX
```

Then `/warcry`, `/bulletproof`, `/katana`, `/design_concept`, `/eagleye` are available as slash commands.

### Cursor

Copy `.cursor/skills/` into your project's `.cursor/` directory.

## Distribute

`husam-skills.zip` at the repo root is a complete, self-contained copy — hand it to anyone,
or publish this folder as a git repo and install with:

```bash
git clone <url> && cd husam-skills && ./install.sh
```
