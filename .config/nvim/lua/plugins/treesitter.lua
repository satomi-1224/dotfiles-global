-- lua/plugins/treesitter.lua
-- シンタックスハイライト: nvim-treesitter/nvim-treesitter
--
-- Treesitterはソースコードを構文木（AST）として解析する
-- 正規表現ベースの従来のハイライトと違い、コードの構造を理解した上で
-- 「変数」「関数名」「引数」「型」などを正確に区別して色分けする
--
-- ハイライト以外にも以下の機能の基盤となる:
--   - 正確なインデント計算
--   - テキストオブジェクト（関数単位・クラス単位での選択）
--   - 折りたたみ（foldexpr）
--
-- 注意: Treesitterエンジン自体はNeovim 0.10+に内蔵されている
-- このプラグインの主な役割は「各言語のパーサーの自動ダウンロードと管理」

return {
  "nvim-treesitter/nvim-treesitter",
  -- :TSUpdate でパーサーのバイナリをビルドする（プラグイン更新時に自動実行）
  build = ":TSUpdate",
  -- ファイルを開いた時に読み込む（起動時には読み込まない）
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- ensure_installed: 初回起動時に自動でダウンロード・ビルドするパーサーの一覧
      -- パーサー = 各言語の文法を解析するためのバイナリ
      ensure_installed = {
        "php",             -- PHP
        "python",          -- Python
        "lua",             -- Lua（Neovim設定ファイル用）
        "html",            -- HTML
        "css",             -- CSS
        "javascript",      -- JavaScript
        "json",            -- JSON（設定ファイル等）
        "yaml",            -- YAML（設定ファイル等）
        "toml",            -- TOML（設定ファイル等）
        "markdown",        -- Markdown（文章執筆用）
        "markdown_inline", -- Markdownのインライン要素（コードスパン等）
        "bash",            -- シェルスクリプト
        "vim",             -- Vimscript
        "vimdoc",          -- Vimのヘルプファイル
        "blade",           -- Laravel Bladeテンプレート
      },

      -- auto_install: ensure_installedに含まれていない言語のファイルを開いた時に
      -- パーサーが未インストールであれば自動でダウンロード・ビルドする
      auto_install = true,

      -- highlight: Treesitterベースのシンタックスハイライトを有効にする
      -- これにより従来の正規表現ハイライトより正確な色分けになる
      highlight = {
        enable = true,
      },

      -- indent: Treesitterの構文解析を使った自動インデントを有効にする
      -- 新しい行を開いた時のインデント量がより正確になる
      indent = {
        enable = true,
      },
    })
  end,
}
