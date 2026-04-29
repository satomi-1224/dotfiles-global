-- lua/config/options.lua
-- Neovim本体の設定（プラグインに依存しない）
-- ここで設定する項目はすべてNeovimの組み込み機能

local opt = vim.opt

-- netrwを無効化（oilに置き換えるため）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 透過（Neovide使用時）
vim.g.neovide_transparency = 0.8

-- リーダーキー
-- スペースキーをリーダーキーに設定する
-- リーダーキーはカスタムキーマップの起点となるキー（例: <leader>ff でファイル検索）
-- lazy.nvimが読み込まれるより前に設定する必要がある
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 行番号
-- number: 左端に行番号を表示する（現在行は絶対行番号）
-- relativenumber: 現在行からの相対的な行番号を表示する
-- 両方trueにすると、現在行だけ絶対番号、他は相対番号のハイブリッド表示になる
-- 相対番号は「5j」（5行下に移動）のような移動コマンドで便利
opt.number = true
opt.relativenumber = true

-- インデント
-- tabstop: ファイル中のタブ文字を何文字幅で表示するか
-- shiftwidth: >>や<<によるインデント操作で増減する文字数
-- expandtab: Tabキーを押した時にタブ文字ではなくスペースを挿入する
-- smartindent: 新しい行を開いた時に、前の行の構文に基づいて自動でインデントを調整する
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- 検索
-- ignorecase: 検索時に大文字と小文字を区別しない（「hello」で「Hello」もヒット）
-- smartcase: 検索パターンに大文字が含まれる場合だけ大文字小文字を区別する
--   例: 「hello」→ 大文字小文字無視、「Hello」→ 大文字小文字を区別
-- hlsearch: 検索結果に一致したすべてのテキストをハイライト表示する
-- incsearch: 検索文字を入力するたびにリアルタイムで一致箇所を表示する
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 表示
-- termguicolors: ターミナルで24bit（約1600万色）のフルカラー表示を有効にする
--   これがないとカラースキームが正しく表示されない
-- signcolumn: 行番号の左にあるサイン列を常に表示する
--   git差分マーク（+/-）やLSPの警告・エラーマークが表示される領域
--   "yes"で常時表示にすると、マークの出現時に画面がガタつかない
-- cursorline: カーソルがある行の背景色を変えてハイライトする
-- wrap: 画面幅を超える長い行を折り返さない（横スクロールで表示する）
-- scrolloff: カーソルが画面端から何行以内に来たらスクロールを始めるか
--   8に設定すると、常にカーソルの上下に8行の余白が確保される
-- sidescrolloff: 横方向のscrolloff（wrap=false時に効果がある）
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- ファイル
-- swapfile: 編集中の一時ファイル（.swp）を作らない
--   スワップファイルはクラッシュ時の復旧用だが、undofileがあれば不要
-- backup: 保存前のバックアップファイル（~）を作らない
-- undofile: アンドゥ履歴をファイルに永続保存する
--   Neovimを閉じて再度開いても、u（アンドゥ）で以前の編集を元に戻せる
-- autoread: ファイルがNeovimの外部（Claude Code、git等）で変更された時に自動で再読み込みする
--   autocmds.luaのchecktime自動コマンドと組み合わせて動作する
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.autoread = true

-- ウィンドウ分割
-- splitbelow: :splitで水平分割した時に、新しいウィンドウを下側に開く（デフォルトは上）
-- splitright: :vsplitで垂直分割した時に、新しいウィンドウを右側に開く（デフォルトは左）
opt.splitbelow = true
opt.splitright = true

-- その他
-- mouse: すべてのモード（ノーマル、インサート、ビジュアル等）でマウス操作を有効にする
-- clipboard: Neovimのヤンク（コピー）をシステムのクリップボードと共有する
--   yでコピーした内容を他のアプリにCtrl+Vで貼り付けられる
-- updatetime: CursorHoldイベントが発火するまでの待機時間（ミリ秒）
--   カーソルを止めて250ms後にファイル変更チェック等が実行される
-- timeoutlen: キーマップのシーケンス入力を待つ時間（ミリ秒）
--   例: <leader>fの後、300ms以内に次のキーを押す必要がある
-- completeopt: 補完メニューの動作設定
--   menu: 補完候補をポップアップメニューで表示
--   menuone: 候補が1つしかなくてもメニューを表示
--   noselect: メニュー表示時に候補を自動で選択しない（自分で選ぶ）
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noselect"
