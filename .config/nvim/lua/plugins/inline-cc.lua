-- lua/plugins/inline-cc.lua
-- inline-cc.nvim: Claude Code を使ったインライン編集
--
-- 選択範囲またはカーソル位置に自然言語で指示を出し、返ってきた編集候補を
-- インラインdiffで確認して hunk 単位で採用/破棄できる。
--
-- 前提:
--   - Neovim 0.10以上（vim.system を使用）
--   - `claude` CLI が PATH 上にあること（認証・モデル設定は CLI に委譲）
--
-- 主なコマンド/キーマップ（setup 後にバッファへ張られる）:
--   :InlineCC [指示]  現在行を編集 / :'<,'>InlineCC [指示]  選択範囲を編集
--   <leader>cc        編集開始（normal/visual）
--   ga / gr           hunk 採用 / 破棄
--   gA / gR           全採用 / 全破棄
--   ]h / [h           hunk 移動
--   gi                指示を言い直す
return {
  "satomi-1224/inline-cc.nvim",
  cmd = { "InlineCC", "InlineCCCancel" },  -- コマンド実行時に起動
  keys = {
    -- lazy.nvim がこのキーにスタブを張り、押下時にプラグインをロードしてから
    -- キーを再送するため、初回押下から編集開始できる
    { "<leader>cc", mode = { "n", "x" }, desc = "InlineCC 編集開始" },
  },
  opts = {},  -- デフォルト設定（require("inline-cc").setup({}) 相当）
}
