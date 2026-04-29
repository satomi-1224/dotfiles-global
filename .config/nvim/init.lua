-- init.lua
-- Neovim設定のエントリポイント
-- このファイルからすべての設定を読み込む
--
-- 読み込み順序が重要:
--   1. options  → Neovim本体のオプション設定
--   2. keymaps  → プラグインに依存しないキーマップ
--   3. autocmds → 自動コマンド（ファイル変更検知など）
--   4. lazy     → プラグインマネージャの起動とプラグインの読み込み

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
