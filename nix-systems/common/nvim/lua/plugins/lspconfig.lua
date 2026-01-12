return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo" },
    event = { "BufRead", "BufNewFile" },
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
    config = function()
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, { desc = "Go to definition" })

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic Float" })
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
