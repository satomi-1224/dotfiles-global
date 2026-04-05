-- modules/command_launcher_init.lua: command_launcher のバインド実行
-- 共通 + 固有のコマンドが全て登録された後に呼ぶ

local launcher = require("modules.command_launcher")

for key, cmd in pairs(launcher.commands) do
  hs.hotkey.bind(launcher.mods, key, function()
    hs.execute(cmd, true)
  end)
end
