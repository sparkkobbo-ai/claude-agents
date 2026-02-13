# Python API Knowledge

## Overview

Backend API for Kobold Community Hub. Located in `api/`.

## Tech Stack

- Python 3.11+, SQLAlchemy 2.0, Alembic, pytest
- PostgreSQL (prod) / SQLite (dev/tests)
- Click-based CLI: `kobold-hub`

## Directory Structure

```
api/
├── kobold_hub/
│   ├── models/         # SQLAlchemy models
│   ├── db/base.py      # Base, custom types, mixins
│   ├── services/       # Business logic
│   ├── migrations/     # Alembic versions
│   ├── hash_id.py      # Hash ID generation (SHA-256)
│   ├── word_lists.py   # 6 categories x 60 words
│   └── cli.py          # CLI commands
└── tests/              # pytest tests
```

## Models

- **User**: discord_id, username, email, is_admin
- **Character**: hash_id, display_name, identity/lore/ttrpg/reality_status
- **CharacterRelationship**: bidirectional, perspective-specific labels
- **Story**: title, slug, content, status, metadata/stats/comments/series

## Custom Types (db/base.py)

- StringList: ARRAY on PostgreSQL, JSON TEXT on SQLite
- UUIDMixin, TimestampMixin, SoftDeleteMixin

## Patterns

- Models use mixins from db/base.py
- All new models need Alembic migration
- Tests in tests/ using pytest
- CLI uses Click, entry point: kobold-hub

## Commands

```bash
kobold-hub generate     # Hash IDs
kobold-hub export       # Word lists to JSON
kobold-hub stats        # Word list stats
kobold-hub verify <id>  # Verify hash ID
```
