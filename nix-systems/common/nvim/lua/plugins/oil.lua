return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    opts = {
        default_file_explorer = true,
        delete_to_trash = false, -- yolo
        columns = {
            "icon",
            -- "mtime",
            -- "size",
        },
        lsp_file_methods = {
            enabled = true,
            timeout_ms = 1000,
            autosave_changes = true,
        },
        view_options = {
            natural_order = true,
            show_hidden = true,
        },
        watch_for_changes = true,
    },
    keys = {
        keys = {
            { "n", "<leader>pv", "<cmd>Oil<cr>", desc = "oil" },
        },
    },
    config = function()
        require("oil").setup({
            vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Open dir" })

        })
    end

}
