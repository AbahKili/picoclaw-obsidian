# Skill: google-sheets

> Read, append, and create Google Sheets via `gws` CLI.

## Prerequisites

Complete `google-workspace` skill setup first (`gws auth login`).

## List Spreadsheets

```bash
gws sheets list --limit 20
```

Returns spreadsheet names and IDs. Use the ID for further operations.

## Read a Sheet

```bash
gws sheets read \
  --spreadsheet_id "SPREADSHEET_ID" \
  --range "Sheet1!A1:Z100"
```

Or read a specific sheet by name:
```bash
gws sheets read \
  --spreadsheet_id "SPREADSHEET_ID" \
  --sheet "Sheet1" \
  --limit_rows 100
```

## Append a Row

```bash
gws sheets append \
  --spreadsheet_id "SPREADSHEET_ID" \
  --range "Sheet1!A:A" \
  --values '[["2026-03-25","Task 1","Done"]]'
```

For multiple columns:
```bash
gws sheets append \
  --spreadsheet_id "SPREADSHEET_ID" \
  --range "Sheet1!A:C" \
  --values '[["2026-03-25","Task 1","In Progress","Notes here"]]'
```

## Create a New Spreadsheet

```bash
gws sheets create \
  --title "Project Tracker" \
  --sheet "Tasks"
```

Returns the new spreadsheet ID.

## Use Cases

| Scenario | Command |
|---------|---------|
| Log daily activity | Append row with date, activity, status |
| Track project tasks | Append/update task rows |
| Meeting notes | Create new sheet per meeting |
| KPI tracking | Read + append metrics |

## Logging to Sheets

When the user wants vault data synced to a sheet:

1. Find or create the target spreadsheet
2. Read existing data to understand structure
3. Append new rows with relevant data

## Error Handling

| Error | Fix |
|-------|-----|
| `spreadsheet not found` | Check the spreadsheet ID is correct |
| `range out of bounds` | Adjust range to match sheet dimensions |
| `authentication error` | Run `gws auth login` |

## Notes

- gws uses A1 notation for ranges
- Dates in Indonesia: use `DD/MM/YYYY` format unless sheet specifies otherwise
- Always read the sheet first to understand its structure before writing
