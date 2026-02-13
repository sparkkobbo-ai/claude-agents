# Pixel.Horse Common Knowledge

## Overview

Shared TypeScript code used by both client and server. Located in `pixel.horse/src/ts/common/`.

## Key Files

| File | Size | Purpose |
|------|------|--------|
| `entities.ts` | 99KB | 100+ entity types, mixin-based composition |
| `interfaces.ts` | 39KB | Core types: Entity, Pony, Action, MapFlags |
| `mixins.ts` | ~5KB | mixDraw, mixAnimation, mixLight, mixColliders |
| `lineOfSight.ts` | 10KB | Shadowcasting algorithm for visibility |
| `encoders/` | Various | Binary network protocol (encoder/decoder) |

## Entity System (Mixin Composition)

```typescript
export const lanternOn = registerMix('lantern-on',
    mixDraw(lanternSprite, offsetX, offsetY, paletteIndex),
    mixColliders(lanternCollider),
    mixLight(0xffcc00ff, 1.5),
    mixInteract(toggleLantern)
);
```

## Critical Rules

- Entity types use mixin composition, NOT class inheritance
- New Action values go in the Action enum in interfaces.ts
- registerOpaqueEntityType() if entity blocks LoS
- UpdateFlags are frozen - changes need encoder/decoder updates on BOTH sides
- Don't store heavy data in entity options (serialized every tick)

## Core Interfaces

- `Entity`: id, type, flags, state, x/y/z, vx/vy, hold
- `MapFlags`: EditableWalls, EditableEntities, Underground (enables LoS)
- `Action`: Boop, TurnHead, Sit, PlaceBlock(43), MineBlock(44)
