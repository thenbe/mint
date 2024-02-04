# mint 🏭

A tool for scaffolding dev environments. Powered by nix.

```
$ nix run github:thenbe/mint -- rust my-app

Minting files:
my-app/.envrc
my-app/flake.lock
my-app/flake.nix
Template has been successfully created.
```

## Usage

```bash
nix run github:thenbe/mint -- $TEMPLATE $DIRECTORY
```
