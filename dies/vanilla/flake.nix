{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # foo = pkgs.callPackage ./foo/default.nix { };
      in
      {
        packages = {
          # inherit foo;
          # bar = bar.outputs.packages.${system}.default;
        };

        apps = {
          # foo = { program = "${foo}/bin/foo.sh"; type = "app"; };
        };

        devShells = {
          # foo = pkgs.mkShell { packages = [ foo pkgs.cmake ]; };
          default = pkgs.mkShell {
            packages = [
              # foo
              # pkgs.cmake
            ];
            shellHook = ''
              set -eu
              # echo hello
            '';
          };
        };
      }
    );
}
