# Refresh Knowledge Files

Update knowledge files based on recent work, exploration results, or codebase changes. This ensures the agent mesh stays current across sessions.

## When to Run

- After completing a feature implementation
- After a `/explore` run reveals outdated information
- After major refactors or architectural changes
- Periodically during long sessions (every ~30 minutes of active work)

## Instructions

For each domain that had recent changes, launch a parallel agent to update its knowledge file. Each agent should:

1. **Read the current knowledge file** to understand what's already documented
2. **Explore the domain directory** for current state (file counts, new files, removed files)
3. **Check recent git history** for changes since the knowledge file was last updated
4. **Update the knowledge file** with:
   - New files, functions, or systems discovered
   - Status changes (features completed, deprecated, or in-progress)
   - New pitfalls or patterns confirmed
   - Corrected information (outdated counts, wrong descriptions)
   - Removed entries for deleted files or deprecated systems
5. **Keep it concise** — replace outdated info, don't endlessly append. Knowledge files should stay under 200 lines.

## Agent Prompts

### For each implementor domain:
```
Read .claude/knowledge/<domain>.md to understand current state.
Explore <domain-directory>/ for actual current state.
Run git log --oneline -20 -- <domain-directory>/ to see recent changes.

Compare the knowledge file against reality. Update the knowledge file using Edit tool:
- Fix any outdated file counts, line counts, or descriptions
- Add new files, features, or systems not yet documented
- Remove entries for deleted or renamed files
- Update "Completed" and "In Progress" sections
- Add any new pitfalls discovered during this session
- Update the lastUpdated date at the top

IMPORTANT: Keep the file under 200 lines. Replace stale content rather than appending.
IMPORTANT: Use Windows backslash paths for all file operations.
```

### Knowledge file ↔ Domain mapping:
| Knowledge File | Domain Directory | Agent Type |
|----------------|-----------------|------------|
| `pixel-horse-client.md` | `pixel.horse/src/ts/client/` | Explore or backend-developer |
| `pixel-horse-server.md` | `pixel.horse/src/ts/server/` | Explore or backend-developer |
| `pixel-horse-common.md` | `pixel.horse/src/ts/common/` | Explore or backend-developer |
| `astro-site-context.md` | `site/` | Explore or frontend-developer |
| `python-api-context.md` | `api/` | Explore or backend-developer |
| `devops-context.md` | Root (CI/CD, git, docker) | Explore or infrastructure-developer |
| `project-overview.md` | All (cross-domain summary) | Explore |
| `build-and-test.md` | All (build commands) | Explore |

## Selective Refresh

If only specific domains changed, refresh only those. Examples:

- After pixel.horse work: refresh `pixel-horse-client.md`, `pixel-horse-server.md`, `pixel-horse-common.md`
- After site work: refresh `astro-site-context.md`
- After API work: refresh `python-api-context.md`
- After infra changes: refresh `devops-context.md`
- Always refresh `project-overview.md` if Linear tickets changed status

## Output

After all updates complete, summarize what changed:

```
=== Knowledge Refresh Summary ===
Updated: pixel-horse-client.md (added IMGUI section, updated line counts)
Updated: project-overview.md (marked KOB-91 complete)
Skipped: python-api-context.md (no changes detected)
Skipped: devops-context.md (no changes detected)
===
```
