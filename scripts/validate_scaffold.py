#!/usr/bin/env python3
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[1]
required = [
    'README.md',
    'AI_DISCLOSURE.md',
    'PARITY.md',
    'GAPS.md',
    'STATUS.md',
    'gleam.toml',
    'manifest.toml',
    'Dockerfile',
    'flake.lock',
    'src/cli_ffi.erl',
    'src/cli.gleam',
    'src/catalog.gleam',
    'src/runtime.gleam',
    'src/gleam_stakeholder.gleam',
    'test/gleam_stakeholder_test.gleam',
    'docs/remotes.md',
    'docs/provenance.md',
    'docs/toolchain.md',
    'docs/traceability/first-push-families.md',
    '.githooks/commit-msg',
    '.githooks/pre-push',
    '.github/CODEOWNERS',
    '.github/PULL_REQUEST_TEMPLATE.md',
    '.github/dependabot.yml',
    '.github/workflows/actionlint.yml',
    '.github/workflows/dependency-review.yml',
    '.github/workflows/ci.yml',
    '.github/workflows/ci-native.yml',
    '.github/workflows/docker-smoke.yml',
    'flake.nix',
]
missing = [item for item in required if not (root / item).exists()]
if missing:
    for item in missing:
        print(f'missing required file: {item}', file=sys.stderr)
    raise SystemExit(1)
print('gleam tranche scaffold validated')
