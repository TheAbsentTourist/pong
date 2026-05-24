#!/bin/sh
printf '\033c\033]0;%s\a' Pong
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Pong.x86_64" "$@"
