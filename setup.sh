#!/usr/bin/env bash
set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

flutter pub get

bash <(curl -fsSL https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh) --quiet

rustup target add wasm32-unknown-unknown

cargo build --manifest-path modules/denpamemo_logics/rust/Cargo.toml
