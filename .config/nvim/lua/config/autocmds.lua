-- lua/config/autocmds.lua
-- 自動コマンド（autocmd）の設定（プラグインに依存しない）
-- autocmdは「特定のイベントが起きた時に自動で実行される処理」
--
-- augroup: autocmdをグループ化する（clear=trueで再読み込み時に重複登録を防ぐ）
-- autocmd: イベントと実行する処理を紐づける

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 外部でファイルが変更された時に自動で再読み込みする
-- Claude Codeやgitなどで編集した変更がNeovimにリアルタイムで反映される
--
-- 仕組み:
--   options.luaの autoread=true と組み合わせて動作する
--   autoreadだけではNeovimにフォーカスが戻った時しかチェックしない
--   以下のイベントでchecktime（ファイル変更チェック）を積極的に実行する:
--     FocusGained: ターミナルやウィンドウにフォーカスが戻った時
--     BufEnter: バッファを切り替えた時
--     CursorHold: カーソルを止めてupdatime（250ms）経過した時（ノーマルモード）
--     CursorHoldI: 同上（インサートモード）
augroup("auto_reload", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = "auto_reload",
  callback = function()
    -- コマンドラインウィンドウ（q:で開くもの）の中ではchecktimeを実行しない
    -- コマンドラインウィンドウ内で実行するとエラーになるため
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- ファイルが外部変更により再読み込みされた時に通知を表示する
-- FileChangedShellPost: checktimeでファイルの再読み込みが実際に行われた後に発火する
autocmd("FileChangedShellPost", {
  group = "auto_reload",
  callback = function()
    vim.notify("ファイルが外部で変更されたため再読み込みしました", vim.log.levels.INFO)
  end,
})
