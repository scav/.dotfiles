local function treesitter_status()
    local highlighter = require("vim.treesitter.highlighter")
    local buf = vim.api.nvim_get_current_buf()

    local has_parser = pcall(function()
        return vim.treesitter.get_parser(buf):lang()
    end)

    if not has_parser then return ": ✗" end
    if highlighter.active[buf] then return ": ✓" end
    return ": ○"
end

return {
    'lualine.nvim',
    event = "DeferredUIEnter",
    lazy = false,
    before = function()
        LZN.trigger_load("nvim-web-devicons")
    end,
    after = function()
        require("lualine").setup({

            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    { 'filename', path = 1 }
                },
                lualine_x = { 'rest', 'encoding', 'fileformat', 'filetype', treesitter_status },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            refresh = {
                statusline = 10,


            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = { 'fugitive', 'fzf' }
        })
    end,
}
