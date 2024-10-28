local Plugin = { 'williamboman/mason.nvim' }

Plugin.lazy = false

-- See :help mason-settings
Plugin.opts = {
    ui = { border = 'rounded' }
}

-- Lazy show menu
vim.keymap.set("n", "<leader>m", ":Mason<CR>")
return Plugin
