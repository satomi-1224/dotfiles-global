-- modules/app_switcher.lua: アプリ/ウィンドウ切替

local alt = {"alt"}

-- Alt+F: 次のアプリのウィンドウにフォーカス
local appSwitcherIndex = 0
local appSwitcherApps = {}
local appSwitcherTimer = nil

local function buildAppList()
  local wins = hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast)
  if not wins then return nil end

  local seen = {}
  local appList = {}
  for _, win in ipairs(wins) do
    local winId = win:id()
    if winId then
      local app = win:application()
      if app then
        local bid = app:bundleID()
        if bid and not seen[bid] then
          seen[bid] = true
          table.insert(appList, { bundleID = bid, window = win })
        end
      end
    end
  end

  if #appList < 2 then return nil end
  return appList
end

hs.hotkey.bind(alt, "f", function()
  if #appSwitcherApps == 0 then
    local appList = buildAppList()
    if not appList then return end
    appSwitcherApps = appList
    appSwitcherIndex = 1
  end

  appSwitcherIndex = (appSwitcherIndex % #appSwitcherApps) + 1
  appSwitcherApps[appSwitcherIndex].window:focus()

  if appSwitcherTimer then appSwitcherTimer:stop() end
  appSwitcherTimer = hs.timer.doAfter(1.5, function()
    appSwitcherIndex = 0
    appSwitcherApps = {}
  end)
end)

-- Alt+D: 同一アプリの次のウィンドウにフォーカス
hs.hotkey.bind(alt, "d", function()
  local app = hs.application.frontmostApplication()
  if not app then return end

  local wins = app:allWindows()
  local standardWins = {}
  for _, w in ipairs(wins) do
    if w:isStandard() then
      table.insert(standardWins, w)
    end
  end

  if #standardWins < 2 then return end

  local focused = hs.window.focusedWindow()
  for i, w in ipairs(standardWins) do
    if w:id() == focused:id() then
      local next = standardWins[(i % #standardWins) + 1]
      next:focus()
      return
    end
  end
end)
