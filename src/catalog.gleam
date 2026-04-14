import gleam/list
import gleam/string

pub const complexities = ["low", "medium", "high", "extreme"]

pub const dev_types = [
  "backend",
  "frontend",
  "fullstack",
  "data_science",
  "dev_ops",
  "blockchain",
  "machine_learning",
  "systems_programming",
  "game_development",
  "security",
]

pub const jargon_levels = ["low", "medium", "high", "extreme"]

pub const output_formats = ["text", "json"]

pub const experimental_flags = [
  "experimental-provider",
  "experimental-mode",
  "experimental-profile",
  "experimental-prompt-asset",
  "experimental-prompt-version",
  "experimental-personalization-profile",
  "experimental-model",
  "experimental-base-url",
  "experimental-session-file",
  "experimental-store",
  "experimental-bootstrap-command",
  "experimental-disable-cache",
]

pub const experimental_modes = [
  "prompt-versioned",
  "personalized",
  "consumer-session",
]

pub const experimental_providers = [
  "local-demo",
  "openai-compatible",
  "anthropic",
  "openai-consumer",
  "claude-consumer",
]

pub const personalization_profiles = ["local-operator"]

pub const prompt_assets = ["stakeholder-live-brief", "consumer-replay-brief"]

pub const generator_families = [
  "code_analyzer",
  "data_processing",
  "jargon",
  "metrics",
  "network_activity",
  "system_monitoring",
  "agent_workflows",
  "ai_inference_ops",
  "platform_engineering",
  "supply_chain_security",
  "observability_ai_runtime",
  "delivery_preview_ops",
  "evaluation_and_guardrails",
  "knowledge_retrieval",
  "edge_client_runtime",
  "identity_and_trust",
  "aibom_provenance",
  "agent_boundary_security",
  "embedded_agentic_pipeline",
  "data_governance_compliance",
  "finops_capacity",
  "blockchain_protocol_ops",
  "cross_chain_interop",
  "proof_and_sequencer_ops",
  "hybrid_runtime_ops",
  "capacity_cost_controller",
  "batch_execution_tuner",
  "compiler_maintainer",
  "interop_adapter_engineer",
  "preflight_capacity_planner",
  "simulator_performance_engineer",
  "fhir_profile_generator",
  "smart_launch_oauth",
  "bulk_fhir_population_ops",
  "hl7v2_feed_ops",
  "clinical_workflow_events",
  "dicomweb_imaging_ops",
  "openehr_semantic_record_ops",
  "device_telemetry_clinical",
  "emr_vendor_adapter",
  "ocpp_chargepoint_ops",
  "ocpi_roaming_ops",
  "mcp_a2a_ops",
  "streaming_bus_ops",
  "service_mesh_rpc_ops",
]

pub fn renderer_key(family: String) -> String {
  case family {
    "code_analyzer" -> "classic-six.code_analyzer"
    "data_processing" -> "classic-six.data_processing"
    "jargon" -> "classic-six.jargon"
    "metrics" -> "classic-six.metrics"
    "network_activity" -> "classic-six.network_activity"
    "system_monitoring" -> "classic-six.system_monitoring"
    "agent_workflows" -> "modern-core.agent_workflows"
    "platform_engineering" -> "modern-core.platform_engineering"
    "observability_ai_runtime" -> "modern-core.observability_ai_runtime"
    "delivery_preview_ops" -> "modern-core.delivery_preview_ops"
    "supply_chain_security" -> "modern-core.supply_chain_security"
    "ai_inference_ops" -> "fallback.ai_governance"
    "evaluation_and_guardrails" -> "fallback.ai_governance"
    "knowledge_retrieval" -> "fallback.ai_governance"
    "edge_client_runtime" -> "fallback.ai_governance"
    "identity_and_trust" -> "fallback.ai_governance"
    "aibom_provenance" -> "fallback.ai_governance"
    "agent_boundary_security" -> "fallback.security_blockchain"
    "embedded_agentic_pipeline" -> "fallback.security_blockchain"
    "data_governance_compliance" -> "fallback.security_blockchain"
    "finops_capacity" -> "fallback.security_blockchain"
    "blockchain_protocol_ops" -> "fallback.security_blockchain"
    "cross_chain_interop" -> "fallback.security_blockchain"
    "proof_and_sequencer_ops" -> "fallback.security_blockchain"
    "hybrid_runtime_ops" -> "fallback.health_protocol"
    "capacity_cost_controller" -> "fallback.health_protocol"
    "batch_execution_tuner" -> "fallback.health_protocol"
    "compiler_maintainer" -> "fallback.health_protocol"
    "interop_adapter_engineer" -> "fallback.health_protocol"
    "preflight_capacity_planner" -> "fallback.health_protocol"
    "simulator_performance_engineer" -> "fallback.health_protocol"
    "fhir_profile_generator" -> "fallback.health_protocol"
    "smart_launch_oauth" -> "fallback.health_protocol"
    "bulk_fhir_population_ops" -> "fallback.health_protocol"
    "hl7v2_feed_ops" -> "fallback.health_protocol"
    "clinical_workflow_events" -> "fallback.health_protocol"
    "dicomweb_imaging_ops" -> "fallback.health_protocol"
    "openehr_semantic_record_ops" -> "fallback.health_protocol"
    "device_telemetry_clinical" -> "fallback.health_protocol"
    "emr_vendor_adapter" -> "fallback.health_protocol"
    "ocpp_chargepoint_ops" -> "fallback.overlay_quantum"
    "ocpi_roaming_ops" -> "fallback.overlay_quantum"
    "mcp_a2a_ops" -> "fallback.overlay_quantum"
    "streaming_bus_ops" -> "fallback.overlay_quantum"
    "service_mesh_rpc_ops" -> "fallback.overlay_quantum"
    _ -> "fallback.unknown"
  }
}

pub fn dedicated_context(family: String) -> #(String, String) {
  case family {
    "code_analyzer" -> #("analysisFocus", "code-path-static-review")
    "data_processing" -> #("dataWindow", "batch-stream-reconciliation")
    "jargon" -> #("languagePolicy", "operator-plain-language")
    "metrics" -> #("signalBlend", "latency-errors-saturation")
    "network_activity" -> #("transportMix", "http-rpc-queue")
    "system_monitoring" -> #("telemetryScope", "host-service-runtime")
    "agent_workflows" -> #("coordinationMode", "planner-worker-handoff")
    "platform_engineering" -> #("platformSurface", "delivery-platform-routines")
    "observability_ai_runtime" -> #("runtimeSignals", "token-latency-judge-mix")
    "delivery_preview_ops" -> #(
      "deliveryGuardrail",
      "preview-release-checkpoints",
    )
    "supply_chain_security" -> #(
      "supplyChainPosture",
      "provenance-sbom-signing",
    )
    _ -> #(
      "fallbackFamily",
      first_result_or(
        string.split(renderer_key(family), on: ".")
          |> list.reverse
          |> list.first,
        "unknown",
      ),
    )
  }
}

pub fn registry_id(family: String) -> String {
  string.replace(in: family, each: "_", with: "-")
}

pub fn tranche(family: String) -> String {
  case family {
    "code_analyzer"
    | "data_processing"
    | "jargon"
    | "metrics"
    | "network_activity"
    | "system_monitoring" -> "classic-six"
    "agent_workflows"
    | "platform_engineering"
    | "observability_ai_runtime"
    | "delivery_preview_ops"
    | "supply_chain_security" -> "modern-core"
    _ ->
      first_result_or(
        string.split(renderer_key(family), on: ".")
          |> list.first,
        "fallback",
      )
  }
}

fn first_result_or(result: Result(String, Nil), fallback: String) -> String {
  case result {
    Ok(value) -> value
    Error(Nil) -> fallback
  }
}
