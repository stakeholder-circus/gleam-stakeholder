import cli
import runtime

pub fn main() -> Nil {
  let result = runtime.run(cli.arguments())
  cli.write_stdout(result.stdout_text)
  cli.write_stderr(result.stderr_text)
  cli.halt(result.exit_code)
}
