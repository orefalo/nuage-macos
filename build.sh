#!/usr/bin/env bash
# Builds Nuage for release and places Nuage.app in the repository root.
set -euo pipefail

cd "$(dirname "$0")"

git submodule update --init --recursive

xcodebuild -project Nuage.xcodeproj -scheme Nuage -configuration Release build

products_dir=$(xcodebuild -project Nuage.xcodeproj -scheme Nuage -configuration Release -showBuildSettings \
    | awk -F' = ' '/^ *BUILT_PRODUCTS_DIR/ {print $2; exit}')

rm -rf Nuage.app
cp -R "$products_dir/Nuage.app" Nuage.app
echo "Built $(pwd)/Nuage.app"
