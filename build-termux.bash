#!/usr/bin/env bash
# build-termux.bash: build.bash for Termux, the test environment. Termux keeps its programs in $PREFIX/bin, so that
# folder is put first in the PATH here. darklua can be installed with `cargo install darklua`, or copied to that folder.
# The build itself is build.bash.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
export PATH="$PREFIX/bin:$HOME/.cargo/bin:$PATH"

exec "$ROOT/build.bash" "$@"
