import gleam/string
import gleeunit
import gleeunit/should
import runtime

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn list_values_test() {
  let result = runtime.run(["--list-values"])
  should.equal(result.exit_code, 0)
  should.equal(string.contains(result.stdout_text, "\"code_analyzer\""), True)
  should.equal(
    string.contains(result.stdout_text, "\"delivery_preview_ops\""),
    True,
  )
  should.equal(string.contains(result.stdout_text, "\"rendererKey\""), True)
}

pub fn dedicated_family_metadata_test() {
  let result =
    runtime.run([
      "--focus-family",
      "delivery_preview_ops",
      "--output-format",
      "json",
      "--seed",
      "smoke",
    ])
  should.equal(result.exit_code, 0)
  should.equal(
    string.contains(result.stdout_text, "\"family\": \"delivery_preview_ops\""),
    True,
  )
  should.equal(
    string.contains(
      result.stdout_text,
      "\"deliveryGuardrail\": \"preview-release-checkpoints\"",
    ),
    True,
  )
  should.equal(
    string.contains(
      result.stdout_text,
      "\"rendererKey\": \"modern-core.delivery_preview_ops\"",
    ),
    True,
  )
}

pub fn deterministic_same_seed_test() {
  let first =
    runtime.run([
      "--focus-family",
      "platform_engineering",
      "--output-format",
      "json",
      "--seed",
      "same-seed",
    ])
  let second =
    runtime.run([
      "--focus-family",
      "platform_engineering",
      "--output-format",
      "json",
      "--seed",
      "same-seed",
    ])
  should.equal(first.exit_code, 0)
  should.equal(first.stdout_text, second.stdout_text)
}

pub fn experimental_provider_fail_fast_test() {
  let result = runtime.run(["--experimental-provider", "openai-compatible"])
  should.equal(result.exit_code, 1)
  should.equal(
    string.contains(
      result.stderr_text,
      "experimental-provider is not implemented yet in gleam-stakeholder",
    ),
    True,
  )
}

pub fn orphan_experimental_flag_fail_fast_test() {
  let result = runtime.run(["--experimental-mode", "consumer-session"])
  should.equal(result.exit_code, 1)
  should.equal(
    string.contains(
      result.stderr_text,
      "experimental flags require --experimental-provider",
    ),
    True,
  )
}
