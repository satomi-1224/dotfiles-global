-- lua/plugins/fzf-lua.lua
-- ファジーファインダー: ibhagwan/fzf-lua
--
-- ファジーファインダー = あいまい検索でファイルやテキストを素早く見つけるツール
-- 「ファイル名の一部」や「コード内の文字列」を入力すると、一致する候補を即座に絞り込む
--
-- 主な用途:
--   - ファイル検索: プロジェクト内のファイルを名前で検索して開く
--   - テキスト検索（grep）: プロジェクト全体からテキストを検索する
--   - バッファ切替: 開いているファイル一覧から選んで切り替える
--   - LSPシンボル検索: 関数名やクラス名で検索してジャンプする
--   - Gitステータス: 変更のあるファイル一覧を表示する
--
-- 外部依存:
--   - fzf: あいまい検索のコアエンジン（システムにインストールが必要）
--   - ripgrep(rg): 高速なテキスト検索ツール（live_grepで使用）

return {
  "ibhagwan/fzf-lua",
  -- nvim-web-devicons: ファイル種別に応じたアイコンを表示する（任意だが見やすくなる）
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- cmd: FzfLuaコマンドが実行された時に初めて読み込む（遅延読み込み）
  cmd = "FzfLua",
  -- keys: 以下のキーマップが押された時にも読み込む
  -- <leader> はスペースキー（options.luaで設定済み）
  keys = {
    -- ファイル検索
    -- <leader>ff: プロジェクト内の全ファイルから名前であいまい検索する
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "ファイル検索" },
    -- <leader>fr: 最近開いたファイルの履歴からあいまい検索する
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "最近開いたファイル" },

    -- テキスト検索
    -- <leader>fg: プロジェクト全体のファイル内容をリアルタイムにgrep検索する
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "テキスト検索（grep）" },
    -- <leader>fw: カーソル下の単語をプロジェクト全体から検索する
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "カーソル下の単語を検索" },

    -- バッファ
    -- <leader>fb: 現在開いている全バッファの一覧を表示して切り替える
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "バッファ一覧" },

    -- ヘルプ
    -- <leader>fh: Neovimのヘルプドキュメントをあいまい検索する
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "ヘルプ検索" },

    -- Git
    -- <leader>gc: Gitのコミット履歴を一覧表示する
    { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Gitコミット履歴" },
    -- <leader>gs: Gitで変更のあるファイル一覧を表示する（git statusの内容）
    { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Gitステータス" },

    -- 診断（LSP設定後に活きるキーマップ）
    -- <leader>fd: 現在のファイル内のLSP診断（エラー・警告）を一覧表示する
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "診断（現在のファイル）" },
  },
  opts = {
    winopts = {
      -- height/width: ファインダーウィンドウのサイズ（画面に対する割合）
      height = 0.85,
      width = 0.80,
      preview = {
        -- layout="flex": ウィンドウ幅に応じてプレビューの位置を自動切替する
        -- 幅が広ければ右側、狭ければ下側にプレビューが表示される
        layout = "flex",
      },
    },
  },
}
