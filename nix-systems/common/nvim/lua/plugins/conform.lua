return {
    "conform.nvim",
    opts = {
        formatters_by_ft = {
            templ = { "templ" },
            lua = { "stylua" },
            nix = { "nixfmt" },
            -- go = { "gofumpt", lsp_format = "fallback" },
        },
        format_on_save = function()
            local c = require('conform')
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    c.format({ bufnr = args.buf })
                end,
            })
        end,
    }
}
