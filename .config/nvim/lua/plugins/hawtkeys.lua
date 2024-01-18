local Plugin = {
    "tris203/hawtkeys.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
}

function Plugin.opts()
end

function Plugin.config()
    local hawtkeys = require('hawtkeys')
    hawtkeys.setup {}

    vim.keymap.set("n", "<leader>hk", ":Hawtkeys<CR>")
    vim.keymap.set("n", "<leader>hkk", ":HawtkeysAll<CR>")
    vim.keymap.set("n", "<leader>hkd", ":HawtkeysDupes<CR>")
end

return Plugin
