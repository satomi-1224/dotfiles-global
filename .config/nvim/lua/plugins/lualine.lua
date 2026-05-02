-- lua/plugins/lualine.lua
-- ステータスライン: nvim-lualine/lualine.nvim
--
-- 画面下部に現在のモード (NORMAL / INSERT / VISUAL ...)、git ブランチ、
-- ファイル名、カーソル位置などを色付きで表示する。
--
-- モード表示が一目で分かるようにするのが主な目的。
-- セクション構成はデフォルトのまま (公式の推奨レイアウト)。

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- ステータスラインは起動直後から表示したいため lazy load しない。
  event = "VeryLazy",
  opts = {
    options = {
      -- カラースキーム (selenized) と整合させる。auto で colorscheme を追従する。
      theme = "auto",
      globalstatus = true,
    },
  },
}
