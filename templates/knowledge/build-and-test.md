# Build & Test Reference (Executor)

## Prerequisites

| Tool | Version | Purpose |
|------|---------|--------|
| Node.js | 24+ LTS | Pixel.horse server & build |
| Python | 3.11+ | Kobold Hub API |
| MongoDB | Running instance | Pixel.horse database |
| npm | 11+ | Package management (uses `--legacy-peer-deps` via `.npmrc`) |

## Codebase Build Commands

### Pixel.Horse (`pixel.horse/`)

```bash
cd pixel.horse
npm install
npx tsc --noEmit
npm run webpack-prod
npm run startlocal
```

**Expected timing:**
- `npm install`: ~30s (cached), ~2min (fresh)
- `npx tsc --noEmit`: ~15s
- `npm run webpack-prod`: ~2-3 min
- `npm run build-sprites`: ~1-2 min (one-time)

### Astro Site (`site/`)

```bash
cd site
npm install
npm run build
npm run dev
```

### Python API (`api/`)

```bash
cd api
pip install -e ".[dev]"
pytest
pytest --cov=kobold_hub
```

## Test Endpoints

| Service | URL | Notes |
|---------|-----|------|
| Pixel.Horse Game | http://localhost:8090 | Requires MongoDB |
| Pixel.Horse Admin | http://localhost:8091/admin/ | Requires MongoDB |
| Astro Site | http://localhost:4321 | Dev server |

## Known Issues

### Windows Bundle Caching
After webpack rebuild, old JS bundles may be served. Delete old hashed bundles from `build/`.

### Canvas Native Module
Requires Visual Studio with Windows SDK.

### Sass Deprecations
Bootstrap 4.6.2 warnings - doesn't break build.
