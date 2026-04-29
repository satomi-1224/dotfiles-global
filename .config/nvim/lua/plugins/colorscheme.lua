-- lua/plugins/colorscheme.lua
-- カラースキーム: calind/selenized.nvim
-- Selenizedは可読性とコントラストを重視して設計されたカラーパレット
-- dark/light両対応（:set background=light で切替可能）

return {
  "calind/selenized.nvim",
  -- lazy=false: 起動時に即座に読み込む（遅延読み込みしない）
  --   カラースキームは画面表示の最初から必要なので、遅延できない
  lazy = false,
  -- priority=1000: 他のすべてのプラグインより先に読み込む
  --   他のプラグインのUI要素が正しい色で表示されるようにするため
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("selenized")
    -- ターミナルの透過を活かすためにbgをNONEにする
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end,
}
