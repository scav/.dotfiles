-- Basic remaps Other plugins have their remaps in their perspective folders

vim.g.mapleader = " "

-- Lazy show menu
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")

-- Move lines or blocks of lines up and down
-- Stand on first line, press "V" then "j" or "k" for up or down
-- Then move selection using "J" or "K"
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- Cursor stay in place when using J
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

--vim.keymap.set("x", "<leader>p", "\"_dP")

-- Cycle through open buffers with Space + Tab
vim.keymap.set('n', '<leader><Tab>', ':bnext<CR>', { noremap = true })

-- :wq has to be sync
-- vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]

-- Save shortcut
vim.keymap.set({ 'n', 'i' }, '<C-S>', ':w<CR>')
