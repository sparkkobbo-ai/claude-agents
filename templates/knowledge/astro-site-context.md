# Astro Site Knowledge

## Overview

Community website built with Astro 5.x and UnoCSS. Located in `site/`.

## Tech Stack

- **Framework:** Astro 5.x (static site generation)
- **Styling:** UnoCSS with custom theme
- **Markdown:** marked + isomorphic-dompurify
- **Type Safety:** TypeScript strict mode

## Directory Structure

```
site/
├── src/
│   ├── pages/          # Astro pages with file-based routing
│   ├── layouts/        # BaseLayout.astro
│   ├── components/     # Reusable .astro components
│   ├── data/           # Mock data / API integration
│   └── styles/         # Global CSS
├── public/assets/      # Static assets (sprites, UI, backgrounds)
└── uno.config.ts       # UnoCSS theme (kavern/torch palettes)
```

## UnoCSS Theme

**kavern** (blue-grey): backgrounds, borders (50-950)
**torch** (cyan-blue): accents, CTAs (50-950)

Shortcuts: `btn`, `btn-primary`, `btn-secondary`, `card`

## Styling Rules

- Use UnoCSS utility classes, not custom CSS
- kavern-* for backgrounds/borders
- torch-* for accents
- card shortcut for content panels
- btn-primary / btn-secondary for buttons
- All pages use BaseLayout wrapper

## Common Modifications

### Adding a page
1. Create .astro file in src/pages/
2. Wrap with BaseLayout
3. Add nav link in BaseLayout.astro

### Adding a component
1. Create .astro file in src/components/
2. Define Props interface
3. Import in pages
