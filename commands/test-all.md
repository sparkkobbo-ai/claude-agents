# Test All Codebases

Run all test suites across Kobold Community Hub codebases and report pass/fail summary.

## Steps

1. **Python API Tests**
   ```bash
   cd api && pytest -v --tb=short
   ```
   Report: X passed, Y failed, Z errors

2. **Pixel.Horse TypeScript Tests** (if available)
   ```bash
   cd pixel.horse && npm run test-ts 2>&1 || echo "No TS tests configured"
   ```
   Report: X passed, Y failed or "Not configured"

3. **Astro Site Build Test** (build as smoke test)
   ```bash
   cd site && npm run build
   ```
   Report: PASS (builds successfully) or FAIL

## Output Format

```
=== Test All Results ===
[PASS/FAIL] api pytest          X passed, Y failed    (Xs)
[PASS/FAIL] pixel.horse tests   X passed, Y failed    (Xs)
[PASS/FAIL] site build check    Build succeeded        (Xs)
========================
Total: X/3 passed
```

## Notes
- Run from the `kobold_community_hub/` root directory
- Python tests require dev dependencies: `pip install -e ".[dev]"`
- pixel.horse TypeScript tests use mocha + ts-node
- Astro build serves as a smoke test (catches template and config errors)
- Report detailed failure output for any failing tests
