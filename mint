#!/usr/bin/env bash
set -eu

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
  echo "Usage  : $0 TEMPLATE DIRECTORY"
  echo "Example: $0 rust my-app"
  exit 1
fi

MINT_TEMPLATE=$1
MINT_DIRNAME=$2

REPO_URL="https://github.com/thenbe/mint/tarball/main"

# Scaffold
echo "Minting files:"
curl --no-progress-meter -L "$REPO_URL" |
  tar zx \
    --wildcards "*/dies/$MINT_TEMPLATE/*"                                `# extract only some files                                      ` \
    --transform "flags=r;s|^[a-z0-9-]*\/dies\/[a-z0-9-]*|$MINT_DIRNAME|" `# alter the final paths, replacing some leading path components` \
    --verbose                                                            `# list the extracted files                                     ` \
    --show-transformed-names                                             `# print the transformed path instead of the original           ` \

echo "Template has been successfully created."

# vim: filetype=bash
