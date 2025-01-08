#!/bin/sh
echo -ne '\033c\033]0;PongBezPing\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Pong.x86_64" "$@"
