local Plugin = {'nvim-telescope/telescope.nvim'}

Plugin.branch = '0.1.x'

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'gmake'},
   { 'nvim-telescope/telescope-ui-select.nvim' }
}

Plugin.cmd = {'Telescope'}

function Plugin.init()
    vim.keymap.set('n', '<leader>ff', '<CMD>Telescope find_files<CR>', { desc = "Find files" })
    vim.keymap.set('n', '<leader>fg', '<CMD>Telescope live_grep<CR>', { desc = "Grep files" })
    vim.keymap.set('n', '<leader>fb', '<CMD>Telescope buffers<CR>', { desc = "Find buffer" })
    vim.keymap.set('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', { desc = "Find helptags" })
    vim.keymap.set('n', '<leader>fc', '<CMD>Telescope git_files<CR>', { desc = "Find git files" })
end

function Plugin.config()
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('ui-select')
end

return Plugin
