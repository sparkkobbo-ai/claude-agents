# Build All Codebases

Run build checks across all Kobold Community Hub codebases and report results.

## Steps

1. **Pixel.Horse TypeScript Check**
   ```bash
   cd pixel.horse && npx tsc --noEmit
   ```
   Report: PASS or FAIL with error count

2. **Pixel.Horse Webpack Build**
   ```bash
   cd pixel.horse && npm run webpack-prod
   ```
   Report: PASS or FAIL with errors

3. **Astro Site Build**
   ```bash
   cd site && npm run build
   ```
   Report: PASS or FAIL with errors

4. **Python API Install Check**
   ```bash
   cd api && pip install -e ".[dev]" --quiet
   ```
   Report: PASS or FAIL

## Output Format

```
=== Build All Results ===
[PASS/FAIL] pixel.horse TypeScript    (Xs)
[PASS/FAIL] pixel.horse Webpack       (Xs)
[PASS/FAIL] site Astro Build          (Xs)
[PASS/FAIL] api Python Install        (Xs)
=========================
Total: X/4 passed
```

## Notes
- Run from the `kobold_community_hub/` root directory
- pixel.horse webpack requires `--max_old_space_size=8192`
- If webpack fails due to stale bundles, delete old `build/bootstrap-*.js` files first
- Astro site is in the `site/` subdirectory
- Python API is in the `api/` subdirectory
