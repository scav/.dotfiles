local Plugin = {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }
}

function Plugin.config()
    require("oil").setup({
        view_options = {
            show_hidden = true,
        },
        natural_order = true,
    })

    vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Open dir" })
end

return Plugin
