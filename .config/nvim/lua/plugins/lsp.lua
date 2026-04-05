return {
  -- LSP設定用プラグインの設定を上書き
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- ここで intelephense を使うことを明示します
      intelephense = {
        -- 必要なら設定を書きますが、基本は空でOK
        enabled = true,
      },
      -- もし phpactor が邪魔しているなら無効化（念のため）
      phpactor = {
        enabled = false,
      },
    },
  },
}
