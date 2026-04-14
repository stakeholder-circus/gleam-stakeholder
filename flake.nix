{
  description = "stakeholder-circus gleam-stakeholder";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ erlang gleam rebar3 git jq python312 ];
          };
        });
      apps = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
            mk = name: text: {
              type = "app";
              program = "${pkgs.writeShellScript name text}";
            };
        in {
          build = mk "build" ''gleam deps download && gleam test && gleam run -- --list-values'';
          test = mk "test" ''gleam deps download && gleam test'';
          check = mk "check" ''python3 scripts/validate_scaffold.py && gleam deps download && gleam format --check src test && gleam test && gleam run -- --list-values'';
          format = mk "format" ''gleam format src test'';
        });
    };
}
