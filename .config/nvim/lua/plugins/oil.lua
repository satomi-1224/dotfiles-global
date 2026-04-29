-- lua/plugins/oil.lua
-- ファイラー: stevearc/oil.nvim
--
-- ディレクトリの中身を通常のテキストバッファとして表示する
-- ファイル操作をVimのテキスト編集と同じ操作で行える:
--   - ファイル名を書き換える → リネーム
--   - dd で行を削除する → ファイル削除
--   - o で新しい行を追加してファイル名を書く → ファイル作成
--   - :w で保存 → 上記の操作をすべて確定・実行
--
-- 「-」キーで現在のファイルの親ディレクトリが開く
-- もう一度「-」を押すとさらに上のディレクトリに移動する（cdの..と同じ感覚）

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- netrw代替として起動時に読み込む（遅延するとeキーが効かない）
  lazy = false,
  config = function()
    require("oil").setup({
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
    })
    vim.keymap.set("n", "e", "<cmd>Oil<cr>", { desc = "ファイラーを開く" })
  end,
}
