-- modules/search.lua: 検索ランチャー

local clipboard = require("modules.clipboard")

local appDirs = {
  "/Applications",
  "/System/Applications",
  "/System/Applications/Utilities",
  os.getenv("HOME") .. "/Applications",
}

local chooser = nil
local appCache = nil

-- アプリ一覧を取得
local function getApps()
  if appCache then return appCache end

  local apps = {}
  local seen = {}

  for _, dir in ipairs(appDirs) do
    local iter, dirObj = hs.fs.dir(dir)
    if iter then
      for file in iter, dirObj do
        if file:sub(-4) == ".app" and not seen[file] then
          seen[file] = true
          local name = file:sub(1, -5)
          local path = dir .. "/" .. file
          local icon = hs.image.iconForFile(path)
          table.insert(apps, {
            text = name,
            subText = path,
            path = path,
            image = icon,
          })
        end
      end
    end
  end

  table.sort(apps, function(a, b) return a.text:lower() < b.text:lower() end)

  -- クリップボード履歴を先頭に特別エントリとして追加
  table.insert(apps, 1, {
    text = "Clipboard History",
    subText = "Show clipboard history (Cmd+Shift+V)",
    action = "clipboard",
  })

  appCache = apps
  return apps
end

chooser = hs.chooser.new(function(choice)
  if not choice then return end

  if choice.action == "clipboard" then
    -- 少し遅延させてchooserが閉じてから開く
    hs.timer.doAfter(0.1, function()
      clipboard.show()
    end)
    return
  end

  if choice.path then
    hs.execute('open "' .. choice.path .. '"')
  end
end)

chooser:placeholderText("Search apps...")

-- Cmd+Space: 検索ランチャー表示
hs.hotkey.bind({"cmd"}, "space", function()
  -- キャッシュをリフレッシュ（新規インストール対応）
  appCache = nil
  chooser:choices(getApps())
  chooser:show()
end)
