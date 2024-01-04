local Plugin = {'nvim-treesitter/nvim-treesitter'}

Plugin.dependencies = {
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    { "nvim-treesitter/nvim-treesitter-context" },
}

-- :help nvim-treesitter-modules
Plugin.opts = {
    sync_install = false,
    auto_install = true,
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "go",
        "graphql",
        "bash",
        "json",
        "markdown",
        "proto",
        "rust",
        "toml",
        "yaml"
    },
    ignore_install = {"all"},
    highlight = {
        enable = true,
        disable = {},
        textobjects = { enable = true },
        additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

function Plugin.config(name, opts)
  require('nvim-treesitter.configs').setup(opts)
  require('treesitter-context').setup {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
end

return Plugin


