#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

read -rp "Profile (laptop/server, blank for base only): " profile

brew bundle --file=<(cat \
    "$CONFIG_DIR/Brewfile.base" \
    ${profile:+"$CONFIG_DIR/Brewfile.$profile"})
