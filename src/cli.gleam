@external(erlang, "cli_ffi", "arguments")
pub fn arguments() -> List(String)

@external(erlang, "cli_ffi", "write_stdout")
pub fn write_stdout(text: String) -> Nil

@external(erlang, "cli_ffi", "write_stderr")
pub fn write_stderr(text: String) -> Nil

@external(erlang, "cli_ffi", "halt")
pub fn halt(code: Int) -> Nil
