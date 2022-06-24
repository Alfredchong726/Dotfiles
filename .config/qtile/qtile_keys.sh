#!/usr/bin/env bash
set -euo pipefail

 sed -n '/START_KEYS/,/END_KEYS/p' ~/.config/qtile/config.py | \
  grep -v '# [A-Z]' | \
  grep 'Key' | \
  sed -e 's/^[ \t]*//'| \
  yad --text-info --back=#282c34 --fore=#46d9ff --geometry=1200x800
