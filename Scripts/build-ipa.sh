#!/usr/bin/env bash
set -euo pipefail

scheme="AttackVPN"
project="AttackVPN.xcodeproj"
build="build"
derived="$build/DerivedData"

rm -rf "$build"
mkdir -p "$build"

xcodebuild \
  -project "$project" \
  -scheme "$scheme" \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath "$derived" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY="" \
  build

app="$derived/Build/Products/Release-iphoneos/$scheme.app"
payload="$build/Payload"
rm -rf "$payload"
mkdir -p "$payload"
cp -R "$app" "$payload/"
( cd "$build" && zip -qry "$scheme.ipa" Payload )
rm -rf "$payload"
echo "ipa ready: $build/$scheme.ipa"
