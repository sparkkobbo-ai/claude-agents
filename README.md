# claude-agents

Reusable Claude Code agent mesh. Versioned agent definitions, slash commands, and knowledge templates.

## Architecture

```
claude-agents/          (add as submodule at .claude/)
  agents/               Versioned: agent role definitions (the "shell")
  commands/             Versioned: slash commands
  templates/
    knowledge/          Versioned: example knowledge files (the "template")
  knowledge/            Gitignored: project-specific context (the "override")
  settings.json         Gitignored: project permissions
  settings.local.json   Gitignored: local settings
  setup.sh              Copies templates -> knowledge/ for customization
```

**The pattern:** Agent YAMLs define roles, boundaries, and tools (versioned). Knowledge files inject project-specific context (local, gitignored). Like `.env.example` -> `.env`.

## Quick Start

### 1. Add to your project as a submodule

```bash
# From your project root
git submodule add https://github.com/sparkkobbo-ai/claude-agents.git .claude
```

### 2. Run setup to populate knowledge files

```bash
.claude/setup.sh
```

This copies `templates/knowledge/*.md` -> `knowledge/*.md`.

### 3. Customize knowledge files

Edit `knowledge/*.md` to match your project:
- `project-overview.md` - repos, tech stack, current status
- `build-and-test.md` - build commands, test suites, prerequisites
- Domain-specific files for your implementor agents

### 4. Remove irrelevant agents

Not every project needs every agent. Delete or ignore agents that don't apply.
For example, a Python-only project doesn't need `pixel-client.yaml`.

## Agent Hierarchy

```
orchestrator              <- Drives PRD -> TRD -> implement pipeline
  |-- executor            <- Builds, tests, verifies
  |-- pixel-client        <- WebGL game client
  |-- pixel-server        <- Game server
  |-- pixel-common        <- Shared game code
  |-- astro-site          <- Astro website
  |-- python-api          <- Python backend
  |-- infra-devops        <- CI/CD, deployment
```

## Slash Commands

| Command | Purpose |
|---------|---------|
| `/build-all` | TypeScript + webpack + Astro + pip install |
| `/test-all` | Run all test suites with summary |
| `/status` | Git + Linear + servers dashboard |
| `/sync-linear` | Display Linear sprint board |

## How It Works

### Versioned (the shell)
- **Agent YAMLs** (`agents/`) - Role definitions, tool access, boundaries, integration protocols
- **Commands** (`commands/`) - Slash command definitions
- **Templates** (`templates/knowledge/`) - Example knowledge files showing expected structure

### Gitignored (the project override)
- **Knowledge files** (`knowledge/`) - Project-specific context (tech stack, file paths, completed tickets)
- **Settings** (`settings.json`, `settings.local.json`) - Claude Code project permissions

### Why this split?
Agent roles and tools are reusable across projects. Knowledge is project-specific.
An "executor" agent always builds and tests - but *what* it builds changes per project.
A "python-api" agent always works with SQLAlchemy models - but *which* models changes per project.

## Adding to a New Project

1. `git submodule add` at `.claude`
2. Run `setup.sh` to generate knowledge files from templates
3. Edit knowledge files for your project
4. Remove agents that don't apply to your stack
5. Optionally add project-specific agents in `agents/`

## Updating

```bash
# Pull latest agent definitions
cd .claude && git pull origin main

# Your knowledge files are unaffected (gitignored)
```

## License

Personal use.
