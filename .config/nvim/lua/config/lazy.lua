-- lua/config/lazy.lua
-- lazy.nvimのブートストラップ（自動インストール）と設定
-- lazy.nvimはNeovimのプラグインマネージャ
-- プラグインのインストール・更新・遅延読み込みを管理する

-- lazy.nvimがまだインストールされていなければ、GitHubからクローンして自動インストールする
-- vim.fn.stdpath("data") は ~/.local/share/nvim を指す
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", -- blobを除外してクローンを高速化
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",    -- 安定版ブランチを使用
    lazypath,
  })
end
-- ランタイムパスの先頭にlazy.nvimを追加して、require("lazy")で読み込めるようにする
vim.opt.rtp:prepend(lazypath)

-- "plugins" を指定すると lua/plugins/ ディレクトリ内の全.luaファイルを
-- プラグイン定義として自動で読み込む
-- 新しいプラグインを追加するには lua/plugins/ にファイルを1つ追加するだけでよい
require("lazy").setup("plugins", {
  -- プラグインの設定ファイルが変更された時の挙動
  change_detection = {
    -- 変更検知の通知を無効化（手動で :Lazy sync を実行して反映する）
    notify = false,
  },
})
