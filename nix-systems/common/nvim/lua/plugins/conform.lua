vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

return {
    "conform.nvim",
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                templ = { "templ" },
                lua = { "stylua" },
                nix = { "nixfmt" },
                json = { "oxfmt" },
                jsonc = { "oxfmt" },
                css = { "oxfmt" },
                -- go = { "gofumpt", lsp_format = "fallback" },
            },
        })
    end,
}
