local Plugin = {
    "scav/peek.nvim",
    --    dir = "Users/dag/projects/github/nvim-plugins/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
}

function Plugin.config()
    require("peek").setup({
        syntax = true,
        filetype = { "markdown", "mermaid", "mmd" },
    })
    -- refer to `configuration to change defaults`
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

return Plugin
