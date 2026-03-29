return {
    {
        "vim-dadbod-ui",
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        beforeAll = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        "vim-dadbod-completion",
        lazy = true,
        ft = { "sql", "plsql" },
    },
    {
        "vim-dadbod",
        lazy = true,
    },
}
