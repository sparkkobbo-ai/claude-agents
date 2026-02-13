# Kobold Community Hub - Project Overview

## GitHub Organization

- **Org:** Kobold-Kavern
- **Main Repo:** https://github.com/Kobold-Kavern/kobold_community_hub
- **Pixel.Horse Repo:** https://github.com/Kobold-Kavern/pixel-horse-reference
- **Linear Workspace:** https://linear.app/kobold-kavern

## SSH Configuration

Push uses `github.com-klank` SSH host alias (configured in `~/.ssh/config`).

## Codebases

### 1. Kobold Community Hub (Main Repo)

Community website for kobold enthusiasts. Monorepo with three concerns:

| Directory | Stack | Purpose |
|-----------|-------|--------|
| `site/` | Astro 5.x + UnoCSS | Static site (pages, components, theme) |
| `api/` | Python 3.11, SQLAlchemy 2.0, Alembic | Backend API (models, migrations, CLI) |
| `game/` | (Planned) | Browser game client |
| `docs/` | Markdown | Design docs, word style guide |
| `scripts/` | (Planned) | Dev/deployment scripts |

### 2. Pixel.Horse (Separate Repo, inside `pixel.horse/`)

Private reference implementation derived from Pony Town. Used to extract game engine patterns for Kobold Hub's browser game.

| Directory | Stack | Purpose |
|-----------|-------|--------|
| `src/ts/client/` | TypeScript, WebGL, Angular 19 | Browser game client |
| `src/ts/server/` | TypeScript, Node 24, Express, MongoDB | Game server |
| `src/ts/common/` | TypeScript | Shared code (entities, encoders, interfaces) |
| `src/ts/graphics/` | WebGL | Renderer, sprite batching |

## Agent Mesh

| Agent | Domain | Key Files |
|-------|--------|----------|
| kobold-orchestrator | Project-wide coordination | All repos, Linear |
| kobold-executor | Build, test, verify | All build systems |
| pixel-client | WebGL game client | `pixel.horse/src/ts/client/` |
| pixel-server | Game server | `pixel.horse/src/ts/server/` |
| pixel-common | Shared game code | `pixel.horse/src/ts/common/` |
| astro-site | Community website | `site/` |
| python-api | Backend API | `api/` |
| infra-devops | CI/CD, deployment, git | GitHub Actions, Docker |

## Git Worktrees

| Directory | Branch | Concern |
|-----------|--------|--------|
| `kobold_community_hub/` | `main` | Full repo (orchestration) |
| `kobold-hub-frontend/` | `worktree/frontend` | Site, game, docs |
| `kobold-hub-backend/` | `worktree/backend` | API, docs |
| `pixel.horse/` | Own branches | Separate repo |

## Completed Linear Tickets

### Foundations
- **KOB-5:** Hash ID Generation System (word-based IDs)
- **KOB-6:** Word List Curation (60 words per 6 categories)
- **KOB-7:** Database Schema - Characters (SQLAlchemy models, Alembic)
- **KOB-44:** Static Site Generator Setup (Astro + UnoCSS)

### Pixel.Horse Modernization (KOB-56 through KOB-65)
- Node 24 LTS upgrade complete
- Angular 8 -> 19, TypeScript 5, Webpack 5, Mongoose 8
- All systems operational (server runs, client renders, game loads)

### Game Features
- **KOB-73-78:** Block Tool (pickaxe, PlaceBlock action, server handler, E key cycling, time-based mining)
- **KOB-79:** Line of Sight / Fog of War (shadowcasting, explored tiles, mining range)
- **KOB-80:** Inventory System (36-slot, server-authoritative, persistent, 102 tasks across 4 sprints)
- **KOB-91:** IMGUI System (immediate mode GUI for inventory/hotbar, 4 sprints complete)

### In Progress
- **KOB-51:** Integrate stock pixel art assets

## Design Philosophy

- No canon enforcement - all kobolds are valid
- No single IP owner - community-owned species
- No gatekeeping - moderate behavior, not designs
- 18+ community, SFW content focus
- Dual-timeline lore: Native dimension (personal stories) + Shared dimension (browser game)

## Branch Conventions

- `main` - stable, deployable
- `feat/KOB-{N}-description` - feature branches from Linear tickets
- `fix/KOB-{N}-description` - bug fix branches
- `worktree/frontend`, `worktree/backend` - worktree concern branches

## Key Technical Decisions

- **Hash IDs:** 3-word format (e.g., "amber-pickaxe-burrow"), SHA-256 based, 5.8M combinations
- **UnoCSS Theme:** Custom `kavern-*` (blue-grey) and `torch-*` (cyan-blue) color palettes
- **Entity System:** Mixin-based composition (pixel.horse pattern to extract)
- **Binary Protocol:** Conditional field encoding for efficient networking
- **IMGUI:** Immediate mode GUI for game UI elements
