# gleam-stakeholder AGENTS

1. Preserve imported Rust history and explicit provenance docs; do not present this repo as greenfield work.
2. This repo is scaffold-only until promoted from the matrix queue.
3. Planned commands after promotion:
   - `gleam format --check`
   - `gleam test`
4. Keep `origin` intended for `stakeholder-circus/gleam-stakeholder` and `upstream` pointed at `https://github.com/giacomo-b/rust-stakeholder`.
5. Promotion work starts with deterministic normalized JSON, explicit fail-fast gaps, and traceability rows back to Rust and stakeholder-core.
6. Do not hide missing behavior behind placeholders; record it in `GAPS.md` instead.
