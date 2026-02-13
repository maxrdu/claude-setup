# Project Configuration

This is a Claude Code skills repository. It contains custom skills, commands, agents, and documentation that extend Claude Code's capabilities.

## Repository Layout

- `skills/` - Each subdirectory is a skill with a `SKILL.md` defining its behavior
- `commands/` - Each subdirectory is a slash command with a `COMMAND.md`
- `agents/` - Each subdirectory is a specialized agent with an `AGENT.md`
- `docs/` - Reference documentation available to all skills
- `scripts/` - Standalone utility scripts
- `output-styles/` - Output formatting configurations

## Conventions

- When creating a new skill, always include a `SKILL.md` that defines the trigger, behavior, and output format
- When creating a new command, always include a `COMMAND.md` that defines what the slash command does
- When creating a new agent, always include an `AGENT.md` that defines the agent's specialization
- Keep skills focused on a single responsibility
- Use `references/` subdirectories for supporting documentation within a skill
- Use `scripts/` subdirectories for helper scripts within a skill
