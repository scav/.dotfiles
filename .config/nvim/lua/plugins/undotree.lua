local Plugin = { 'mbbill/undotree' }


function Plugin.config()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })

    -- Configuration
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true
end

return Plugin
