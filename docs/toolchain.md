# Toolchain contract

This repository is currently scaffold-only.

## Planned commands after promotion
- `gleam format --check`
- `gleam test`

## Scaffold-time checks
- `python3 scripts/validate_scaffold.py`
- `nix run .#check` once Nix is available locally

## Current limitation
- `flake.lock` has not been generated locally because `nix` is not installed in the current environment.
