local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },
}

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspUnInstall' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

function Plugin.init()
    -- local sign = function(opts)
    --     -- :help sign_define()
    --     vim.fn.sign_define(opts.name, {
    --         texthl = opts.name,
    --         text = opts.text,
    --         numhl = ''
    --     })
    --
    --     vim.diagnostic.config(opts,)
    -- end
    -- sign({ name = 'DiagnosticSignError', text = '✘' })
    -- sign({ name = 'DiagnosticSignWarn', text = '▲' })
    -- sign({ name = 'DiagnosticSignHint', text = '⚑' })
    -- sign({ name = 'DiagnosticSignInfo', text = '»' })

    -- :help vim.diagnostic.config()
    vim.diagnostic.config({
        virtual_text = {
            current_line = true,
        },
        severity_sort = true,
        float = {
            border = 'rounded',
            source = 'if_many',
        },
    })
end

function Plugin.config()
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
    local group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

    vim.filetype.add({ extension = { templ = "templ" } })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        desc = 'LSP actions',
        callback = user.on_attach
    })

    -- :help mason-lspconfig-settings
    require('mason-lspconfig').setup({
        ensure_installed = {
            'dockerls',
            'bashls',
            'lua_ls',
            'rust_analyzer',
            'gopls',
            'gh_actions_ls',
            'buf_ls',
            'ts_ls',
            'jsonls',
            'yamlls',
            'html',
            'htmx',
            'tailwindcss',
            'templ',
            'zls'
        },
        handlers = {
            -- :help mason-lspconfig-dynamic-server-setup
            function(server)
                -- :help lspconfig-setup
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            ['bashls'] = function()
                lspconfig.bashls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    filetypes = { 'bash', 'sh', 'zsh' },
                })
            end,
            ['dockerls'] = function()
                lspconfig.dockerls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                })
            end,
            ['buf_ls'] = function()
                lspconfig.buf_ls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                })
            end,
            ['jsonls'] = function()
                lspconfig.jsonls.setup({
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas {
                                extra = {
                                    {
                                        description = 'dokkenizer schema',
                                        fileMatch = 'manifest.yaml',
                                        name = 'manifest.yaml',
                                        url = '/Users/dag/projects/tv2/dokkenizerv2/schema.json',
                                    },
                                    {
                                        description = 'goreleaser schema',
                                        fileMatch = '.goreleaser.yaml',
                                        name = '.goreleaser.yaml',
                                        url = 'https://goreleaser.com/static/schema.json',
                                    },

                                },
                            },
                            validate = { enable = true },
                        },
                    },
                })
            end,
            ['yamlls'] = function()
                lspconfig.yamlls.setup({
                    settings = {
                        yaml = {
                            schemaStore = {
                                -- You must disable built-in schemaStore support if you want to use
                                -- this plugin and its advanced options like `ignore`.
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                            schemas = require('schemastore').yaml.schemas {
                                extra = {
                                    {
                                        description = 'dokkenizer schema',
                                        fileMatch = 'manifest.yaml',
                                        name = 'manifest.yaml',
                                        url = '/Users/dag/projects/tv2/dokkenizerv2/schema.json',
                                    },
                                },
                            },
                        },
                    },
                })
            end,
            ['ts_ls'] = function()
                lspconfig.ts_ls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
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
                                shadow = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                            hints = {
                                rangeVariableTypes = true,
                                parameterNames = true,
                                constantValues = true,
                                assignVariableTypes = false,
                                compositeLiteralFields = false,
                                compositeLiteralTypes = true,
                                functionTypeParameters = false,
                            },
                        },
                    },
                })
            end,
            ['gh_actions_ls'] = function()
                lspconfig.gopls.setup({
                    on_attach = on_attach,
                    capabilities = lsp_capabilities,
                })
            end,
            ['rust_analyzer'] = function()
                lspconfig.rust_analyzer.setup({
                    on_attach = on_attach,
                    capabilities = lsp_capabilities,
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
                                enable = true
                            },
                        },
                    },
                })
            end,
            ['zls'] = function()
                lspconfig.gopls.setup({
                    on_attach = on_attach,
                    capabilities = lsp_capabilities,
                })
            end,
            ['html'] = function()
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                lspconfig.html.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    filetypes = { "html" },
                    init_options = {
                        providedFormatter = false,
                    }
                })
            end,
            ['htmx'] = function()
                lspconfig.htmx.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    filetypes = { "html", "templ" },
                })
            end,
            ['tailwindcss'] = function()
                lspconfig.tailwindcss.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    filetypes = { "html", "templ" },
                    init_options = { userLanguages = { templ = "html" } },
                })
            end,
            ['templ'] = function()
                lspconfig.templ.setup({
                    capabilities = lsp_capabilities,
                    on_attach = on_attach,
                    cmd = { "templ", "lsp" },
                    filetypes = { "templ" },
                })
            end,
        }
    })
end

function user.on_attach()
    local opts = { buffer = true }

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
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = false }
    end, opts)
    vim.keymap.set('n', '<Leader>vh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { desc = "Toggle Inlay Hints" })
    end, opts)

    -- Auto format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
end

return Plugin
