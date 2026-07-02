#!/usr/bin/env bash
set -euo pipefail

git config --global --add safe.directory "$(pwd)" || true

if [ -n "${CODEX_SQLITE_HOME:-}" ]; then
  mkdir -p "${CODEX_SQLITE_HOME}"
fi

if [ ! -f local.properties ]; then
  printf 'sdk.dir=%s\n' "${ANDROID_HOME}" > local.properties
fi

sed -i 's/\r$//' ./gradlew
chmod +x ./gradlew 2>/dev/null || true
bash ./gradlew --version
