-- modules/snippets.lua: スニペット管理

local launcher = require("modules.command_launcher")

local snippets = {
  { title = "now", body = function() return os.date("%Y-%m-%d") end },
}

-- hs.chooser の choices テーブルに関数を入れると ObjC ブリッジで変換できず
-- エントリが消えるため、関数は別マップで管理する
local bodyMap = {}
local choices = {}
for _, s in ipairs(snippets) do
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
