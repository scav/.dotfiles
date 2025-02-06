local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require("lsp-format").setup {}
-- local on_attach = function(client, bufnr)
--     require("lsp-format").on_attach(client, bufnr)
-- end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = lsp_capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = 'LuaJIT',
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                library = {
                    -- Make the server aware of Neovim runtime files
                    vim.fn.expand('$VIMRUNTIME/lua'),
                    vim.fn.stdpath('config') .. '/lua'
                },
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            },
        }
    }
})
