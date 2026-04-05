return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
    },
    filesystem = {
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
        hide_gitignored = false, -- trueだと隠れる。falseで表示される。
        hide_dotfiles = false, -- (任意) ドットファイル(.envなど)も常に見たい場合はここもfalse
      },
    },
  },
}
