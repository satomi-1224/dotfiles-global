-- modules/snippets_init.lua: スニペットチューザーのセットアップ
-- snippets.lua（共通）と snippets_local.lua（ローカル）が読み込まれた後に実行する

local launcher = require("modules.command_launcher")
local snippets = require("modules.snippets")

-- hs.chooser の choices テーブルに関数を入れると ObjC ブリッジで変換できず
-- エントリが消えるため、関数は別マップで管理する
local bodyMap = {}
local choices = {}
for _, s in ipairs(snippets.list) do
  bodyMap[s.title] = s.body
  table.insert(choices, { text = s.title })
end

local chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local body = bodyMap[choice.text]
  if type(body) == "function" then body = body() end
  hs.pasteboard.setContents(body)
  hs.eventtap.keyStroke({"cmd"}, "v")
end)

chooser:choices(choices)
chooser:placeholderText("Search snippets...")

hs.hotkey.bind(launcher.mods, "w", function()
  chooser:show()
end)
