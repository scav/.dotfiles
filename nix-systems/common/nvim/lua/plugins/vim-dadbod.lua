return {
    'vim-dadbod-ui',
    dependencies = {
        { 'vim-dadbod',                     lazy = true },
        { 'vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd =
    {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    configure = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end
}
