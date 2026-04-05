#!/bin/bash
# AeroSpace workspace壁紙切替スクリプト
# on-workspace-changeコールバックから呼ばれる
# 画像マッピングは wallpaper_config.sh で定義

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# マシン固有の壁紙マッピングを読み込み（なければスキップ）
if [[ -f "$SCRIPT_DIR/wallpaper_config.sh" ]]; then
  source "$SCRIPT_DIR/wallpaper_config.sh"
fi

WORKSPACE="$AEROSPACE_FOCUSED_WORKSPACE"
WALLPAPER="${WALLPAPERS[$WORKSPACE]}"

if [[ -n "$WALLPAPER" && -f "$WALLPAPER" ]]; then
  osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
fi
