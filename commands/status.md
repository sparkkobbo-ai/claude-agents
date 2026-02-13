# Project Status Dashboard

Gather and display current project status across all dimensions.

## Steps

1. **Git Status** (all repos)
   ```bash
   # Main repo
   cd kobold_community_hub && echo "=== Main Repo ===" && git branch --show-current && git status --short

   # Pixel.horse
   cd pixel.horse && echo "=== pixel.horse ===" && git branch --show-current && git status --short
   ```
   Show: current branch, modified/untracked files

2. **Recent Commits** (last 5 per repo)
   ```bash
   cd kobold_community_hub && git log --oneline -5
   cd pixel.horse && git log --oneline -5
   ```

3. **Git Worktrees**
   ```bash
   cd kobold_community_hub && git worktree list
   ```

4. **Linear Sprint Status**
   Query Linear for current sprint tickets using MCP tools:
   - Group by status: Backlog, Todo, In Progress, Done
   - Show ticket ID, title, assignee, priority

5. **Running Servers** (check ports)
   ```bash
   # Check if game server is running
   curl -s -o /dev/null -w "%{http_code}" http://localhost:8090 2>/dev/null || echo "Not running"
   # Check if Astro dev server is running
   curl -s -o /dev/null -w "%{http_code}" http://localhost:4321 2>/dev/null || echo "Not running"
   ```

## Output Format

```
=== Kobold Community Hub Status ===

Git:
  Main repo: [branch] - [clean/X modified]
  pixel.horse: [branch] - [clean/X modified]
  Worktrees: [list]

Recent Commits (main):
  [5 most recent]

Recent Commits (pixel.horse):
  [5 most recent]

Linear Sprint:
  Backlog: X tickets
  Todo: X tickets
  In Progress: X tickets
  Done: X tickets

Servers:
  Game (8090): [Running/Stopped]
  Astro (4321): [Running/Stopped]
===================================
```
