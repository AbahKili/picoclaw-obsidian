# Skill: obsidian-memory

> Read, write, and search the Obsidian vault using PicoClaw's native file tools.

## Vault Structure

```
vault/PicoClaw/
├── memory/MEMORY.md     ← Core user profile and context
├── Facts/
│   ├── Work.md          ← Work-related facts
│   ├── Personal.md      ← Personal facts
│   └── Projects.md      ← Project tracking
├── Episodes/            ← Conversation summaries (YYYY-MM-DD.md)
├── Logs/                ← Daily logs (YYYY-MM-DD.md)
└── Tasks/               ← Task notes
```

## Reading from Vault

### Load user profile
```
Read: PicoClaw/memory/MEMORY.md
Read: PicoClaw/Facts/Work.md
Read: PicoClaw/Facts/Personal.md
```

### Check recent logs
```
Read: PicoClaw/Logs/YYYY-MM-DD.md  (replace with today's date)
List directory: PicoClaw/Logs/
```

### Search vault
```
grep pattern="keyword" path=PicoClaw/ include=*.md
grep pattern="meeting" path=PicoClaw/Episodes/ include=*.md
```

## Writing to Vault

### Save a conversation summary
Write to: `PicoClaw/Episodes/YYYY-MM-DD.md`
```markdown
# Episode — YYYY-MM-DD

## Summary
Brief summary of what was discussed and decided.

## Key Decisions

## Action Items

## Notes for next session
```

### Update daily log
Read `PicoClaw/Logs/YYYY-MM-DD.md` first, then append:
```markdown
## HH:MM — Activity description
Details of what happened or was discussed.
```

### Update memory
Edit relevant section in `PicoClaw/memory/MEMORY.md` or `PicoClaw/Facts/*.md`.

### Create task note
Write to: `PicoClaw/Tasks/TASK-NAME.md`
```markdown
# Task: [Title]

- **Status:** Active / Done / Blocked
- **Created:** YYYY-MM-DD
- **Deadline:**
- **Description:**

## Notes
```

## Vault Search Patterns

| Need | Command |
|------|---------|
| Find mention of person/project | `grep pattern="name" path=PicoClaw/ include=*.md` |
| Recent conversations | List `PicoClaw/Episodes/` by date |
| Today's log | Read `PicoClaw/Logs/YYYY-MM-DD.md` |
| All tasks | List `PicoClaw/Tasks/` |
| Facts about a topic | `grep pattern="topic" path=PicoClaw/Facts/ include=*.md` |

## Best Practices

- **Always read before writing** to avoid overwriting existing content
- **Use append mode** when updating logs — read first, then add new section
- **Use clear headings** — Obsidian renders them, and grep is easier
- **Include dates in filenames** for Episodes and Logs
- **Tag tasks** with status: `#active`, `#done`, `#blocked`

## File Paths

All vault paths are relative to the PicoClaw workspace root. Use the exact filename including date.
