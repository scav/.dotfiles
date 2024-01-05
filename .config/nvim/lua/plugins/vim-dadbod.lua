local Plugin = {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
}

function Plugin.init()
    vim.g.db_ui_use_nerd_fonts = 1
end

function Plugin.setup()
end

function Plugin.cmd()
    return {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    }
end

return Plugin
