#!/bin/bash
STATE_FILE="$HOME/.cache/kitty-theme-state"
THEME_DIR="$(dirname "$0")"

# KITTY_LISTEN_ON is set when listen_on is active; fall back to the PID-based socket
if [ -n "$KITTY_LISTEN_ON" ]; then
    KITTY_SOCKET="$KITTY_LISTEN_ON"
else
    KITTY_SOCKET="unix:/tmp/kitty-$PPID"
fi

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "dark" ]; then
    kitty @ --to "$KITTY_SOCKET" set-colors --all --configured "$THEME_DIR/catppuccin-latte.conf"
    echo "light" > "$STATE_FILE"
else
    kitty @ --to "$KITTY_SOCKET" set-colors --all --configured "$THEME_DIR/catppuccin-mocha.conf"
    echo "dark" > "$STATE_FILE"
fi
