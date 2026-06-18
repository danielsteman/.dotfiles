#!/bin/bash
STATE_FILE="$HOME/.cache/kitty-theme-state"
THEME_DIR="$(dirname "$0")"

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "dark" ]; then
    kitty @ set-colors --all --configured "$THEME_DIR/catppuccin-latte.conf"
    echo "light" > "$STATE_FILE"
else
    kitty @ set-colors --all --configured "$THEME_DIR/catppuccin-mocha.conf"
    echo "dark" > "$STATE_FILE"
fi
