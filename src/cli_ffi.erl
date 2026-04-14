-module(cli_ffi).
-export([arguments/0, write_stdout/1, write_stderr/1, halt/1]).

arguments() ->
    [unicode:characters_to_binary(Arg) || Arg <- init:get_plain_arguments()].

write_stdout(Text) ->
    io:format("~ts", [Text]).

write_stderr(Text) ->
    io:format(standard_error, "~ts", [Text]).

halt(Code) ->
    erlang:halt(Code).
