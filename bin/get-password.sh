#!/bin/sh
set -eu
YUBI="2:$(ykman list --serials 2>/dev/null | head -n1 | tr -d '\n')"
ENTRY="$1"
DB="$HOME/drive/CLI.kdbx"
sleep 3 # getting serial needs some time between access
keepassxc-cli show -s --no-password -y "$YUBI" "$DB" "$ENTRY" | \
    grep Password | \
    sed 's/^Password: \(.*\)$/\1/'
