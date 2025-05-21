local Plugin = {
    "OXY2DEV/markview.nvim",
    lazy = false,
};

function Plugin.config()
    local presets = require("markview.presets");
    require("markview").setup({
        markdown = {
            headings = presets.headings.glow,
            horizontal_rules = presets.horizontal_rules.thin,
            tables = presets.tables.single,
        },
        -- preview = {
        --     enable = true,
        --     filetypes = { "markdown", "md" },
        -- }
    })
end

return Plugin
