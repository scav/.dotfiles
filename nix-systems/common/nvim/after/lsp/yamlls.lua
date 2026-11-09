vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
        vim.opt_local.spell = false
    end,
})

return {
    vim.lsp.config("yamlls", {
        settings = {
            yaml = {
                validate = true,
                schemaStore = {
                    enable = true,
                },
            },
        },
    }),
}
