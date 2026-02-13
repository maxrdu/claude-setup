# Kaizen - Session Improvement Analyzer

## Trigger

Activated by `/kaizen` or "review this session for improvements".

## Behavior

Analyzes the current Claude Code session to identify inefficiencies, documentation gaps, contradictions, and opportunities for automation.

### Analysis Categories

1. **Tool misuse** - File or search operations done via Bash instead of dedicated tools
2. **Missing documentation** - Undiscovered patterns, APIs, or configurations that would have helped
3. **Instruction contradictions** - Conflicting rules across config files (CLAUDE.md, skills, etc.)
4. **Inefficiency patterns** - Repeated failures, rework cycles, unnecessary round-trips
5. **Skill gaps** - Repetitive workflows that could be captured as new skills or commands

### Output Format

Present findings organized by category:

```
## Findings

### [Category]
**Issue:** Description of what happened
**Impact:** How it affected the session
**Recommendation:** Specific actionable fix
**Proposed change:** File path and content to add/modify
```

### Workflow

1. Review the full session transcript
2. Identify issues across all five categories
3. Prioritize by impact (high/medium/low)
4. Present findings with specific, actionable recommendations
5. Offer to implement approved changes (update CLAUDE.md, create new skills, etc.)

### Analysis Checklist

- [ ] Were the right tools used for each operation?
- [ ] Were independent operations parallelized?
- [ ] Were there unnecessary retries or failures?
- [ ] Is documentation complete for discovered patterns?
- [ ] Are there contradictions between instruction sources?
- [ ] Could any repeated workflow become a skill or command?
- [ ] Were file reads done before edits?
- [ ] Were searches scoped appropriately?
- [ ] Were commits atomic and well-messaged?
- [ ] Was the todo list used effectively for planning?
