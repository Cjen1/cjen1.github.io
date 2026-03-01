{
  description = "Typst knowledge trees development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    typst-knowledge-forests.url = "github:Cjen1/typst-knowledge-forests";
    typst-knowledge-forests.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, typst-knowledge-forests }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        tkf = typst-knowledge-forests.packages.${system}.default;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.typst
            pkgs.bashInteractive
            pkgs.github-copilot-cli
            tkf
          ];
        };
      });
}
