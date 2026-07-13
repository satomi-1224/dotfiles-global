-- lua/plugins/power-finder.lua
-- 自作プラグイン: IDE級のプロジェクト検索・一括置換
--
-- Zed / IntelliJ の "Find in Files / Find in Path" 相当の検索UIをNeovimで実現する。
-- fzf-lua の live_grep が「単一プロンプトで素早く探す」ためのものなのに対し、
-- power-finder は「条件をフォームで組み立てて、diffを確認しながら一括置換する」
-- ための重量級ツール。用途で使い分ける。
--
-- 主な機能:
--   - 一体型パネル: 上部に検索条件フォーム、下部に結果を表示するフローティングウィンドウ
--   - ライブ検索: 入力のたびにripgrepを再実行して結果を即時更新（デバウンス付き）
--   - 正規表現/リテラル・大文字小文字・単語単位のトグル切替
--   - Include/Exclude glob と検索スコープ（プロジェクト/cwd/バッファ/任意パス）
--   - 一括置換: 置換後のdiffをファイル単位で確認し、選んだものだけ安全に適用
--   - quickfix連携: 検索結果をquickfixへ送って既存ワークフローへ橋渡し
--
-- 外部依存:
--   - ripgrep(rg): 検索エンジン（システムにインストール済み）
--   - fzf-lua: スコープの「任意パス」選択などの補助picker（任意）
--
-- キーマップ（<leader> はスペース）:
--   <leader>fg : パネルを開く（Find in Files。従来fzf-luaのlive_grepだった枠を引き継ぐ）
--   <leader>fg (ビジュアル) : 選択範囲を検索語として開く
--   <leader>sw : カーソル下の単語で開く
-- ※ 従来 fzf-lua の live_grep が <leader>fg だったが、それを置き換える形で割り当てた。

return {
  "satomi-1224/power-finder.nvim",
  -- fzf-lua: スコープ/パス選択の補助pickerに使う（無くても動作する）
  dependencies = { "ibhagwan/fzf-lua" },
  -- cmd: :PowerFinder系コマンドが実行された時に初めて読み込む（遅延読み込み）
  cmd = { "PowerFinder", "PowerFinderCword" },
  -- keys: 以下のキーが押された時にも読み込む
  keys = {
    { "<leader>fg", "<cmd>PowerFinder<cr>", desc = "検索・一括置換（Find in Files）" },
    { "<leader>sw", "<cmd>PowerFinderCword<cr>", desc = "カーソル下の単語で検索" },
    {
      "<leader>fg",
      function()
        require("power-finder").open_visual()
      end,
      mode = "v",
      desc = "選択範囲を検索",
    },
  },
  -- opts があると lazy が require("power-finder").setup(opts) を呼ぶ。
  -- キーマップは上の keys で定義するため、プラグイン側のデフォルトマップ(<leader>sf)は無効化する。
  opts = {
    keymap = false,
  },
}
