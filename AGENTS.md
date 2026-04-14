# gleam-stakeholder AGENTS

1. Preserve imported Rust history and explicit provenance docs; do not present this repo as greenfield work.
2. This repo is a publication-held wider-matrix local tranche with classic-six plus modern-core depth implemented locally.
3. Required native commands for the current tranche:
   - `gleam deps download`
   - `gleam format --check src test`
   - `gleam test`
   - `gleam run -- --list-values`
4. Docker is the portable release gate for runtime promotion; keep the Docker smoke contract aligned with the native tranche.
5. Keep `origin` intended for `stakeholder-circus/gleam-stakeholder` and `upstream` pointed at `https://github.com/giacomo-b/rust-stakeholder`.
6. Deterministic normalized JSON, explicit fail-fast gaps, and traceability rows back to Rust and stakeholder-core are mandatory.
7. Do not hide missing behavior behind placeholders; record it in `GAPS.md` instead.
