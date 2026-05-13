-- modules/snippets.lua: スニペット管理

local launcher = require("modules.command_launcher")

local snippets = {
  { title = "now", body = function() return os.date("%Y-%m-%d") end },
}

local choices = {}
for _, s in ipairs(snippets) do
  table.insert(choices, { text = s.title, body = s.body })
end

local chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local body = choice.body
  if type(body) == "function" then body = body() end
  hs.pasteboard.setContents(body)
  hs.eventtap.keyStroke({"cmd"}, "v")
end)

chooser:choices(choices)
chooser:placeholderText("Search snippets...")

hs.hotkey.bind(launcher.mods, "w", function()
  chooser:show()
end)
