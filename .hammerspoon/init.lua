-- Hammerspoon init.lua

-- IPC有効化（hs CLIから操作可能にする）
require("hs.ipc")

-- ログイン時に自動起動
hs.autoLaunch(true)

-- アニメーション無効化
hs.window.animationDuration = 0

-- 設定ファイルの自動リロード
local watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
  local shouldReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      shouldReload = true
      break
    end
  end
  if shouldReload then
    hs.reload()
  end
end):start()

-- 手動リロード: Ctrl+Alt+R
hs.hotkey.bind({"ctrl", "alt"}, "r", function()
  hs.reload()
end)

-- モジュール読み込み（共通）
-- Note: ウィンドウ管理/ワークスペースはAeroSpaceに移行済み
require("modules.app_switcher")
require("modules.clipboard")
require("modules.search")

-- コマンドランチャー（共通定義を読み込み）
pcall(require, "modules.command_launcher")
-- マシン固有のコマンドを追加（なければスキップ）
pcall(require, "modules.command_launcher_local")
-- 全コマンド登録後にホットキーをバインド
pcall(require, "modules.command_launcher_init")

-- リロード完了通知
hs.notify.new({title = "Hammerspoon", informativeText = "Config reloaded"}):send()
