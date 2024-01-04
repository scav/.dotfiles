local Plugin = { 'tpope/vim-fugitive' }

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gb", ":G blame<CR>")

return Plugin
