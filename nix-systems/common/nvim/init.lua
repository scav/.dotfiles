-- hide startup screen
vim.opt.shortmess:append("I")
vim.g.mapleader = " "

LZN = require("lz.n")
LZN.load("plugins")

require("config.editor")
require("config.undo")
require("user.terminal")
require("user.treesitter")

-- Theme config
vim.cmd([[colorscheme tokyonight-storm]])
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FB508F", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#51B3EC", bold = true })

-- attach all enabled LSP-servers here (nvim-lspconfig will add defaults and merge them with after/lsp/*.lua
vim.lsp.enable({
    "lua_ls",
    "nil_ls",
    "rust_analyzer",
    "gopls",
    "docker_language_server",
    "yamlls",
    "templ",
    "tailwindcss",
})
