-- lua/plugins/yank-as-codeblock.lua
-- ビジュアル選択範囲をMarkdownコードブロックとしてクリップボードにコピーする
--
-- 出力形式:
--   {filepath}:{line-numbers}
--   ```{language}
--   {code}
--   ```

return {
  "satomi-1224/yank-as-codeblock.nvim",
  keys = {
    { "<leader>yc", "<cmd>YankAsCodeBlock<cr>", mode = "v", desc = "コードブロックとしてコピー" },
  },
}
