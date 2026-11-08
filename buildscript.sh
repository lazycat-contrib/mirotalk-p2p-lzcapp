#!/bin/sh
# Fetch the upstream source that lzc-build.yml embeds.
#
# MiroTalk P2P publishes no versioned container images, and its Docker Hub
# tag list contains only `latest`. So we clone the upstream source here and
# let the embed step build it. The Dockerfile lives inside this checkout,
# which is what embed requires: dockerfile and context must stay within the
# project root.
set -e

VERSION="${MIROTALK_VERSION:-v2.2.81}"
DEST="upstream"

rm -rf "$DEST"
mkdir -p "$DEST"

echo "fetching mirotalk $VERSION"
# Upstream has no release tags; try one anyway, then fall back to master.
if ! git clone --depth 1 --branch "$VERSION" https://github.com/miroslavpejic85/mirotalk.git "$DEST" 2>/dev/null; then
  echo "tag $VERSION not found, cloning default branch"
  git clone --depth 1 https://github.com/miroslavpejic85/mirotalk.git "$DEST"
fi

rm -rf "$DEST/.git"

echo "upstream ready:"
ls "$DEST"
