-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Leader + 上下左右 でウィンドウサイズを変更
vim.keymap.set("n", "<Leader><Up>", ":resize -2<CR>")
vim.keymap.set("n", "<Leader><Down>", ":resize +2<CR>")
vim.keymap.set("n", "<Leader><Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<Leader><Right>", ":vertical resize +2<CR>")
