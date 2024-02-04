{
  description = "Rust coin";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = { url = "github:nix-community/fenix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, flake-utils, fenix } @ inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ fenix.overlays.default ];
          pkgs = import nixpkgs { inherit overlays system; };
          toolchain = pkgs.fenix.complete;
          libraries = with pkgs;[
            pkg-config
          ];
          packages = with pkgs; [
            pkg-config
            openssl
            cargo-deny
            cargo-edit
            cargo-watch
            rust-analyzer
            (with toolchain; [
              cargo
              rustc
              rust-src
              clippy
              rustfmt
            ])
          ];
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = packages;
            RUST_BACKTRACE = "full";
            RUST_SRC_PATH = "${toolchain.rust-src}/lib/rustlib/src/rust/library"; # for better in-editor support
            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH";
          };
        });
}
