return {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo' },
    event = { 'BufRead', 'BufNewFile' },
    keys = {
        {
            "<leader>vh",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            desc = "LSP: Toggle Inlay Hints",

        },
        { "<leader>f", function() vim.lsp.buf.format({ async = false }) end, desc = "LSP: Format" },
    },
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
