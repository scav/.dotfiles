return {
    "vim-dadbod-ui",
    before = function()
        LZN.trigger_load("vim-dadbod-completion")
        LZN.trigger_load("vim-dadbod")
    end,
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    after = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}
