-- Disable annoying things I don't want or need
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

local opt = vim.opt

-- Editor
opt.guicursor = ""

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
--opt.lazyredraw = true
--opt.colorcolumn = "80"

