-- lua/plugins/blink-cmp.lua
-- 補完エンジン: saghen/blink.cmp
--
-- 入力中に補完候補をポップアップ表示するプラグイン
-- LSPが提供する補完候補をはじめ、以下のソースから候補を収集して表示する:
--   - lsp: 言語サーバーからの補完（関数名、変数名、メソッド等）
--   - path: ファイルパスの補完（/home/... のように入力すると候補が出る）
--   - snippets: コードスニペットの補完（for → forループの雛形等）
--   - buffer: 現在開いているバッファ内の単語から補完
--
-- 操作方法:
--   Ctrl+n: 次の候補を選択
--   Ctrl+p: 前の候補を選択
--   Ctrl+y: 選択した候補を確定（Vim標準の補完と同じ操作感）
--   Ctrl+Space: 補完メニューを手動で表示
--   Ctrl+e: 補完メニューを閉じる

return {
  "saghen/blink.cmp",
  -- version: 安定版（v1系）を使用する
  -- v2は開発中で破壊的変更が多いため、v1を指定して安定性を確保する
  version = "1.*",
  -- event: インサートモードに入った時に初めて読み込む（遅延読み込み）
  -- ノーマルモードでは補完は不要なので、必要になるまで読み込まない
  event = "InsertEnter",
  dependencies = {
    -- friendly-snippets: 多数の言語に対応したスニペット集
    -- for, if, function 等のよく使う構文の雛形が含まれている
    "rafamadriz/friendly-snippets",
  },
  opts = {
    -- keymap: 補完操作のキーマップ設定
    -- "default"プリセット: Ctrl+y で確定（Vim標準の補完と同じ操作感）
    keymap = { preset = "default" },

    -- sources: 補完候補の取得元と優先順位
    -- リストの上にあるものほど候補の表示順が高くなる
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- completion: 補完メニューの動作設定
    completion = {
      -- documentation: 候補を選択した時にドキュメント（関数の説明等）を表示する
      documentation = {
        -- auto_show: ドキュメントを自動で表示する
        auto_show = true,
        -- auto_show_delay_ms: ドキュメント表示までの待機時間（ミリ秒）
        -- 候補を素早く上下移動する時にドキュメントがちらつくのを防ぐ
        auto_show_delay_ms = 200,
      },
      -- accept: 候補確定時の動作
      accept = {
        -- auto_brackets: 関数名を補完した時に自動で括弧()を挿入する
        auto_brackets = { enabled = true },
      },
    },

    -- appearance: 表示設定
    appearance = {
      -- nerd_font_variant: Nerd Fontのアイコン種別
      -- "mono"はNerd Font Mono用（固定幅フォント向け）
      nerd_font_variant = "mono",
    },

    -- fuzzy: あいまいマッチングの実装
    -- "lua": Lua実装を使用する（Rustのビルド環境が不要でシンプル）
    -- "prefer_rust_with_warning"にするとRust実装が使われ高速になるが、
    -- Rustのビルド環境が必要になる
    fuzzy = {
      implementation = "lua",
    },
  },
}
