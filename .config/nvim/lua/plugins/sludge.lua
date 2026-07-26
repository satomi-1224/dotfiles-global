-- lua/plugins/sludge.lua
-- ファイラー: satomi-1224/sludge.nvim
--
-- 親 / 現在 / プレビューの3ペインをフローティングで重ねて表示する
-- ファイル操作は1キー1動作:
--   - d 削除 / r リネーム / n 新規作成 / m 移動待ち / c コピー待ち / p 貼り付け
--   - <space> でマークを付けると、マークした分すべてに d/m/c が効く
--   - g. で隠しファイルの表示切り替え、g? でキー一覧
--
-- 「<leader>e」で開く（プラグイン側が open_key として張る）
-- 「h」で親ディレクトリ、「l」でディレクトリに入る、「<CR>」でファイルを開く
--
-- 注意: <leader>e と `nvim <dir>` のために起動時に必ず読み込む（公式の推奨）。

return {
  "satomi-1224/sludge.nvim",
  -- nvim-web-devicons: ファイル種別に応じたアイコンを表示する（任意）
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    -- view: 一覧の表示オプション
    view = {
      -- show_hidden: ドットファイル（.gitignore等）を表示する
      show_hidden = true,
    },
  },
}
