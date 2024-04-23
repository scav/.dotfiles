local Plugin = {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = false,
}

Plugin.dependencies = {
    {
        'luarocks.nvim',
        priority = 1000,
        config = true,
    }
}

function Plugin.config()
    require("neorg").setup {
        load = {
            ["core.defaults"] = {},
            ["core.integrations.treesitter"] = {
                config = {
                    configure_parsers = true,
                    install_parsers = true,
                },
            },
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/notes/work",
                        home = "~/notes/home",
                    }
                }
            }
        }
    }
end

return Plugin
