return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    event = "VeryLazy",
    opts = {},
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
            "<leader>u", "<cmd>Telescope undo<cr>"
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
        -- telescope.load_extension("rest")

        local telescopeConfig = require("telescope.config")
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- Avoid these files and folders
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup({
            defaults = {
                -- border = true, -- temp workaround for nvim-v.11.0 => vim.o.winborder = 'rounded'
                -- vimgrep_arguments = vimgrep_arguments,
                -- buffer_previewer_maker = new_maker,
                preview = {
                    treesitter = false,
                },
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = {
                        'rg',
                        '-l',
                        '.*',
                        '--follow',
                        '--hidden',
                        '--no-ignore-vcs',
                        '--glob',
                        '!node_modules/*',
                        '--glob',
                        '!target/*',
                        '--glob',
                        '!dist/*',
                        '--glob',
                        '!.*/',
                    },
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
