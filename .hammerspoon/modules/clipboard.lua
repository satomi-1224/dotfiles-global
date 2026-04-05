-- modules/clipboard.lua: クリップボード履歴

local M = {}

local MAX_HISTORY = 50
local POLL_INTERVAL = 0.8
local SETTINGS_KEY = "clipboard_history"

local history = {}
local lastChange = hs.pasteboard.changeCount()
local chooser = nil
local timer = nil

-- 履歴を hs.settings から読み込み
local function loadHistory()
  local saved = hs.settings.get(SETTINGS_KEY)
  if saved and type(saved) == "table" then
    history = saved
  end
end

-- 履歴を hs.settings に保存
local function saveHistory()
  hs.settings.set(SETTINGS_KEY, history)
end

-- クリップボードを監視して履歴に追加
local function pollClipboard()
  local currentChange = hs.pasteboard.changeCount()
  if currentChange == lastChange then return end
  lastChange = currentChange

  local content = hs.pasteboard.getContents()
  if not content or content == "" then return end

  -- 重複排除: 既存の同一内容を削除
  for i = #history, 1, -1 do
    if history[i] == content then
      table.remove(history, i)
    end
  end

  -- 先頭に追加
  table.insert(history, 1, content)

  -- 最大件数を超えたら削除
  while #history > MAX_HISTORY do
    table.remove(history)
  end

  saveHistory()
end

-- chooser用の選択肢を生成
local function buildChoices()
  local choices = {}
  for i, item in ipairs(history) do
    local display = item:gsub("\n", " "):sub(1, 80)
    table.insert(choices, {
      text = display,
      subText = "#" .. i .. " (" .. #item .. " chars)",
      index = i,
    })
  end
  return choices
end

-- chooser作成
chooser = hs.chooser.new(function(choice)
  if not choice then return end
  local content = history[choice.index]
  if not content then return end

  -- クリップボードにセットしてペースト
  hs.pasteboard.setContents(content)
  lastChange = hs.pasteboard.changeCount()
  hs.eventtap.keyStroke({"cmd"}, "v")
end)

chooser:placeholderText("Search clipboard history...")

function M.show()
  chooser:choices(buildChoices())
  chooser:show()
end

-- Cmd+Shift+V: クリップボード履歴表示
hs.hotkey.bind({"cmd", "shift"}, "v", function()
  M.show()
end)

-- 初期化
loadHistory()
timer = hs.timer.doEvery(POLL_INTERVAL, pollClipboard)

return M
