#!/usr/bin/env bash
set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

flutter pub get

bash <(curl -fsSL https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh) --quiet

# modules/denpamemo_logics builds the same Rust logic to Wasm for modules/server.
rustup target add wasm32-unknown-unknown
command -v wasm-pack >/dev/null || cargo install wasm-pack --locked

if ! command -v wasm-pack >/dev/null; then
  echo "wasm-pack was installed but its directory (e.g. ~/.cargo/bin) is not on your PATH; add it in your shell profile and open a new shell before running 'pnpm run dev'." >&2
  exit 1
fi
