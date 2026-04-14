# Toolchain contract

This repository is currently a publication-held wider-matrix local tranche.

## Planned commands after promotion
- `gleam deps download`
- `gleam format --check src test`
- `gleam test`
- `gleam run -- --list-values`

## Stability checks
- `python3 scripts/validate_scaffold.py`
- `nix run .#check`

## Current limitation
- Docker remains the portable release gate for runtime promotion, and the live-provider lane is still deferred.

## Validation notes
- Docker is the portable release gate for runtime promotion.
- The current docs/CI surface stays focused on publication-held stability until the repo gains runnable depth.
