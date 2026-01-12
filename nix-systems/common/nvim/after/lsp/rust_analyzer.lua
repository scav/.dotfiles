---@type vim.lsp.Config
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
    cmd = { 'rust-analyzer' },
    capabilities = lsp_capabilities,
    ['rust-analyzer'] = {
        settings = {
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
        },
    }
}
