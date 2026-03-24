# PicoClaw Memory Vault

This is the PicoClaw workspace — your long-term memory layer powered by Obsidian.

## Structure

```
PicoClaw/
├── memory/       ← Core persistent memory (MEMORY.md)
├── Facts/        ← Structured facts about you
├── Episodes/     ← Conversation summaries
├── Logs/         ← Daily / periodic logs
└── Tasks/        ← Task and project notes
```

## How PicoClaw Uses This

PicoClaw reads and writes markdown files here using its skills:
- **obsidian-memory** skill — read/write/search vault notes
- **google-calendar** skill — log meetings, sync events
- **google-sheets** skill — append to tracking sheets

## For You

Everything here is a native Obsidian note. You can:
- Open it in Obsidian desktop/mobile
- Add tags, links, and embeds
- Browse and edit manually
- Let PicoClaw build your second brain automatically

## Tip

Put this vault path in `setup.sh` when deploying PicoClaw on a new machine.
