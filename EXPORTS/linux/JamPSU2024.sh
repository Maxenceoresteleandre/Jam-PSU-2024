#!/bin/sh
echo -ne '\033c\033]0;JamPSU2024\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/JamPSU2024.x86_64" "$@"
