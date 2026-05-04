-- lua/plugins/gitsigns.lua
-- Git 差分表示: lewis6991/gitsigns.nvim
--
-- サインカラム（行番号の左端）に git の変更状態を表示する:
--   │ (add/change) … 追加・変更された行
--   _ / ‾         … 削除された行の上端・下端
--
-- hunk（連続した変更のかたまり）単位で操作できる:
--   ]h / [h          … 次 / 前の hunk へ移動
--   <leader>hs       … hunk をステージ（ビジュアル選択範囲も可）
--   <leader>hr       … hunk をリセット（ビジュアル選択範囲も可）
--   <leader>hd       … カーソル行の diff を表示
--   <leader>hb       … カーソル行の git blame を表示

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("n", "]h", gs.next_hunk, "次の hunk へ")
      map("n", "[h", gs.prev_hunk, "前の hunk へ")
      map("n", "<leader>hs", gs.stage_hunk, "hunk をステージ")
      map("n", "<leader>hr", gs.reset_hunk, "hunk をリセット")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "選択範囲をステージ")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "選択範囲をリセット")
      map("n", "<leader>hd", gs.diffthis, "diff を表示")
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "行の blame を表示")
    end,
  },
}
