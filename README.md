# claude-setup

Custom skills, commands, and agents for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Managed via symlinks so your personal configurations coexist cleanly with third-party additions.

## Quick Start

```bash
git clone <this-repo> ~/claude-setup
cd ~/claude-setup
make install
```

This creates individual symlinks in `~/.claude/` for each skill, command, agent, etc. Third-party items installed directly into `~/.claude/` are left untouched.

## Repository Structure

```
claude-setup/
├── Makefile          # Symlink-based install/uninstall/status
├── CLAUDE.md         # Root Claude Code project configuration
├── skills/           # Specialized capability packages
│   └── <name>/
│       ├── SKILL.md  # Skill definition
│       ├── references/  # Supporting docs (optional)
│       └── scripts/     # Helper scripts (optional)
├── commands/         # Slash command shortcuts (/command-name)
│   └── <name>/
│       └── COMMAND.md
├── agents/           # Specialized agent configurations
│   └── <name>/
│       └── AGENT.md
├── docs/             # Reference documentation
├── scripts/          # Standalone utility scripts
└── output-styles/    # Output formatting configurations
```

## Commands

| Command | Description |
|---------|-------------|
| `make install` | Create symlinks in `~/.claude/` |
| `make uninstall` | Remove only symlinks managed by this repo |
| `make status` | Show managed vs. third-party items |
| `make clean` | Alias for uninstall |
| `make help` | Show available targets |

## How It Works

Unlike replacing entire directories, this approach creates **individual symlinks** for each skill, agent, command, etc. inside `~/.claude/`:

```
~/.claude/skills/
  my-skill -> /home/you/claude-setup/skills/my-skill     # managed
  some-other-skill/                                        # third-party (untouched)
```

- `make install` links new items, skips existing symlinks, warns about conflicts
- `make uninstall` removes only symlinks pointing back to this repo
- `make status` shows which items are managed vs. third-party

## Creating a New Skill

1. Create a directory under `skills/`:
   ```bash
   mkdir -p skills/my-skill
   ```

2. Add a `SKILL.md` file defining the skill's behavior:
   ```markdown
   # My Skill

   ## Trigger
   Activated by `/my-skill` or "use my-skill"

   ## Behavior
   Description of what this skill does...
   ```

3. Optionally add `references/` and `scripts/` subdirectories for supporting materials.

4. Run `make install` to symlink it into `~/.claude/skills/`.

## Creating a New Command

1. Create a directory under `commands/`:
   ```bash
   mkdir -p commands/my-command
   ```

2. Add a `COMMAND.md`:
   ```markdown
   # /my-command

   Description of what the slash command does...
   ```

3. Run `make install`.

## Creating a New Agent

1. Create a directory under `agents/`:
   ```bash
   mkdir -p agents/my-agent
   ```

2. Add an `AGENT.md`:
   ```markdown
   # My Agent

   Specialized agent configuration...
   ```

3. Run `make install`.

## Uninstalling

```bash
make uninstall
```

This only removes symlinks that point back to this repository. Any third-party skills, commands, or agents you've added directly into `~/.claude/` are preserved.
