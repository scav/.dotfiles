return {
    "telescope.nvim",
    dependencies = {
        "telescope-fzf-native.nvim",
        "telescope-ui-select.nvim",
        "telescope-undo.nvim",
        "plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files()
            end,
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep()
            end,
        },
        {
            "<leader>u",
            "<cmd>Telescope undo<cr>",
        },
    },
    config = function()
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
        -- telescope.load_extension("rest")

        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- Avoid these files and folders
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup({
            defaults = {
                vimgrep_arguments = vimgrep_arguments,
                preview = {
                    treesitter = false,
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    -- theme = "ivy",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        -- even more opts
                    }),
                },
                undo = {
                    -- telescope-undo.nvim config, see below
                },
            },
        })
    end,
}
