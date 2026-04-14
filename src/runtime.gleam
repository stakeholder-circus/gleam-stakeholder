import catalog
import gleam/int
import gleam/list
import gleam/string

pub type RunResult {
  RunResult(exit_code: Int, stdout_text: String, stderr_text: String)
}

pub fn run(args: List(String)) -> RunResult {
  case parse_args(args, [], []) {
    Error(message) -> RunResult(1, "", message <> "\n")
    Ok(#(values, flags)) -> {
      let provider = lookup(values, "experimental-provider")
      let orphan_experimental = has_orphan_experimental(values, flags)
      case provider {
        Ok(_) ->
          RunResult(
            1,
            "",
            "experimental-provider is not implemented yet in gleam-stakeholder\n",
          )
        Error(Nil) ->
          case orphan_experimental {
            True ->
              RunResult(
                1,
                "",
                "experimental flags require --experimental-provider\n",
              )
            False -> continue_run(values, flags)
          }
      }
    }
  }
}

fn continue_run(
  values: List(#(String, String)),
  flags: List(String),
) -> RunResult {
  case list.contains(flags, "list-values") {
    True -> RunResult(0, list_values_json() <> "\n", "")
    False ->
      case lookup(values, "focus-family") {
        Error(Nil) ->
          RunResult(
            1,
            "",
            "focus-family is required and must be a known generator family\n",
          )
        Ok(family) ->
          case list.contains(catalog.generator_families, family) {
            False ->
              RunResult(
                1,
                "",
                "focus-family is required and must be a known generator family\n",
              )
            True -> {
              let seed = case lookup(values, "seed") {
                Ok(value) -> value
                Error(Nil) -> "default-seed"
              }
              let format = case lookup(values, "output-format") {
                Ok(value) -> value
                Error(Nil) -> "text"
              }
              let payload = payload_json(family, seed)
              case format {
                "json" -> RunResult(0, payload <> "\n", "")
                _ -> RunResult(0, payload_text(family, seed) <> "\n", "")
              }
            }
          }
      }
  }
}

fn parse_args(
  args: List(String),
  values: List(#(String, String)),
  flags: List(String),
) -> Result(#(List(#(String, String)), List(String)), String) {
  case args {
    [] -> Ok(#(list.reverse(values), list.reverse(flags)))
    ["--list-values", ..rest] ->
      parse_args(rest, values, ["list-values", ..flags])
    ["--alerts", ..rest] -> parse_args(rest, values, ["alerts", ..flags])
    ["--minimal", ..rest] -> parse_args(rest, values, ["minimal", ..flags])
    ["--team", ..rest] -> parse_args(rest, values, ["team", ..flags])
    ["--no-color", ..rest] -> parse_args(rest, values, ["no-color", ..flags])
    ["--trace", ..rest] -> parse_args(rest, values, ["trace", ..flags])
    ["--experimental-disable-cache", ..rest] ->
      parse_args(rest, values, ["experimental-disable-cache", ..flags])
    ["--focus-family", value, ..rest] ->
      parse_args(rest, [#("focus-family", value), ..values], flags)
    ["--output-format", value, ..rest] ->
      parse_args(rest, [#("output-format", value), ..values], flags)
    ["--seed", value, ..rest] ->
      parse_args(rest, [#("seed", value), ..values], flags)
    ["--experimental-provider", value, ..rest] ->
      parse_args(rest, [#("experimental-provider", value), ..values], flags)
    ["--experimental-mode", value, ..rest] ->
      parse_args(rest, [#("experimental-mode", value), ..values], flags)
    ["--experimental-profile", value, ..rest] ->
      parse_args(rest, [#("experimental-profile", value), ..values], flags)
    ["--experimental-prompt-asset", value, ..rest] ->
      parse_args(rest, [#("experimental-prompt-asset", value), ..values], flags)
    ["--experimental-prompt-version", value, ..rest] ->
      parse_args(
        rest,
        [#("experimental-prompt-version", value), ..values],
        flags,
      )
    ["--experimental-personalization-profile", value, ..rest] ->
      parse_args(
        rest,
        [#("experimental-personalization-profile", value), ..values],
        flags,
      )
    ["--experimental-model", value, ..rest] ->
      parse_args(rest, [#("experimental-model", value), ..values], flags)
    ["--experimental-base-url", value, ..rest] ->
      parse_args(rest, [#("experimental-base-url", value), ..values], flags)
    ["--experimental-session-file", value, ..rest] ->
      parse_args(rest, [#("experimental-session-file", value), ..values], flags)
    ["--experimental-store", value, ..rest] ->
      parse_args(rest, [#("experimental-store", value), ..values], flags)
    ["--experimental-bootstrap-command", value, ..rest] ->
      parse_args(
        rest,
        [#("experimental-bootstrap-command", value), ..values],
        flags,
      )
    [unknown, ..] -> Error("unknown flag or positional argument: " <> unknown)
  }
}

fn lookup(values: List(#(String, String)), key: String) -> Result(String, Nil) {
  case values {
    [] -> Error(Nil)
    [#(candidate, value), ..rest] ->
      case candidate == key {
        True -> Ok(value)
        False -> lookup(rest, key)
      }
  }
}

fn has_orphan_experimental(
  values: List(#(String, String)),
  flags: List(String),
) -> Bool {
  list.any(values, fn(item) {
    let #(key, _) = item
    key != "experimental-provider" && string.starts_with(key, "experimental-")
  })
  || list.any(flags, fn(flag) {
    string.starts_with(flag, "experimental-")
    && flag != "experimental-disable-cache"
  })
}

fn list_values_json() -> String {
  let generator_entries =
    list.map(catalog.generator_families, fn(family) {
      "    {\n"
      <> "      \"id\": \""
      <> family
      <> "\",\n"
      <> "      \"registryId\": \""
      <> catalog.registry_id(family)
      <> "\",\n"
      <> "      \"rendererKey\": \""
      <> catalog.renderer_key(family)
      <> "\",\n"
      <> "      \"tranche\": \""
      <> catalog.tranche(family)
      <> "\"\n"
      <> "    }"
    })
  "{\n"
  <> field_array("complexities", catalog.complexities)
  <> ",\n"
  <> field_array("devTypes", catalog.dev_types)
  <> ",\n"
  <> field_array("experimentalFlags", catalog.experimental_flags)
  <> ",\n"
  <> field_array("experimentalModes", catalog.experimental_modes)
  <> ",\n"
  <> field_array("experimentalProviders", catalog.experimental_providers)
  <> ",\n"
  <> field_array("flags", [
    "alerts",
    "project",
    "minimal",
    "team",
    "framework",
    "seed",
    "output-format",
    "no-color",
    "trace",
    "list-values",
    ..catalog.experimental_flags
  ])
  <> ",\n"
  <> "  \"generatorFamilies\": [\n"
  <> string.join(generator_entries, with: ",\n")
  <> "\n  ],\n"
  <> field_array("jargonLevels", catalog.jargon_levels)
  <> ",\n"
  <> field_array("outputFormats", catalog.output_formats)
  <> ",\n"
  <> field_array("personalizationProfiles", catalog.personalization_profiles)
  <> ",\n"
  <> field_array("promptAssets", catalog.prompt_assets)
  <> "\n}"
}

fn field_array(name: String, values: List(String)) -> String {
  let body =
    values
    |> list.map(fn(value) { "\"" <> value <> "\"" })
    |> string.join(with: ", ")
  "  \"" <> name <> "\": [" <> body <> "]"
}

fn payload_json(family: String, seed: String) -> String {
  let #(context_key, context_value) = catalog.dedicated_context(family)
  let sequence = sequence_for(seed, family)
  let timestamp = timestamp_for(seed, family)
  let fingerprint = fingerprint(seed, family)
  "{\n"
  <> "  \"eventType\": \"stakeholder.generator.output\",\n"
  <> "  \"sequence\": "
  <> int.to_string(sequence)
  <> ",\n"
  <> "  \"family\": \""
  <> family
  <> "\",\n"
  <> "  \"message\": \"Deterministic gleam tranche for "
  <> family
  <> "\",\n"
  <> "  \"timestamp\": \""
  <> timestamp
  <> "\",\n"
  <> "  \"context\": {\n"
  <> "    \"rendererKey\": \""
  <> catalog.renderer_key(family)
  <> "\",\n"
  <> "    \""
  <> context_key
  <> "\": \""
  <> context_value
  <> "\",\n"
  <> "    \"seedFingerprint\": \""
  <> fingerprint
  <> "\",\n"
  <> "    \"gleamProfile\": \"publication-held-wider-matrix\"\n"
  <> "  }\n"
  <> "}"
}

fn payload_text(family: String, seed: String) -> String {
  let sequence = sequence_for(seed, family)
  let timestamp = timestamp_for(seed, family)
  string.join(
    [
      "family: " <> family,
      "renderer: " <> catalog.renderer_key(family),
      "sequence: " <> int.to_string(sequence),
      "timestamp: " <> timestamp,
      "message: Deterministic gleam tranche for " <> family,
    ],
    with: "\n",
  )
}

fn sequence_for(seed: String, family: String) -> Int {
  int.modulo(hash(seed <> "::" <> family), 9000)
  |> result_replace(0)
  |> fn(value) { value + 1000 }
}

fn timestamp_for(seed: String, family: String) -> String {
  let seconds =
    int.modulo(hash("timestamp::" <> seed <> "::" <> family), 86_400)
    |> result_replace(0)
  let hour = seconds / 3600
  let minute = int.modulo(seconds / 60, 60) |> result_replace(0)
  let second = int.modulo(seconds, 60) |> result_replace(0)
  "2026-01-01T" <> pad(hour) <> ":" <> pad(minute) <> ":" <> pad(second) <> "Z"
}

fn fingerprint(seed: String, family: String) -> String {
  catalog.registry_id(family)
  <> "-"
  <> int.to_string(hash(seed <> "::" <> family))
}

fn hash(input: String) -> Int {
  hash_loop(
    string.to_utf_codepoints(input)
      |> list.map(string.utf_codepoint_to_int),
    2_166_136_261,
  )
}

fn hash_loop(codepoints: List(Int), acc: Int) -> Int {
  case codepoints {
    [] -> acc
    [first, ..rest] -> {
      let next = acc * 16_777_619 + first
      hash_loop(rest, next)
    }
  }
}

fn pad(value: Int) -> String {
  case value < 10 {
    True -> "0" <> int.to_string(value)
    False -> int.to_string(value)
  }
}

fn result_replace(result: Result(Int, Nil), fallback: Int) -> Int {
  case result {
    Ok(value) -> value
    Error(Nil) -> fallback
  }
}
