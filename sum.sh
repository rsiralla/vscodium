#!/bin/bash

npm install -g checksum

sum_file () {
  if [[ -f "$1" ]]; then
    checksum -a sha256 "$1" > "$1".sha256
    checksum "$1" > "$1".sha1
  fi
}

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$OS_NAME" == "osx" ]]; then
    sum_file VSCodium-darwin-*.zip
    sum_file VSCodium*.dmg
  elif [[ "$OS_NAME" == "windows" ]]; then
    sum_file VSCodiumSetup-*.exe
    sum_file VSCodiumUserSetup-*.exe
    sum_file VSCodium-win32-*.zip
    sum_file "VSCodium-${VSCODE_ARCH}-${MS_TAG}.msi"
    sum_file "VSCodium-${VSCODE_ARCH}-updates-disabled-${MS_TAG}.msi"
  else # linux
    sum_file VSCodium-*.AppImage
    sum_file VSCodium-linux*.tar.gz
    sum_file *.deb
    sum_file *.rpm
  fi
fi
