# /summarize

Condense content into a concise summary.

## Usage

```
/summarize            # Summarize the current conversation
/summarize <url>      # Summarize content from a URL
/summarize <file>     # Summarize a file's contents
```

## Behavior

1. Identify the source content (conversation, URL, or file)
2. Extract key points, decisions, and action items
3. Present a structured summary:

```
## Summary
Brief 1-2 sentence overview.

## Key Points
- Point 1
- Point 2

## Decisions Made
- Decision 1

## Action Items
- [ ] Action 1
- [ ] Action 2
```

## Guidelines

- Keep summaries under 200 words unless the source is very long
- Preserve technical accuracy - don't oversimplify code decisions
- Highlight unresolved questions or open items
- For conversations, focus on what was accomplished and what remains
