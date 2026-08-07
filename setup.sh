#!/usr/bin/env bash
set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

flutter pub get

bash <(curl -fsSL https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh) --quiet
