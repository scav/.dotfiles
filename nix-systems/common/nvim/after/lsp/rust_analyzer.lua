---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "check",
            },
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    },
}
