# Skill: google-meet

> Create Google Meet video conference links via Calendar events.

## How It Works

Google Meet links are generated automatically when you create a Calendar event with video conference data enabled. There is no separate Meet API — it's powered by Google Calendar.

## Create a Meet Link

Use the `google-calendar` skill's `gws calendar events create` command with `--conference_data_version 1`:

```bash
gws calendar events create \
  --summary "Video Meeting" \
  --description "Meeting description or agenda" \
  --start "YYYY-MM-DDTHH:MM:00+07:00" \
  --end "YYYY-MM-DDTHH:MM:00+07:00" \
  --conference_data_version 1 \
  --calendar_id primary
```

The Meet link will be in the response under `conferenceData.entryPoints[].uri`.

## Join a Meet

Meet links look like: `https://meet.google.com/xxx-xxxx-xxx`

PicoClaw should:
1. Present the link clearly to the user
2. Optionally add it to the relevant log or episode note

## Schedule Recurring Meet

```bash
gws calendar events create \
  --summary "Weekly Standup" \
  --start "YYYY-MM-DDTHH:MM:00+07:00" \
  --end "YYYY-MM-DDTHH:MM:00+07:00" \
  --recurrence "RRULE:FREQ=WEEKLY;COUNT=12" \
  --conference_data_version 1 \
  --calendar_id primary
```

## Meeting Prep Workflow

Before a Meet:
1. Use `google-calendar` skill to get event details
2. Read relevant context from vault (`PicoClaw/Episodes/`, `PicoClaw/Facts/`)
3. Prepare agenda and talking points

After a Meet:
1. Log the meeting in `PicoClaw/Logs/YYYY-MM-DD.md`
2. Write episode summary in `PicoClaw/Episodes/`
3. Update `PicoClaw/Tasks/` with any new action items

## Log Meet Info

```markdown
## Meet — [Event Title]
- Date: YYYY-MM-DD HH:MM WIB
- Link: https://meet.google.com/xxx-xxxx-xxx
- Attendees: [if known]
- Summary: [after meeting]
- Action items: [after meeting]
```
