return {
    "nvim-lspconfig",
    -- cmd = { "LspInfo" },
    -- event = { "BufRead", "BufNewFile" },
    event = "DeferredUIEnter",
    keys = {
        {
            "<leader>vh",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            desc = "Toggle Inlay Hints",
        },
        {
            "<leader>f",
            function()
                vim.lsp.buf.format({ async = false })
            end,
            desc = "Format",
        },
        {
            "<leader>e",
            function()
                vim.diagnostic.open_float()
            end,
            desc = "Diagnostic Float",
        },
        {
            "<leader>K",
            function()
                vim.lsp.buf.hover()
            end,
            desc = "Hover",
        },

    },
    after = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
