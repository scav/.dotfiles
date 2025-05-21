return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    -- ft = "markdown",
    event = {
        "BufReadPre " .. vim.fn.expand "~" .. "/vaults/personal/*.md",
        "BufReadPre " .. vim.fn.expand "~" .. "/vault/work/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/vaults/personal",
            },
            {
                name = "work",
                path = "~/vaults/work",
            },
        },

        -- see below for full list of options 👇
    },
}
