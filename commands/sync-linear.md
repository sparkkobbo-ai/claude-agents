# Sync Linear Board

Query the Kobold Kavern Linear workspace and display the current sprint board.

## Steps

1. **Query Linear Issues**
   Use the Linear MCP tools to fetch all issues from the Kobold Kavern team.
   Group by workflow state.

2. **Display Sprint Board**
   Organize tickets into columns by status:
   - **Backlog**: Not yet scheduled
   - **Todo**: Scheduled for current sprint
   - **In Progress**: Currently being worked on
   - **In Review**: Awaiting review
   - **Done**: Completed

3. **Show Ticket Details**
   For each ticket, display:
   - Ticket ID (e.g., KOB-91)
   - Title
   - Priority (Urgent, High, Medium, Low, None)
   - Assignee (if any)
   - Labels (if any)

## Output Format

```
=== Kobold Kavern Sprint Board ===

BACKLOG (X)
  KOB-XX: [Title] [Priority] [Labels]
  ...

TODO (X)
  KOB-XX: [Title] [Priority] [Labels]
  ...

IN PROGRESS (X)
  KOB-XX: [Title] [Priority] [Labels]
  ...

IN REVIEW (X)
  KOB-XX: [Title] [Priority] [Labels]
  ...

DONE (X)
  KOB-XX: [Title] [Priority] [Labels]
  ...

==================================
Total: X tickets (Y in progress, Z done)
```

## Notes
- Uses Linear MCP integration (mcp__linear__* tools)
- Workspace: Kobold Kavern (https://linear.app/kobold-kavern)
- If Linear MCP is unavailable, report the error and suggest checking MCP configuration
