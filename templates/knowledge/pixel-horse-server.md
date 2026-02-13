# Pixel.Horse Server Knowledge

## Overview

Node.js game server using Express, WebSocket (ws), and MongoDB. Located in `pixel.horse/src/ts/server/`. Ports: 8090 (game), 8091 (admin).

## Key Files

| File | Lines | Purpose |
|------|-------|--------|
| `world.ts` | ~1000 | Game state manager - entity lifecycle, 60 FPS tick loop |
| `serverActions.ts` | ~1500 | RPC method handlers with @Method() decorators |
| `serverInterfaces.ts` | ~500 | Core interfaces (IClient, ServerEntity, Controller) |
| `controllers/` | Various | Game logic plugins (mining, walls, lighting) |
| `maps/` | Various | Map initialization (main, island, cave, underground) |
| `services/` | Various | Visibility, inventory persistence, friends, party |

## Action Handler Pattern

```typescript
@Method({ rateLimit: '10/s' })
actionParam2(client, action, param) {
    switch (action) {
        case Action.MineBlock: ...
        case Action.PlaceBlock: ...
    }
}
```

- `actionParam`: 2/s (occasional actions)
- `actionParam2`: 10/s (mining heartbeats, frequent)

## Key Patterns

- Controllers implement `Controller` interface
- Maps set `MapFlags` for behavior (Underground enables LoS)
- Entity mutations notify via `pushUpdateEntityToClient()`
- Rate limiting via @Method() decorator
