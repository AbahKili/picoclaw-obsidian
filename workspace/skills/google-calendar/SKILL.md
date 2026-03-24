# Skill: google-calendar

> Manage Google Calendar events via `gws` CLI.

## Prerequisites

Complete `google-workspace` skill setup first (`gws auth login`).

## List Events

```bash
gws calendar events list \
  --calendar_id primary \
  --time_min "YYYY-MM-DDT00:00:00Z" \
  --time_max "YYYY-MM-DDT23:59:59Z" \
  --limit 20
```

**PicoClaw usage**: Parse output, summarize in Indonesian/English, append to today's log.

## Today's Agenda

Run this at session start per HEARTBEAT.md:

```bash
gws calendar events list \
  --calendar_id primary \
  --time_min "YYYY-MM-DDT00:00:00+07:00" \
  --time_max "YYYY-MM-DDT23:59:59+07:00"
```

## Create Event

```bash
gws calendar events create \
  --summary "Meeting Title" \
  --description "Meeting description" \
  --location "Jakarta" \
  --start "YYYY-MM-DDTHH:MM:00+07:00" \
  --end "YYYY-MM-DDTHH:MM:00+07:00" \
  --calendar_id primary
```

## Create Event with Google Meet

```bash
gws calendar events create \
  --summary "Video Call" \
  --description "Meeting description" \
  --start "YYYY-MM-DDTHH:MM:00+07:00" \
  --end "YYYY-MM-DDTHH:MM:00+07:00" \
  --conference_data_version 1 \
  --calendar_id primary
```

The Meet link will be in the response under `conferenceData.entryPoints`.

## Delete Event

```bash
gws calendar events delete \
  --event_id "EVENT_ID" \
  --calendar_id primary
```

## Meeting Prep

Before a meeting, PicoClaw should:
1. Read relevant context from `PicoClaw/Episodes/` or `PicoClaw/Facts/`
2. Read recent related logs
3. Prepare a brief summary to share at the start

After a meeting:
1. Write episode note to `PicoClaw/Episodes/YYYY-MM-DD-EVENT.md`
2. Update project notes if decisions were made
3. Log key action items

## Log Format

When logging a calendar event to `PicoClaw/Logs/YYYY-MM-DD.md`:

```markdown
## Calendar — HH:MM
- **[Event Title]**
- Time: HH:MM - HH:MM (WIB)
- Location: [location or Meet link]
- Notes: [brief context]
```
