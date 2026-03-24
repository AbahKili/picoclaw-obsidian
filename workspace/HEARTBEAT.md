# HEARTBEAT.md — Periodic Tasks

> PicoClaw checks this file periodically. Tasks here run on schedule.

## Daily (once per session)

- [ ] Check Google Calendar for today's events → append to `PicoClaw/Logs/YYYY-MM-DD.md`
- [ ] Review `PicoClaw/Tasks/` for pending items
- [ ] If significant new info learned → update `PicoClaw/memory/MEMORY.md`
- [ ] Summarize today's conversation if any → write to `PicoClaw/Episodes/YYYY-MM-DD.md`

## Weekly (every Monday)

- [ ] Review `PicoClaw/Logs/` for past week summary
- [ ] Check `PicoClaw/Tasks/` — archive completed, update stalled
- [ ] Review `PicoClaw/Facts/` for outdated info

## On Calendar Events

When a meeting ends:
- [ ] Log key decisions → `PicoClaw/Episodes/YYYY-MM-DD-EVENT.md`
- [ ] Update project notes if relevant → `PicoClaw/Facts/Projects.md`

## On Task Completion

- [ ] Move task from `PicoClaw/Tasks/` to completed section
- [ ] Log completion in daily log

## Commands

Use Google Calendar skill to list events:
```bash
gws calendar events list --calendar_id primary --time_min "YYYY-MM-DDT00:00:00Z" --time_max "YYYY-MM-DDT23:59:59Z"
```
