local Plugin = { 'cuducos/yaml.nvim' }

Plugin.dependencies = {
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-telescope/telescope.nvim' },
}

function Plugin.config()
    local yaml = require("yaml_nvim")

    yaml.setup({ ft = { "yaml" } })

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
        pattern = { "*.yaml" },
        callback = function()
            vim.opt_local.winbar = yaml.get_yaml_key_and_value()
        end
    })
end

return Plugin
