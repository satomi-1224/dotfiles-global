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
  -- nvim-web-devicons: ファイル種別に応じたアイコンを表示する
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- keys: 「-」が押された時に初めて読み込む（遅延読み込み）
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "ファイラーを開く（現在のファイルの親ディレクトリ）" },
    { "e", "<cmd>Oil<cr>", desc = "ファイラーを開く" },
  },
  opts = {
    -- columns: ファイル一覧に表示する列
    -- "icon"のみ表示（パーミッションやファイルサイズは非表示にして簡素にする）
    columns = {
      "icon",
    },
    -- view_options: 表示オプション
    view_options = {
      -- show_hidden: ドットファイル（.gitignore等）を表示する
      show_hidden = true,
    },
  },
}
