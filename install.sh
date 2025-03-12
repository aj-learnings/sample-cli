#!/bin/bash

set -e

REPO="aj-learnings/sample-cli"
VERSION="v1.0.0"

OS=$(uname -s)
ARCH=$(uname -m)

if [[ "$OS" == "Linux" ]]; then
  FILE="my-cli-linux-amd64"
elif [[ "$OS" == "Darwin" ]]; then
  FILE="my-cli-darwin-amd64"
elif [[ "$OS" == "Windows_NT" ]]; then
  FILE="my-cli-windows-amd64.exe"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

URL="https://github.com/$REPO/releases/download/$VERSION/$FILE"

echo "Downloading $URL..."
curl -L -o "$FILE" "$URL"
chmod +x "$FILE"

# Move to a directory in PATH
# sudo mv "$FILE" /usr/local/bin/my-cli

echo "my-cli installed successfully! 🎉"
