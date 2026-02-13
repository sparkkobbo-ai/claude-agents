# claude-agents

A reusable agent mesh for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Provides versioned agent definitions, slash commands, and knowledge templates that drop into any project as a git submodule.

## The Pattern

```
.claude/                    (git submodule → this repo)
  agents/                   Versioned: role definitions (the "shell")
  commands/                 Versioned: slash commands
  templates/knowledge/      Versioned: example knowledge files
  knowledge/                Gitignored: project-specific context (the "override")
  settings.json             Gitignored: Claude Code project permissions
  setup.sh                  Copies templates → knowledge/
```

Agent YAMLs define **what an agent does** (roles, boundaries, tools). Knowledge files define **what it knows** (your project's tech stack, file paths, recent work). The YAMLs are versioned and shared across projects. The knowledge is local and project-specific.

This is the `.env.example` → `.env` pattern, applied to AI agents.

---

## Installation

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- A git repository for your project
- (Optional) [Ensemble agents](https://github.com/anthropics/claude-code) in your global `~/.claude/agents/` for the project agents to delegate to

### Step 1: Add the submodule

```bash
cd your-project
git submodule add https://github.com/sparkkobbo-ai/claude-agents.git .claude
```

This clones the repo at `.claude/` — exactly where Claude Code looks for project-level agent definitions, commands, and settings.

### Step 2: Generate knowledge files from templates

```bash
.claude/setup.sh
```

This copies every file from `templates/knowledge/` into `knowledge/`. The knowledge directory is gitignored inside the submodule, so your project-specific context never leaks into the shared repo.

**Other setup.sh options:**

```bash
.claude/setup.sh --list     # Show available templates
.claude/setup.sh --force    # Overwrite existing knowledge files
```

### Step 3: Customize for your project

1. **Edit knowledge files** in `.claude/knowledge/` to describe your project (tech stack, directories, models, recent work, pitfalls)
2. **Delete irrelevant agent YAMLs** from `.claude/agents/` — a Python-only project doesn't need `pixel-client.yaml`
3. **Add project permissions** in `.claude/settings.json` if needed

### Step 4: Remove `.claude/` from your project's `.gitignore`

If your project's `.gitignore` has `.claude/` (Claude Code's default), remove that line so git can track the submodule:

```bash
# In your project's .gitignore, remove this line:
.claude/
```

### Step 5: Commit

```bash
git add .claude .gitmodules .gitignore
git commit -m "feat: add claude-agents submodule"
```

### Cloning a project with this submodule

```bash
git clone --recurse-submodules https://github.com/your-org/your-project.git

# Or if already cloned:
git submodule update --init --recursive
```

After cloning, run `setup.sh` to regenerate the gitignored knowledge files.

---

## Updating

```bash
# Pull latest agent definitions into your project
cd .claude && git pull origin main && cd ..

# Commit the submodule pointer update
git add .claude && git commit -m "chore: update claude-agents submodule"
```

Your knowledge files are untouched — they're gitignored inside the submodule.

---

## Agent Architecture

### The Three Roles

Every project mesh has three types of agents, forming a delegation hierarchy:

```
Orchestrator              ← Plans, decomposes, coordinates, manages tickets
  ├── Executor            ← Builds, tests, verifies (never writes code)
  ├── Implementor A       ← Owns domain A (reads + writes code)
  ├── Implementor B       ← Owns domain B (reads + writes code)
  └── Implementor C       ← Owns domain C (reads + writes code)
```

#### Orchestrator

The orchestrator **plans and delegates**. It drives the feature pipeline (PRD → TRD → implement → verify), decomposes work into domain-specific tasks, and coordinates cross-domain contracts. It talks to project management tools (Linear, Jira) and creates PRs.

**Key traits:**
- Has `Task` tool (can spawn sub-agents)
- Has project management MCP tools
- Does NOT have `Write` or `Edit` (never touches code directly)
- Reads `knowledge/project-overview.md` for full project context

#### Executor

The executor **verifies without modifying**. After implementors finish their work, the executor runs builds, tests, and security scans. It reports pass/fail back to the orchestrator.

**Key traits:**
- Has `Bash` and `Read` (can run commands, read output)
- Does NOT have `Write` or `Edit` (read-only)
- Reads `knowledge/build-and-test.md` for build commands and known issues

#### Implementors

Implementors **own a specific domain** and write code within it. Each implementor has deep context about its slice of the codebase and knows the patterns, pitfalls, and conventions specific to that domain.

**Key traits:**
- Has `Read`, `Write`, `Edit`, `Bash`, `Grep`, `Glob` (full code access)
- Scoped to specific directories (enforced by `boundaries` in YAML)
- Reads its own domain-specific knowledge file
- Validates TRD sections before implementing (reports back if something won't work)

---

## Designing Your Implementors

The most important decision is **how to split your codebase into domains**. Each domain gets one implementor agent + one knowledge file.

### Principles

1. **Split by concern, not by file count.** A 50-file backend and a 5-file config layer can both be domains if they have distinct patterns and pitfalls.

2. **One agent per "mental model."** If working on area A requires knowing completely different things than area B, they're separate domains.

3. **Shared code gets its own agent.** If two domains both consume a shared layer (types, interfaces, protocols), that layer needs its own implementor to prevent conflicting changes.

4. **Cross-domain boundaries are the orchestrator's job.** Implementors don't coordinate with each other directly — the orchestrator decomposes work and ensures contracts align.

### Example: Monorepo with frontend + backend + shared types

```
orchestrator
  ├── executor
  ├── frontend          → src/app/, src/components/, src/styles/
  ├── backend           → src/api/, src/services/, src/db/
  ├── shared-types      → src/types/, src/utils/, src/contracts/
  └── infra             → Dockerfile, CI/CD, deployment configs
```

### Example: Microservices

```
orchestrator
  ├── executor
  ├── auth-service      → services/auth/
  ├── billing-service   → services/billing/
  ├── gateway           → services/gateway/
  └── infra             → terraform/, k8s/, CI/CD
```

### Example: Game engine (this repo's current setup)

```
orchestrator
  ├── executor
  ├── pixel-client      → src/ts/client/ (WebGL, input, IMGUI)
  ├── pixel-server      → src/ts/server/ (world state, controllers)
  ├── pixel-common      → src/ts/common/ (entities, interfaces, encoders)
  ├── astro-site        → site/ (Astro pages, UnoCSS)
  ├── python-api        → api/ (SQLAlchemy, Alembic, CLI)
  └── infra-devops      → CI/CD, Docker, git workflows
```

### Example: Simple project (2 implementors)

Not every project needs 6 implementors. A small project might only need:

```
orchestrator
  ├── executor
  ├── app               → src/ (all application code)
  └── infra             → CI/CD, deployment
```

---

## Creating Agent YAMLs

### Format

Every agent YAML follows this structure:

```yaml
metadata:
  name: my-agent-name
  description: >-
    One-line description of what this agent does.
  version: 1.0.0
  lastUpdated: '2026-01-01'
  category: orchestrator | specialist    # orchestrator or specialist
  tools:                                 # Tools this agent can use
    - Read
    - Write
    - Edit
    - Bash
    - Grep
    - Glob

mission:
  summary: |
    Multi-line description of the agent's role. Should include:
    - What knowledge file to read on startup
    - What domain/directories it owns
    - Key patterns and pitfalls
    - Relationship to other agents (what to delegate)

  boundaries:
    handles: |
      What this agent is responsible for.
    doesNotHandle: |
      What to delegate to other agents.
    collaboratesOn: |
      Cross-agent coordination points (shared interfaces, contracts).

responsibilities:
  - priority: high
    title: Primary Responsibility
    description: What this agent does most often
  - priority: medium
    title: Secondary Responsibility
    description: Less frequent but still important

integrationProtocols:
  handoffTo:
    - agent: other-agent-name
      context: What gets handed off and when
  handoffFrom:
    - agent: other-agent-name
      context: What this agent receives and from whom
```

### Tool Selection by Role

| Role | Tools | Why |
|------|-------|-----|
| Orchestrator | Read, Task, Bash, Grep, Glob, WebFetch, WebSearch, MCP tools, TodoWrite, AskUserQuestion | Plans, delegates, coordinates — never writes code |
| Executor | Read, Bash, Grep, Glob, WebFetch | Builds, tests, reads output — never writes code |
| Implementor | Read, Write, Edit, Bash, Grep, Glob | Full code access within its domain |

### The Validation Loop

When the orchestrator delegates a TRD section to an implementor, the implementor should **validate before building**:

```
Orchestrator sends TRD section to implementor
  ↓
Implementor checks: "Can I actually build this with my domain's patterns?"
  ↓
IF valid → Implement it
IF invalid → Report back: what doesn't work + proposed alternative
  ↓
Orchestrator reconciles across all domains
  ↓
Re-delegates revised tasks
  ↓
Repeat until all implementors confirm viability
```

This prevents implementors from silently building to a spec that doesn't work, and ensures the orchestrator maintains a coherent cross-domain picture.

---

## Creating Knowledge Files

Knowledge files are the project-specific context that makes generic agents useful for YOUR codebase. They go in `knowledge/` (gitignored) and are populated from `templates/knowledge/`.

### What to include

**project-overview.md** (read by orchestrator, shared context):
- Repository URLs, org info
- All codebases with tech stacks and directories
- Completed and in-progress work (ticket IDs, PR numbers)
- Agent mesh reference (which agent handles what)
- Design philosophy, conventions, branch naming

**build-and-test.md** (read by executor):
- Prerequisites (runtime versions, databases, etc.)
- Build commands per codebase with expected timing
- Test commands and expected pass counts
- Known issues (caching bugs, native module requirements)
- CI/CD status

**Domain-specific files** (read by each implementor):
- File listings with key exports/functions
- Architecture patterns used in this domain
- Recent feature work and what it changed
- Critical pitfalls ("use X not Y", "this rate limit matters")
- Common modification patterns ("to add a new X, do A then B then C")

### Tips

- **Be specific about pitfalls.** "Use `player.hold` not `player.options.hold`" is worth more than a page of architecture overview.
- **Include recent work.** Agents need to know what changed recently to avoid conflicts.
- **List file paths.** Agents work better when they know exactly where to look.
- **Keep it concise.** Knowledge files are injected into agent context — every line costs tokens.

---

## Slash Commands

Commands go in `commands/` and are invoked as `/command-name` in Claude Code.

### Included commands

| Command | Purpose |
|---------|---------|
| `/build-all` | Run build checks across all codebases |
| `/test-all` | Run all test suites with pass/fail summary |
| `/status` | Git status + project board + recent commits + running servers |
| `/sync-linear` | Query and display Linear sprint board |

### Creating your own

Add a markdown file to `commands/`. The filename (minus `.md`) becomes the slash command name.

```markdown
# My Command Name

Description of what this command does.

## Steps

1. **Step one**
   ```bash
   command-to-run
   ```
   Report: what to look for in output

2. **Step two**
   ...

## Output Format

Describe the expected output format.

## Notes
- Any caveats or prerequisites
```

---

## Relationship to Global Ensemble Agents

If you have [Ensemble agents](https://github.com/anthropics/claude-code) in `~/.claude/agents/` (global), project agents **add context on top**, they don't replace:

| Project Agent | Delegates To (Global) | For What |
|---------------|----------------------|----------|
| Orchestrator | `tech-lead-orchestrator` | Sprint methodology, TDD |
| Orchestrator | `product-management-orchestrator` | PRD refinement |
| Frontend impl | `frontend-developer` | Generic web patterns |
| Backend impl | `backend-developer` | Generic server patterns |
| Infra impl | `infrastructure-orchestrator` | Cloud patterns |
| Any impl | `code-reviewer` | Security review |
| Executor | `test-runner` | Test execution patterns |

The project agents know your codebase. The global agents know general engineering patterns. Together they cover both.

---

## Project Structure Reference

```
claude-agents/
├── README.md                              # This file
├── setup.sh                               # Knowledge file generator
├── .gitignore                             # Ignores knowledge/, settings
│
├── agents/                                # Versioned agent definitions
│   ├── kobold-orchestrator.yaml           #   Orchestrator (plans, delegates)
│   ├── kobold-executor.yaml               #   Executor (builds, tests)
│   ├── pixel-client.yaml                  #   Implementor: game client
│   ├── pixel-server.yaml                  #   Implementor: game server
│   ├── pixel-common.yaml                  #   Implementor: shared game code
│   ├── astro-site.yaml                    #   Implementor: website
│   ├── python-api.yaml                    #   Implementor: backend API
│   └── infra-devops.yaml                  #   Implementor: infrastructure
│
├── commands/                              # Slash commands
│   ├── build-all.md
│   ├── test-all.md
│   ├── status.md
│   └── sync-linear.md
│
├── templates/knowledge/                   # Knowledge templates (versioned)
│   ├── project-overview.md
│   ├── build-and-test.md
│   ├── pixel-horse-client.md
│   ├── pixel-horse-server.md
│   ├── pixel-horse-common.md
│   ├── astro-site-context.md
│   ├── python-api-context.md
│   └── devops-context.md
│
└── knowledge/                             # Project-specific (gitignored)
    └── .gitkeep
```

## License

Personal use.
"
