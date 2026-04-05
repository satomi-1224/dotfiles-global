return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")

    -- Masonで入れたphp-debug-adapterをアダプターとして登録
    if not dap.adapters.php then
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
      }
    end

    -- .vscode/launch.json を読み込む設定
    -- 第2引数で、json内の "type": "php" を nvim-dapの "php" アダプターに紐付けます
    require("dap.ext.vscode").load_launchjs(".vscode/launch.vim.json", { php = { "php" } })
  end,
}
