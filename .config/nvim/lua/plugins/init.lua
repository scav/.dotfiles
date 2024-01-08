local Plugins = {
    { 'wellle/targets.vim' },
    { 'tpope/vim-repeat' },
    { 'kyazdani42/nvim-web-devicons', lazy = true },
    { 'numToStr/Comment.nvim',        config = true, event = 'VeryLazy' },

    -- Themes
    { 'folke/tokyonight.nvim' },
    --  {'joshdick/onedark.vim'},
    --  {'tanvirtin/monokai.nvim'},
    --  {'lunarvim/darkplus.nvim'},
    --  { 'rose-pine/neovim',               name = 'rose-pine' },
    --  { 'scottmckendry/cyberdream.nvim' },
    --  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 }
    { 'rmehri01/onenord.nvim' },
}

return Plugins
