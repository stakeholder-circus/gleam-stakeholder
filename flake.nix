{
  description = "stakeholder-circus gleam-stakeholder scaffold";

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
            packages = with pkgs; [ git jq python312 ];
          };
        });
      apps = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
            mk = name: text: {
              type = "app";
              program = "${pkgs.writeShellScript name text}";
            };
        in {
          build = mk "build" ''python3 scripts/validate_scaffold.py'';
          test = mk "test" ''python3 scripts/validate_scaffold.py'';
          check = mk "check" ''python3 scripts/validate_scaffold.py'';
          format = mk "format" ''python3 scripts/validate_scaffold.py'';
        });
    };
}
