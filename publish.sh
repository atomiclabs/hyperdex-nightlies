#!/bin/bash

brew install rpm
git clone https://github.com/lukechilds/hyperdex

cd hyperdex/app
LATEST_COMMIT_SHA=$(git rev-parse HEAD)
LATEST_COMMIT_SHA_SHORT=$(git rev-parse --short HEAD)
npx dot-json package.json name 'hyperdex-nightly'
npx dot-json package.json productName 'HyperDEX Nightly'
npx dot-json package.json version "0.0.0-$LATEST_COMMIT_SHA_SHORT-$(echo $(npx utc-version))"

cd ..
LATEST_NIGHTLY_TAG=$(cd .. && git describe --tags $(git rev-list --tags --max-count=1))
NIGHTLY_HYPERDEX_COMMIT=$(git rev-parse $(echo "$LATEST_NIGHTLY_TAG" | cut -d- -f2))
RELEASE_NOTES="Changes: https://github.com/lukechilds/hyperdex/compare/$NIGHTLY_HYPERDEX_COMMIT...$LATEST_COMMIT_SHA"
npx dot-json package.json repository 'lukechilds/hyperdex-nightlies'
npx dot-json package.json build.appId 'com.lukechilds.hyperdex-nightly'
npx dot-json package.json build.releaseInfo.releaseNotes 'release note test'

npm install
webpack --mode=production
electron-builder --mac --linux --win --publish=always --config.releaseInfo.releaseNotes "$RELEASE_NOTES"
