-- modules/snippets.lua: スニペット管理（共通定義）
-- snippets_local.lua でローカルスニペットを追加後、
-- snippets_init.lua でチューザーをセットアップする

local M = {}

M.list = {
  { title = "now", body = function() return os.date("%Y-%m-%d") end },
}

return M
