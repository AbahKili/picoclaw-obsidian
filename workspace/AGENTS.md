# AGENTS.md — PicoClaw × Obsidian Memory Protocol

> This file is loaded by PicoClaw on startup. It defines how the agent uses the Obsidian vault for long-term memory.

## Startup Behavior

1. Read `PicoClaw/memory/MEMORY.md` — load user profile, context, preferences
2. Read `PicoClaw/Facts/Work.md` and `PicoClaw/Facts/Personal.md` — structured facts
3. Check `PicoClaw/Logs/` for recent daily logs — continuity
4. Read `HEARTBEAT.md` in workspace — periodic task reminders

## After Every Conversation

1. **Summary**: If conversation was substantive, write to `PicoClaw/Episodes/YYYY-MM-DD.md`
2. **Update memory**: If new facts about the user were learned, update `memory/MEMORY.md`
3. **Log**: If a significant action was taken, append to `PicoClaw/Logs/YYYY-MM-DD.md`
4. **Tasks**: If a new task was created, write to `PicoClaw/Tasks/` with status tracking

## Memory Query Protocol

Before answering a question that needs user context, check:
1. `memory/MEMORY.md` for general facts
2. `Facts/*.md` for structured knowledge
3. `Episodes/` for conversation history
4. `Logs/` for activity logs

Use `grep` or read tools across `.md` files. Be thorough.

## Vault Path

The workspace is the `PicoClaw/` subfolder of the Obsidian vault. Every file written here is a native Obsidian note.

## Skills

See `skills/obsidian-memory/SKILL.md` for vault read/write/search patterns.
