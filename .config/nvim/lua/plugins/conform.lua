local Plugin = { 'stevearc/conform.nvim' }


Plugin.setup = {
    formatters_by_ft = {
        templ = { "templ" },
        lua = { "stylua" }
    },
    format_on_save = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                Plugin.format({ bufnr = args.buf })
            end,
        })
    end
}

return Plugin
