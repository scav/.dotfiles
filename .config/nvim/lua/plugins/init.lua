local Plugins = {
    { 'wellle/targets.vim' },
    { 'tpope/vim-repeat' },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'numToStr/Comment.nvim',       config = true, event = 'VeryLazy' },

    -- Themes
    { 'folke/tokyonight.nvim' },
    --  {'joshdick/onedark.vim'},
    --  {'tanvirtin/monokai.nvim'},
    --  {'lunarvim/darkplus.nvim'},
    --  { 'rose-pine/neovim',               name = 'rose-pine' },
    --  { 'scottmckendry/cyberdream.nvim' },
    --  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 }
    --  { 'rmehri01/onenord.nvim' },

    -- LuaRocks
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
    }
}

return Plugins
