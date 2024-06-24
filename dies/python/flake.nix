{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      allSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default =
          let
            pypkgs = pkgs.python311Packages;
          in
          pkgs.mkShell {
            name = "python-env";
            venvDir = "./.venv";
            packages = [
              pypkgs.python
              pypkgs.venvShellHook
              # pkgs.foo
            ];
            # Run this command, only after creating the virtual environment
            postVenvCreation = ''
              unset SOURCE_DATE_EPOCH
              # pip install -r requirements.txt
            '';

            # Now we can execute any commands within the virtual environment.
            # This is optional and can be left out to run pip manually.
            postShellHook = ''
              set -eu
              # allow pip to install wheels
              unset SOURCE_DATE_EPOCH
            '';
          };
      });
    };
}
