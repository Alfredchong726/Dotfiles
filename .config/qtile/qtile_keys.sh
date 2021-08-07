#!/usr/bin/env bash
set -euo pipefail

sed -n '/START_KEYS/,/END_KEYS/p' ~/.config/qtile/config.py | \
    grep -v '#' | \
    grep 'Key' | \
    sed -e 's/^[ \t]*//'
