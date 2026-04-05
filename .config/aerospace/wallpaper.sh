#!/bin/bash
# AeroSpace workspace壁紙切替スクリプト
# on-workspace-changeコールバックから呼ばれる
# get_wallpaper関数は wallpaper_config.sh で定義

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# マシン固有の壁紙マッピングを読み込み（なければスキップ）
# wallpaper_config.sh では get_wallpaper() 関数を定義する:
#   get_wallpaper() {
#     case "$1" in
#       1) echo "/path/to/wallpaper1.jpg" ;;
#       2) echo "/path/to/wallpaper2.jpg" ;;
#     esac
#   }
if [ -f "$SCRIPT_DIR/wallpaper_config.sh" ]; then
  . "$SCRIPT_DIR/wallpaper_config.sh"
fi

WORKSPACE="$AEROSPACE_FOCUSED_WORKSPACE"
WALLPAPER="$(get_wallpaper "$WORKSPACE")"

if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
  osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
fi
