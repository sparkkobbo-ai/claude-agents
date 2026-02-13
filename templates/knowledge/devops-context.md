# Infrastructure & DevOps Knowledge

## GitHub Organization

- **Org:** Kobold-Kavern
- **Main Repo:** https://github.com/Kobold-Kavern/kobold_community_hub
- **Pixel.Horse Repo:** https://github.com/Kobold-Kavern/pixel-horse-reference

## SSH Configuration

Push uses `github.com-klank` SSH host alias.

## Branch Conventions

| Pattern | Purpose |
|---------|--------|
| `main` | Stable, deployable |
| `feat/KOB-{N}-description` | Feature branches |
| `fix/KOB-{N}-description` | Bug fix branches |
| `worktree/frontend` | Frontend concern |
| `worktree/backend` | Backend concern |

## Ports

| Service | Port |
|---------|------|
| Pixel.Horse Game | 8090 |
| Pixel.Horse Admin | 8091 |
| Astro Dev | 4321 |
| MongoDB | 27017 |

## Package Management

- `.npmrc` with `legacy-peer-deps=true`
- `pyproject.toml` with dev deps

## Deployment Target

- Raspberry Pi 5 (8GB) + Tailscale Funnel
- MongoDB for game state
- PostgreSQL (planned) for API

## CI/CD

- GitHub Actions: TypeScript check only
- Node 24.x
- Future: full build pipeline
