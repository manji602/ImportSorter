#!/bin/sh

VERSION=1.0.1
DOWNLOAD_URI="http://github.com/manji602/ImportSorter/releases/download/${VERSION}/ImportSorter.tar.gz"
PLUGINS_DIR="${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins"

mkdir -p "${PLUGINS_DIR}"
curl -L $DOWNLOAD_URI | tar xvz -C "${PLUGINS_DIR}"

echo "ImportSorter successfuly installed! Please restart your Xcode."
