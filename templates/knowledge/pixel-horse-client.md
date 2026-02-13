# Pixel.Horse Client Knowledge

## Overview

Browser game client using WebGL rendering, Angular 19 for UI chrome, and custom IMGUI for in-game UI. Located in `pixel.horse/src/ts/client/`.

## Key Files

| File | Lines | Purpose |
|------|-------|--------|
| `game.ts` | 2300+ | Main `PonyTownGame` class - state machine, update/draw loops |
| `draw.ts` | ~800 | Rendering dispatch - entity/map/UI drawing, visibility |
| `handlers.ts` | ~400 | Network message handlers - entity state sync |
| `playerActions.ts` | ~250 | Input -> action conversions |
| `ui/imgui.ts` | ~400 | Immediate Mode GUI (IMGUI) - buttons, slots, panels |
| `webgl.ts` | ~300 | WebGL context init and resource management |

## IMGUI System

```typescript
class GameUI {
    beginFrame(batch, pointerX, pointerY, pointerDown): void
    endFrame(): void
    button(id, x, y, w, h, label?): boolean
    slot(id, x, y, size, item, selected?): boolean
    panel(x, y, w, h, color?): void
    label(x, y, text, color?): void
}
```

## Critical Pitfalls

- Use `player.hold` NOT `player.options.hold` (always 0)
- Calculate visibility BEFORE drawing
- Use `actionParam2` (10/s) for high-frequency heartbeats
- Grid-snap with `(x | 0)` for block positions

## Rendering Pipeline

1. `update()` - Game logic, input, visibility
2. `draw()` - Map tiles, entities (visibility filtered), fog, IMGUI
3. Entity depth sorting for isometric view
