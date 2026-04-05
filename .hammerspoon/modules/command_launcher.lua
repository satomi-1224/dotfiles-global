-- modules/command_launcher.lua: コマンド実行ランチャー（共通）

local M = {}
M.mods = { "cmd", "alt", "shift" }
M.commands = {}

local home = os.getenv("HOME")

-- 共通コマンド
M.commands.t = "open -a WezTerm"
M.commands.f = "open -a Finder"
M.commands.b = "open -a 'Google Chrome'"

-- 修飾キー+Space: Claude
hs.hotkey.bind(M.mods, "space", function()
  hs.execute("open '" .. home .. "/Applications/Chrome Apps.localized/Claude.app'", true)
end)

-- 修飾キー+BS: フォーカス中のウィンドウを閉じる
hs.hotkey.bind(M.mods, "delete", function()
  local win = hs.window.focusedWindow()
  if win then
    win:close()
  end
end)

-- マシン固有の設定をマージしてからバインドするため、
-- bind は command_launcher_init で行う
return M
