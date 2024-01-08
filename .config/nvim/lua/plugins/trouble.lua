local Plugin = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

function Plugin.ini()
end

function Plugin.config()
    local trouble = require("trouble")

    vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
end

return Plugin
