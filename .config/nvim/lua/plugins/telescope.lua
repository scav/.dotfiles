local Plugin = { 'nvim-telescope/telescope.nvim' }

Plugin.branch = '0.1.x'

Plugin.dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'gmake' },
    { 'nvim-telescope/telescope-ui-select.nvim' }
}

Plugin.cmd = { 'Telescope' }

function Plugin.init()
    vim.keymap.set('n', '<leader>ff', '<CMD>Telescope find_files<CR>', { desc = "Find files" })
    vim.keymap.set('n', '<leader>fg', '<CMD>Telescope live_grep<CR>', { desc = "Grep files" })
    vim.keymap.set('n', '<leader>fb', '<CMD>Telescope buffers<CR>', { desc = "Find buffer" })
    vim.keymap.set('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', { desc = "Find helptags" })
    vim.keymap.set('n', '<leader>fc', '<CMD>Telescope git_files<CR>', { desc = "Find git files" })
end

-- Avoid grepping preview in binaries
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    local previewers = require("telescope.previewers")
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe write to the buffer if we like?
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end
    }):sync()
end

function Plugin.config()
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension("rest")

    local telescopeConfig = require("telescope.config")
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- Avoid these files and folders
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
        defaults = {
            vimgrep_arguments = vimgrep_arguments,
            buffer_previewer_maker = new_maker,
            preview = {
                treesitter = false
            }
        },
        pickers = {
            find_files = {
                -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
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
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }
            }
        }
    })
end

return Plugin
