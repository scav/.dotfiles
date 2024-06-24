local Plugin = {
    "allaman/kustomize.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "yaml",
    opts = {
        build = {
            additional_args = { "--enable-alpha-plugins", "--enable-exec" }
        },
    },
}

return Plugin
