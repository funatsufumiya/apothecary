#!/usr/bin/env bash
set -e
# capture failing exits in commands obscured behind a pipe
set -o pipefail

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
ROOT=$(cd $(dirname "$0"); pwd -P)/../../
APOTHECARY_PATH=$ROOT/apothecary

BUNDLE_NO="$1"
# Check if the argument is provided
if [ -z "${BUNDLE_NO+x}" ]; then
    echo "No argument provided."
    export BUNDLE=1
else
    echo "Argument 1: $BUNDLE_NO"
    export BUNDLE=$BUNDLE_NO
fi

export TARGET=emscripten
export PLATFORM=emscripten
export ARCH=64
export NO_FORCE=ON
export PTHREADS_ENABLED=1

echo "Target: $TARGET"
echo "Architecture: $ARCH"
echo "Bundle: $BUNDLE"
echo "Apothecary path: $APOTHECARY_PATH"

${ROOT}./scripts/build.sh

echo "   Build Successful. Now Packaging ..."
${ROOT}./scripts/package.sh

echo "   Completed"


