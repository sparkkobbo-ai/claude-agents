# Explore Project State

Perform a comprehensive exploration of the entire project. Launch parallel agents to analyze each domain and report back a unified picture of the current state.

## Instructions

Launch the following exploration agents **in parallel** using the Task tool. Each agent should read the relevant knowledge file first, then explore its domain and report findings.

Customize the agent list below based on your project's implementors. Each section maps to one implementor agent.

### Per-Domain Explorer Template
```
Read .claude/knowledge/<domain-context>.md for context.
Explore <domain-directory>/ and report:
- Current feature state (what's implemented, what's in progress)
- Key files and their approximate sizes
- Recent changes (git log for domain files)
- Any TODO/FIXME/HACK comments
- Domain-specific system status
```

## After All Agents Complete

Synthesize all agent reports into a unified summary:

```
=== Project Name - Full System Exploration ===

## Domain 1
[Summary from agent 1]

## Domain 2
[Summary from agent 2]

...

## Cross-Domain Observations
- Shared interfaces or contracts between domains
- Integration points that need attention
- Potential conflicts or inconsistencies

## Suggested Next Steps
- Features ready to implement
- Technical debt to address
- Blockers or dependencies to resolve
===
```
