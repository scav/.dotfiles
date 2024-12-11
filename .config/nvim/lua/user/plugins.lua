local lazy = {}

function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    if vim.g.plugins_ready then
        return
    end

    -- You can "comment out" the line below after lazy.nvim is installed
    -- lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)

    require('lazy').setup(plugins, lazy.opts)
    vim.g.plugins_ready = true
end

-- Lazy show menu
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {
    performance = {
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
                "tutor",
            },
        },
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = {
            width = 0.6,
            height = 0.8,
        },
        border = 'none',
    },
}

lazy.setup({ { import = 'plugins' } })
