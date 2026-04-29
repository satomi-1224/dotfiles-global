-- lua/plugins/lsp.lua
-- LSP（Language Server Protocol）設定
--
-- LSPとは: エディタと言語サーバー間の通信プロトコル
-- 言語サーバーがコードを解析し、以下の機能を提供する:
--   - 補完候補の提供（blink.cmpが受け取って表示する）
--   - 定義・参照・実装へのジャンプ
--   - エラー・警告の診断表示
--   - リネーム（プロジェクト全体で変数名等を一括変更）
--   - コードアクション（自動修正の提案）
--   - ホバー情報（カーソル下のシンボルの型や説明を表示）
--
-- 3つのプラグインで構成:
--   1. mason.nvim: 言語サーバーのインストール・管理（パッケージマネージャのようなもの）
--   2. mason-lspconfig.nvim: masonとlspconfigを連携させる橋渡し
--   3. nvim-lspconfig: 各言語サーバーの設定を簡潔に書くためのヘルパー

return {
  -- mason.nvim: 言語サーバー・フォーマッター・リンターのインストーラー
  -- :Mason コマンドでUIを開き、インストール状況の確認・管理ができる
  {
    "williamboman/mason.nvim",
    -- cmd: :Masonコマンドが実行された時に読み込む
    cmd = "Mason",
    -- opts={}: デフォルト設定で初期化する（setup()が自動で呼ばれる）
    opts = {},
  },

  -- mason-lspconfig.nvim: masonとlspconfigの橋渡し
  -- ensure_installedに指定した言語サーバーをmason経由で自動インストールする
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- ensure_installed: Neovim初回起動時に自動インストールする言語サーバーの一覧
      ensure_installed = {
        "intelephense", -- PHP用LSP（補完・定義ジャンプ・診断などを提供）
        "pyright",      -- Python用LSP（型チェック・補完・診断を提供）
        "lua_ls",       -- Lua用LSP（Neovim設定ファイルの編集を支援）
      },
    },
  },

  -- nvim-lspconfig: 各言語サーバーの設定
  -- 言語サーバーごとにsetup()を呼んで有効化する
  {
    "neovim/nvim-lspconfig",
    -- event: ファイルを開く直前・新規ファイル作成時に読み込む
    -- これにより、ファイルを開いた時点でLSPが起動する
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- LspAttach: 言語サーバーがバッファにアタッチ（接続）した時に発火するイベント
      -- このイベント内でキーマップを設定することで、
      -- LSPが有効なバッファでのみキーマップが動作する
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          -- event.buf: LSPがアタッチされたバッファの番号
          -- buffer=event.buf を指定して、そのバッファ限定のキーマップにする
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          -- ジャンプ系キーマップ
          -- gd: カーソル下のシンボルが定義されている場所にジャンプする
          map("gd", vim.lsp.buf.definition, "定義へジャンプ")
          -- gD: 宣言（forward declaration等）にジャンプする
          map("gD", vim.lsp.buf.declaration, "宣言へジャンプ")
          -- gr: カーソル下のシンボルが使われている全ての場所を一覧表示する
          map("gr", vim.lsp.buf.references, "参照一覧")
          -- gi: インターフェースの実装箇所にジャンプする
          map("gi", vim.lsp.buf.implementation, "実装へジャンプ")
          -- gt: 型の定義にジャンプする
          map("gt", vim.lsp.buf.type_definition, "型定義へジャンプ")

          -- 情報表示
          -- K: カーソル下のシンボルの型情報やドキュメントをフロートウィンドウで表示する
          map("K", vim.lsp.buf.hover, "ホバー情報を表示")
          -- <leader>ls: 関数の引数の型情報を表示する（関数呼び出し中に便利）
          map("<leader>ls", vim.lsp.buf.signature_help, "シグネチャヘルプ（引数の型情報）")

          -- コードアクション
          -- <leader>la: LSPが提案する自動修正（未使用importの削除等）を選択・実行する
          map("<leader>la", vim.lsp.buf.code_action, "コードアクション（自動修正の提案）")
          -- <leader>lr: カーソル下のシンボル名をプロジェクト全体で一括変更する
          map("<leader>lr", vim.lsp.buf.rename, "シンボルをリネーム")

          -- 診断（エラー・警告）
          -- <leader>ld: カーソル行の診断メッセージをフロートウィンドウで詳細表示する
          map("<leader>ld", vim.diagnostic.open_float, "診断の詳細を表示")
          -- [d / ]d: 前後の診断箇所にジャンプする
          map("[d", vim.diagnostic.goto_prev, "前の診断（エラー・警告）へ")
          map("]d", vim.diagnostic.goto_next, "次の診断（エラー・警告）へ")

          -- フォーマット
          -- <leader>lf: LSPのフォーマッターでコードを整形する
          -- async=true: フォーマット中もNeovimの操作をブロックしない
          map("<leader>lf", function()
            vim.lsp.buf.format({ async = true })
          end, "コードをフォーマット")
        end,
      })

      -- 各言語サーバーの個別設定
      -- setup({}) で言語サーバーを有効化する
      -- オプション無しの場合はデフォルト設定で起動する

      -- PHP: intelephense
      -- Laravel/Composer対応、補完・定義ジャンプ・診断を提供
      lspconfig.intelephense.setup({})

      -- Python: pyright
      -- 型チェック・補完・診断を提供（Microsoft製）
      lspconfig.pyright.setup({})

      -- Lua: lua_ls
      -- Neovimの設定ファイル（.lua）を編集する際の補完・診断を提供
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            -- checkThirdParty=false: サードパーティライブラリの確認ダイアログを無効化
            --   Neovim設定編集時に「luarocksの設定を検出しました」の通知を抑制する
            workspace = { checkThirdParty = false },
            -- telemetry: 使用状況の送信を無効化
            telemetry = { enable = false },
          },
        },
      })
    end,
  },
}
