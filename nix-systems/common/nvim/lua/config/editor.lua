local opt = vim.opt

-- Editor
opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.wrap = false

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 20
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
opt.hidden = true
opt.history = 200

-- Adds the "limit" bar on width
-- opt.colorcolumn = "80"
--
opt.conceallevel = 2

-- Spell
vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }

-- UI
opt.winborder = "rounded"
opt.updatetime = 750

-- Move lines or blocks of lines up and down
-- Stand on first line, press "V" then "j" or "k" for up or down
-- Then move selection using "J" or "K"
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- Cursor stay in place when using J
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Cycle through open buffers with Space + Tab
vim.keymap.set('n', '<leader><Tab>', ':bnext<CR>', { noremap = true })

-- Save shortcut
vim.keymap.set({ 'n', 'i' }, '<C-S>', ':update<CR>')

-- Disable annoying things I don't want or need
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
