{
  description = "Mint";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mint = pkgs.stdenv.mkDerivation {
          name = "mint";
          src = ./.;
          installPhase = ''
            mkdir -p $out/bin
            cp mint $out/bin/mint
          '';
        };
      in
      {
        packages = {
          default = mint;
          inherit mint;
        };

        apps =
          let
            app = { program = "${mint}/bin/mint"; type = "app"; };
          in
          {
            default = app;
            mint = app;
          };

        # devShells = {
        #   default = pkgs.mkShell {
        #     packages = [
        #       # mint
        #     ];
        #   };
        # };
      }
    );
}
