-- lua/plugins/treesitter.lua
-- nvim-treesitter (main ブランチ / rewrite 版) の設定
--
-- master ブランチ用の従来 API (require("nvim-treesitter.configs").setup) は
-- main ブランチでは廃止されており、以下の新 API を使う必要がある。
--   - パーサー導入: require("nvim-treesitter").install({ ... })
--   - ハイライト: FileType autocmd で vim.treesitter.start()
--   - インデント: ftplugin or FileType autocmd で indentexpr を設定
--   - lazy-loading 非対応 (lazy = false 必須)

local parsers = {
  "php",
  "python",
  "lua",
  "html",
  "css",
  "javascript",
  "json",
  "yaml",
  "toml",
  "markdown",
  "markdown_inline",
  "bash",
  "vim",
  "vimdoc",
  "blade",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
