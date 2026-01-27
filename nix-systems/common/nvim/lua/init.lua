-- set leader before loading lazy
-- vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

require("config.editor")
require("config.lazy")
require("config.undo")
require("user.terminal")
require("user.treesitter")

vim.cmd [[colorscheme tokyonight-storm]]

-- temperarily override for line numbers
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FB508F", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#51B3EC", bold = true })

-- attach all enabled LSP-servers here (nvim-lspconfig will add defaults and merge them with after/lsp/*.lua
vim.lsp.enable({
    'lua_ls',
    'nil_ls',
    'rust_analyzer',
    'gopls',
    'docker_language_server',
    'yamlls',
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "c", "lua", "vim", "go", "rust", "nix", "markdown", "yaml" },
--     callback = function()
--         vim.treesitter.start()
--     end,
-- })
