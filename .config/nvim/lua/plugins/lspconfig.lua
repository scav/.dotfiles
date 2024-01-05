local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'lukas-reineke/lsp-format.nvim' }
}

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspUnInstall' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

function Plugin.init()
    require('lsp-format').setup {}
    local sign = function(opts)
        -- See :help sign_define()
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = ''
        })
    end

    sign({ name = 'DiagnosticSignError', text = '✘' })
    sign({ name = 'DiagnosticSignWarn', text = '▲' })
    sign({ name = 'DiagnosticSignHint', text = '⚑' })
    sign({ name = 'DiagnosticSignInfo', text = '»' })

    -- See :help vim.diagnostic.config()
    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = 'always',
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
    )
end

function Plugin.config()
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = function(client, bufn)
        require('lsp-format').on_attach(client, bufnr)
    end
    local group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        desc = 'LSP actions',
        callback = user.on_attach
    })

    -- See :help mason-lspconfig-settings
    require('mason-lspconfig').setup({
        ensure_installed = {
            'lua_ls',
            'rust_analyzer',
            'gopls',
            'typos_lsp',
        },
        handlers = {
            -- See :help mason-lspconfig-dynamic-server-setup
            function(server)
                -- See :help lspconfig-setup
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            ['typos_lsp'] = function()
                lspconfig.typos_lsp.setup({
                    on_attach = on_attach,
                    capabilities = lsp_capabilities,
                    -- cmd = { "typos-lsp" },
                    -- filetypes = { "* " },
                    -- root_dir = {},
                    -- settings = {},
                    -- single_file_support = true,
                })
            end,
            ['lua_ls'] = function()
                require('plugins.lsp.lua_ls')
            end,
            ['gopls'] = function()
                lspconfig.gopls.setup({
                    on_attach = on_attach,
                    capabilities = lsp_capabilities,
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = false,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                })
            end,
            ['rust_analyzer'] = function()
                lspconfig.rust_analyzer.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
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
                                enable = true
                            },
                        },
                    },
                })
            end,
        }
    })
end

function user.on_attach()
    local opts = { buffer = true }

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Diagnostic Float" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

return Plugin
