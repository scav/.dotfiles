---@type vim.lsp.Config
return {
    settings = {
        ['rust-analyzer'] = {
            cmd = { 'rust-analyzer' },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },

    }
}
